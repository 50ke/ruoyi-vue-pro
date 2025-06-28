package cn.iocoder.yudao.module.courier.service.auth;

import cn.iocoder.yudao.module.courier.controller.app.auth.vo.*;

import jakarta.validation.Valid;

/**
 * 配送员的认证 Service 接口
 *
 * 提供配送员的账号密码登录、token 的校验等认证相关的功能
 *
 * @author 芋道源码
 */
public interface CourierAuthService {

    /**
     * 用户名 + 密码登录
     *
     * @param reqVO 登录信息
     * @return 登录结果
     */
    AppAuthLoginRespVO login(@Valid AppAuthLoginReqVO reqVO);

    /**
     * 基于 token 退出登录
     *
     * @param token token
     */
    void logout(String token);

    /**
     * 手机 + 验证码登陆
     *
     * @param reqVO    登陆信息
     * @return 登录结果
     */
    AppAuthLoginRespVO smsLogin(@Valid AppAuthSmsLoginReqVO reqVO);

    /**
     * 给配送员发送短信验证码
     *
     * @param courierId 配送员编号
     * @param reqVO 发送信息
     */
    void sendSmsCode(Long courierId, AppAuthSmsSendReqVO reqVO);

    /**
     * 校验短信验证码是否正确
     *
     * @param courierId 配送员编号
     * @param reqVO 校验信息
     */
    void validateSmsCode(Long courierId, AppAuthSmsValidateReqVO reqVO);

    /**
     * 重置密码
     *
     * @param reqVO 重置密码信息
     */
    void resetPassword(@Valid AppAuthResetPasswordReqVO reqVO);

    /**
     * 刷新访问令牌
     *
     * @param refreshToken 刷新令牌
     * @return 登录结果
     */
    AppAuthLoginRespVO refreshToken(String refreshToken);

} 