package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.common.exception.ServiceException;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserPageReqVO;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.dal.mysql.user.CourierUserMapper;
import cn.iocoder.yudao.module.courier.enums.ErrorCodeConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;
import java.time.LocalDateTime;

import static cn.iocoder.yudao.module.courier.enums.ErrorCodeConstants.*;


/**
 * 配送员用户 Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Validated
@Slf4j
public class CourierUserServiceImpl implements CourierUserService {

    @Resource
    private CourierUserMapper courierUserMapper;
    @Resource
    private PasswordEncoder passwordEncoder;

    @Override
    public Long createUser(CourierUserDO createReqVO) {
        // 1. 校验用户名唯一性
        validateUsernameUnique(null, createReqVO.getUsername());
        // 2. 校验手机号唯一性
        validateMobileUnique(null, createReqVO.getMobile());

        // 3. 插入
        CourierUserDO courier = BeanUtils.toBean(createReqVO, CourierUserDO.class);
        courier.setPassword(passwordEncoder.encode(createReqVO.getPassword()));
        courier.setStatus(CommonStatusEnum.ENABLE.getStatus());
        courier.setScore(new java.math.BigDecimal("5.0")); // 默认评分5.0
        courier.setWorkStatus(0); // 默认休息中
        courierUserMapper.insert(courier);
        return courier.getId();
    }

    @Override
    public void updateUser(CourierUserUpdateReqVO updateReqVO) {
        // 1. 校验存在
        validateUserExists(updateReqVO.getId());
        // 2. 校验用户名唯一性
        validateUsernameUnique(updateReqVO.getId(), updateReqVO.getUsername());
        // 3. 校验手机号唯一性
        validateMobileUnique(updateReqVO.getId(), updateReqVO.getMobile());

        // 4. 更新
        CourierUserDO updateObj = BeanUtils.toBean(updateReqVO, CourierUserDO.class);
        courierUserMapper.updateById(updateObj);
    }

    @Override
    public void deleteUser(Long id) {
        // 1. 校验存在
        validateUserExists(id);
        // 2. 删除
        courierUserMapper.deleteById(id);
    }

    private void validateUserExists(Long id) {
        if (courierUserMapper.selectById(id) == null) {
            throw new ServiceException(ErrorCodeConstants.USER_NOT_EXISTS);
        }
    }

    private void validateUsernameUnique(Long id, String username) {
        if (username == null) {
            return;
        }
        CourierUserDO user = courierUserMapper.selectByUsername(username);
        if (user == null) {
            return;
        }
        // 如果 id 为空，说明不用比较是否为相同 id 的配送员
        if (id == null) {
            throw new ServiceException(USER_USERNAME_EXISTS);
        }
        if (!user.getId().equals(id)) {
            throw new ServiceException(USER_USERNAME_EXISTS);
        }
    }

    private void validateMobileUnique(Long id, String mobile) {
        if (mobile == null) {
            return;
        }
        CourierUserDO user = courierUserMapper.selectByMobile(mobile);
        if (user == null) {
            return;
        }
        // 如果 id 为空，说明不用比较是否为相同 id 的配送员
        if (id == null) {
            throw new ServiceException(USER_MOBILE_EXISTS);
        }
        if (!user.getId().equals(id)) {
            throw new ServiceException(USER_MOBILE_EXISTS);
        }
    }

    @Override
    public CourierUserDO getUser(Long id) {
        return courierUserMapper.selectById(id);
    }

    @Override
    public PageResult<CourierUserDO> getUserPage(CourierUserPageReqVO pageReqVO) {
        return courierUserMapper.selectPage(pageReqVO);
    }

    @Override
    public CourierUserDO getUserByUsername(String username) {
        return courierUserMapper.selectByUsername(username);
    }

    @Override
    public CourierUserDO getUserByMobile(String mobile) {
        return courierUserMapper.selectByMobile(mobile);
    }

    @Override
    public void updateUserLogin(Long id, String loginIp) {
        CourierUserDO updateObj = new CourierUserDO();
        updateObj.setId(id);
        updateObj.setLoginIp(loginIp);
        updateObj.setLoginDate(LocalDateTime.now());
        courierUserMapper.updateById(updateObj);
    }

    @Override
    public void updateUserPassword(Long id, String password) {
        // 1. 校验存在
        validateUserExists(id);
        // 2. 更新密码
        CourierUserDO updateObj = new CourierUserDO();
        updateObj.setId(id);
        updateObj.setPassword(passwordEncoder.encode(password));
        courierUserMapper.updateById(updateObj);
    }

    @Override
    public void updateUserWorkStatus(Long id, Integer workStatus) {
        // 1. 校验存在
        validateUserExists(id);
        // 2. 更新工作状态
        CourierUserDO updateObj = new CourierUserDO();
        updateObj.setId(id);
        updateObj.setWorkStatus(workStatus);
        courierUserMapper.updateById(updateObj);
    }

    @Override
    public boolean isPasswordMatch(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

} 