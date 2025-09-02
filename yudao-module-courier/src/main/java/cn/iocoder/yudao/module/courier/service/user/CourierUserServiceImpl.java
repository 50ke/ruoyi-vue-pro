package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.dal.mysql.user.CourierUserMapper;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 配送员 User Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Valid
@Slf4j
public class CourierUserServiceImpl implements CourierUserService {

    @Resource
    private CourierUserMapper courierUserMapper;

    @Override
    public CourierUserDO getUser(Long id) {
        return courierUserMapper.selectById(id);
    }

    @Override
    public CourierUserDO getByMobile(String mobile) {
        return courierUserMapper.selectByMobile(mobile);
    }

    @Override
    public void updateUser(Long userId, AppCourierUserUpdateReqVO reqVO) {
        CourierUserDO updateObj = BeanUtils.toBean(reqVO, CourierUserDO.class).setId(userId);
        courierUserMapper.updateById(updateObj);
    }
}
