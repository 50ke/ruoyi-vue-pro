package cn.iocoder.yudao.module.courier.service.auth;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.common.enums.UserTypeEnum;
import cn.iocoder.yudao.framework.common.util.monitor.TracerUtils;
import cn.iocoder.yudao.framework.common.util.servlet.ServletUtils;
import cn.iocoder.yudao.framework.common.biz.system.oauth2.OAuth2TokenCommonApi;
import cn.iocoder.yudao.framework.common.biz.system.oauth2.dto.OAuth2AccessTokenCreateReqDTO;
import cn.iocoder.yudao.framework.common.biz.system.oauth2.dto.OAuth2AccessTokenRespDTO;
import cn.iocoder.yudao.module.courier.controller.app.auth.vo.*;
import cn.iocoder.yudao.module.courier.convert.auth.AuthConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import cn.iocoder.yudao.module.system.api.logger.LoginLogApi;
import cn.iocoder.yudao.module.system.api.logger.dto.LoginLogCreateReqDTO;
import cn.iocoder.yudao.module.system.api.sms.SmsCodeApi;
import cn.iocoder.yudao.module.system.enums.logger.LoginLogTypeEnum;
import cn.iocoder.yudao.module.system.enums.logger.LoginResultEnum;
import cn.iocoder.yudao.module.system.enums.oauth2.OAuth2ClientConstants;
import cn.iocoder.yudao.module.system.enums.sms.SmsSceneEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.Resource;
import java.util.Objects;

import static cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil.exception;
import static cn.iocoder.yudao.framework.common.util.servlet.ServletUtils.getClientIP;
import static cn.iocoder.yudao.module.courier.enums.ErrorCodeConstants.*;


/**
 * 配送员的认证 Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Slf4j
public class CourierAuthServiceImpl implements CourierAuthService {

    @Resource
    private CourierUserService courierUserService;
    @Resource
    private SmsCodeApi smsCodeApi;
    @Resource
    private LoginLogApi loginLogApi;
    @Resource
    private OAuth2TokenCommonApi oauth2TokenApi;

    @Override
    public AppAuthLoginRespVO login(AppAuthLoginReqVO reqVO) {
        // 使用用户名 + 密码，进行登录。
        CourierUserDO courier = login0(reqVO.getUsername(), reqVO.getPassword());

        // 创建 Token 令牌，记录登录日志
        return createTokenAfterLoginSuccess(courier, courier.getMobile(), LoginLogTypeEnum.LOGIN_USERNAME);
    }

    @Override
    @Transactional
    public AppAuthLoginRespVO smsLogin(AppAuthSmsLoginReqVO reqVO) {
        // 校验验证码
        String userIp = getClientIP();
        smsCodeApi.useSmsCode(AuthConvert.INSTANCE.convert(reqVO, SmsSceneEnum.COURIER_LOGIN.getScene(), userIp));

        // 获得配送员用户
        CourierUserDO courier = courierUserService.getUserByMobile(reqVO.getMobile());
        if (courier == null) {
            createLoginLog(null, reqVO.getMobile(), LoginLogTypeEnum.LOGIN_SMS, LoginResultEnum.BAD_CREDENTIALS);
            throw exception(AUTH_LOGIN_BAD_CREDENTIALS);
        }

        // 校验是否禁用
        if (CommonStatusEnum.isDisable(courier.getStatus())) {
            createLoginLog(courier.getId(), reqVO.getMobile(), LoginLogTypeEnum.LOGIN_SMS, LoginResultEnum.USER_DISABLED);
            throw exception(AUTH_LOGIN_USER_DISABLED);
        }

        // 创建 Token 令牌，记录登录日志
        return createTokenAfterLoginSuccess(courier, reqVO.getMobile(), LoginLogTypeEnum.LOGIN_SMS);
    }

    private AppAuthLoginRespVO createTokenAfterLoginSuccess(CourierUserDO courier, String mobile,
                                                            LoginLogTypeEnum logType) {
        // 插入登陆日志
        createLoginLog(courier.getId(), mobile, logType, LoginResultEnum.SUCCESS);
        // 创建 Token 令牌
        OAuth2AccessTokenRespDTO accessTokenRespDTO = oauth2TokenApi.createAccessToken(new OAuth2AccessTokenCreateReqDTO()
                .setUserId(courier.getId()).setUserType(getUserType().getValue())
                .setClientId(OAuth2ClientConstants.CLIENT_ID_DEFAULT));
        // 构建返回结果
        return AuthConvert.INSTANCE.convert(accessTokenRespDTO, courier);
    }

    private CourierUserDO login0(String username, String password) {
        final LoginLogTypeEnum logTypeEnum = LoginLogTypeEnum.LOGIN_USERNAME;
        // 校验账号是否存在
        CourierUserDO courier = courierUserService.getUserByUsername(username);
        if (courier == null) {
            createLoginLog(null, username, logTypeEnum, LoginResultEnum.BAD_CREDENTIALS);
            throw exception(AUTH_LOGIN_BAD_CREDENTIALS);
        }
        if (!courierUserService.isPasswordMatch(password, courier.getPassword())) {
            createLoginLog(courier.getId(), username, logTypeEnum, LoginResultEnum.BAD_CREDENTIALS);
            throw exception(AUTH_LOGIN_BAD_CREDENTIALS);
        }
        // 校验是否禁用
        if (CommonStatusEnum.isDisable(courier.getStatus())) {
            createLoginLog(courier.getId(), username, logTypeEnum, LoginResultEnum.USER_DISABLED);
            throw exception(AUTH_LOGIN_USER_DISABLED);
        }
        return courier;
    }

    private void createLoginLog(Long userId, String username, LoginLogTypeEnum logType, LoginResultEnum loginResult) {
        // 插入登录日志
        LoginLogCreateReqDTO reqDTO = new LoginLogCreateReqDTO();
        reqDTO.setLogType(logType.getType());
        reqDTO.setTraceId(TracerUtils.getTraceId());
        reqDTO.setUserId(userId);
        reqDTO.setUserType(getUserType().getValue());
        reqDTO.setUsername(username);
        reqDTO.setUserAgent(ServletUtils.getUserAgent());
        reqDTO.setUserIp(getClientIP());
        reqDTO.setResult(loginResult.getResult());
        loginLogApi.createLoginLog(reqDTO);
        // 更新最后登录时间
        if (userId != null && Objects.equals(LoginResultEnum.SUCCESS.getResult(), loginResult.getResult())) {
            courierUserService.updateUserLogin(userId, getClientIP());
        }
    }

    @Override
    public void logout(String token) {
        // 删除访问令牌
        OAuth2AccessTokenRespDTO accessTokenRespDTO = oauth2TokenApi.removeAccessToken(token);
        if (accessTokenRespDTO == null) {
            return;
        }
        // 删除成功，则记录登出日志
        createLogoutLog(accessTokenRespDTO.getUserId());
    }

    @Override
    public void sendSmsCode(Long courierId, AppAuthSmsSendReqVO reqVO) {
        // 情况 1：如果是登录场景，需要校验手机号是存在的
        if (Objects.equals(reqVO.getScene(), SmsSceneEnum.COURIER_LOGIN.getScene())) {
            CourierUserDO courier = courierUserService.getUserByMobile(reqVO.getMobile());
            if (courier == null) {
                throw exception(USER_MOBILE_NOT_EXISTS);
            }
        }
        // 情况 2：如果是重置密码场景，需要校验手机号是存在的
        if (Objects.equals(reqVO.getScene(), SmsSceneEnum.COURIER_RESET_PASSWORD.getScene())) {
            CourierUserDO courier = courierUserService.getUserByMobile(reqVO.getMobile());
            if (courier == null) {
                throw exception(USER_MOBILE_NOT_EXISTS);
            }
        }
        // 情况 3：如果是忘记密码场景，courierId 为空，需要校验手机号是存在的
        if (courierId == null) {
            CourierUserDO courier = courierUserService.getUserByMobile(reqVO.getMobile());
            if (courier == null) {
                throw exception(USER_MOBILE_NOT_EXISTS);
            }
        }

        // 执行发送
        smsCodeApi.sendSmsCode(AuthConvert.INSTANCE.convert(reqVO).setCreateIp(getClientIP()));
    }

    @Override
    public void validateSmsCode(Long courierId, AppAuthSmsValidateReqVO reqVO) {
        // 如果是忘记密码场景，courierId 为空，不需要校验
        if (courierId != null) {
            // 校验配送员是否存在
            CourierUserDO courier = courierUserService.getUser(courierId);
            if (courier == null) {
                throw exception(USER_NOT_EXISTS);
            }
        }
        smsCodeApi.validateSmsCode(AuthConvert.INSTANCE.convert(reqVO));
    }

    @Override
    public void resetPassword(AppAuthResetPasswordReqVO reqVO) {
        // 校验验证码
        smsCodeApi.useSmsCode(AuthConvert.INSTANCE.convert(reqVO, SmsSceneEnum.COURIER_RESET_PASSWORD.getScene(), getClientIP()));

        // 获取配送员信息
        CourierUserDO courier = courierUserService.getUserByMobile(reqVO.getMobile());
        if (courier == null) {
            throw exception(AUTH_LOGIN_BAD_CREDENTIALS);
        }

        // 更新密码
        courierUserService.updateUserPassword(courier.getId(), reqVO.getPassword());
    }

    @Override
    public AppAuthLoginRespVO refreshToken(String refreshToken) {
        OAuth2AccessTokenRespDTO accessTokenDO = oauth2TokenApi.refreshAccessToken(refreshToken,
                OAuth2ClientConstants.CLIENT_ID_DEFAULT);
        return AuthConvert.INSTANCE.convert(accessTokenDO);
    }

    private void createLogoutLog(Long userId) {
        LoginLogCreateReqDTO reqDTO = new LoginLogCreateReqDTO();
        reqDTO.setLogType(LoginLogTypeEnum.LOGOUT_SELF.getType());
        reqDTO.setTraceId(TracerUtils.getTraceId());
        reqDTO.setUserId(userId);
        reqDTO.setUserType(getUserType().getValue());
        reqDTO.setUsername(getUsername(userId));
        reqDTO.setUserAgent(ServletUtils.getUserAgent());
        reqDTO.setUserIp(getClientIP());
        reqDTO.setResult(LoginResultEnum.SUCCESS.getResult());
        loginLogApi.createLoginLog(reqDTO);
    }

    private String getUsername(Long userId) {
        if (userId == null) {
            return null;
        }
        CourierUserDO courier = courierUserService.getUser(userId);
        return courier != null ? courier.getUsername() : null;
    }

    private UserTypeEnum getUserType() {
        return UserTypeEnum.COURIER;
    }

} 