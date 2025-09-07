package cn.iocoder.yudao.module.courier.api.user;

import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;
import cn.iocoder.yudao.module.courier.convert.user.CourierUserConvert;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.List;

@Service
@Validated
public class CourierUserApiImpl implements CourierUserApi{

    @Resource
    private CourierUserService courierUserService;

    @Override
    public List<CourierUserRespDTO> getCourierListByMerchantStoreId(Long merchantId, Long pickUpStoreId) {
        return CourierUserConvert.INSTANCE.convertList(courierUserService.getListByMerchantStoreId(merchantId, pickUpStoreId));
    }

    @Override
    public List<CourierUserRespDTO> getCourierListByMerchantId(Long merchantId) {
        return CourierUserConvert.INSTANCE.convertList(courierUserService.getListByMerchantId(merchantId));
    }
}
