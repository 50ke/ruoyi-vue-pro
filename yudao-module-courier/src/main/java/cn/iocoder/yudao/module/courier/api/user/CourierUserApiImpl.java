package cn.iocoder.yudao.module.courier.api.user;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserCreateReqDTO;
import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;
import cn.iocoder.yudao.module.courier.convert.user.CourierUserConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserStoreDO;
import cn.iocoder.yudao.module.courier.enums.CourierWorkStatusEnum;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import cn.iocoder.yudao.module.courier.service.user.CourierUserStoreService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.List;

@Service
@Validated
public class CourierUserApiImpl implements CourierUserApi{

    @Resource
    private CourierUserService courierUserService;

    @Resource
    private CourierUserStoreService courierUserStoreService;

    @Override
    public List<CourierUserRespDTO> getCourierListByMerchantStoreId(Long merchantId, Long pickUpStoreId) {
        return CourierUserConvert.INSTANCE.convertList(courierUserService.getListByMerchantStoreId(merchantId, pickUpStoreId));
    }

    @Override
    public List<CourierUserRespDTO> getCourierListByMerchantId(Long merchantId) {
        return CourierUserConvert.INSTANCE.convertList(courierUserService.getListByMerchantId(merchantId));
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long createCourier(CourierUserCreateReqDTO reqDTO) {
        CourierUserDO courierUserDO = new CourierUserDO();
        courierUserDO.setNickname(reqDTO.getNickname());
        courierUserDO.setMobile(reqDTO.getMobile());
        courierUserDO.setAvatar(reqDTO.getAvatar());
        courierUserDO.setStatus(CommonStatusEnum.DISABLE.getStatus());
        courierUserDO.setWorkStatus(CourierWorkStatusEnum.OFFLINE.getStatus());
        Long courierId = courierUserService.save(courierUserDO);

        List<CourierUserStoreDO> courierUserStoreDOList = reqDTO.getStoreId().stream().map(storeId -> {
            CourierUserStoreDO courierUserStoreDO = new CourierUserStoreDO();
            courierUserStoreDO.setCourierId(courierId);
            courierUserStoreDO.setMerchantId(reqDTO.getMerchantId());
            courierUserStoreDO.setStoreId(storeId);
            return courierUserStoreDO;
        }).toList();
        courierUserStoreService.save(courierUserStoreDOList);
        return courierId;
    }
}
