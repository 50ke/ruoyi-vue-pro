package cn.iocoder.yudao.module.courier.service.user;

import cn.hutool.core.collection.CollUtil;
import cn.iocoder.yudao.framework.common.util.collection.CollectionUtils;
import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserStoreDO;
import cn.iocoder.yudao.module.courier.dal.mysql.user.CourierUserMapper;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.courier.dal.mysql.user.CourierUserStoreMapper;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Set;

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

    @Resource
    private CourierUserStoreMapper courierUserStoreMapper;

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

    @Override
    public List<CourierUserDO> getListByMerchantStoreId(Long merchantId, Long pickUpStoreId) {
        List<CourierUserStoreDO> courierUserStoreDOList = courierUserStoreMapper.selectList(CourierUserStoreDO::getMerchantId, merchantId, CourierUserStoreDO::getStoreId, pickUpStoreId);
        if (CollUtil.isEmpty(courierUserStoreDOList)){
            return Collections.emptyList();
        }
        Set<Long> courierIds = CollectionUtils.convertSet(courierUserStoreDOList, CourierUserStoreDO::getCourierId);
        return courierUserMapper.selectByIds(courierIds);
    }

    @Override
    public List<CourierUserDO> getListByMerchantId(Long merchantId) {
        List<CourierUserStoreDO> courierUserStoreDOList = courierUserStoreMapper.selectList(CourierUserStoreDO::getMerchantId, merchantId);
        if (CollUtil.isEmpty(courierUserStoreDOList)){
            return Collections.emptyList();
        }
        Set<Long> courierIds = CollectionUtils.convertSet(courierUserStoreDOList, CourierUserStoreDO::getCourierId);
        return courierUserMapper.selectByIds(courierIds);
    }

    @Override
    public Long save(CourierUserDO courierUserDO) {
        courierUserMapper.insert(courierUserDO);
        return courierUserDO.getId();
    }

}
