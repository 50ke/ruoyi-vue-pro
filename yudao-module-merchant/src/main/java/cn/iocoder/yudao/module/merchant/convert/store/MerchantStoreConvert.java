package cn.iocoder.yudao.module.merchant.convert.store;

import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantStoreRespVO;
import cn.iocoder.yudao.module.trade.api.delivery.dto.TradeDeliveryPickUpStoreRespDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface MerchantStoreConvert {

    MerchantStoreConvert INSTANCE = Mappers.getMapper(MerchantStoreConvert.class);

    List<AppMerchantStoreRespVO> convertList(List<TradeDeliveryPickUpStoreRespDTO> pickUpStoreList);

    List<AppMerchantCourierRespVO> convertList1(List<CourierUserRespDTO> courierUserRespDTOList);
}
