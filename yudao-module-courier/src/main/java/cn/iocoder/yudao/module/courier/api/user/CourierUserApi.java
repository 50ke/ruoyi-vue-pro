package cn.iocoder.yudao.module.courier.api.user;

import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserCreateReqDTO;
import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;

import java.util.List;

public interface CourierUserApi {

    List<CourierUserRespDTO> getCourierListByMerchantStoreId(Long merchantId, Long pickUpStoreId);

    List<CourierUserRespDTO> getCourierListByMerchantId(Long merchantId);

    Long createCourier(CourierUserCreateReqDTO reqDTO);
}
