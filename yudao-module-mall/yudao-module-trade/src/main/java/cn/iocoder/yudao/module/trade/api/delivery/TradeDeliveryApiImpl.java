package cn.iocoder.yudao.module.trade.api.delivery;

import cn.iocoder.yudao.module.trade.api.delivery.dto.TradeDeliveryPickUpStoreRespDTO;
import cn.iocoder.yudao.module.trade.convert.delivery.DeliveryPickUpStoreConvert;
import cn.iocoder.yudao.module.trade.dal.dataobject.delivery.DeliveryPickUpStoreDO;
import cn.iocoder.yudao.module.trade.service.delivery.DeliveryPickUpStoreService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.Collection;
import java.util.List;

@Service
@Validated
public class TradeDeliveryApiImpl implements TradeDeliveryApi {

    @Resource
    private DeliveryPickUpStoreService deliveryPickUpStoreService;

    @Override
    public List<TradeDeliveryPickUpStoreRespDTO> getPickUpStoreList(Collection<Long> ids) {
        List<DeliveryPickUpStoreDO> deliveryPickUpStoreList = deliveryPickUpStoreService.getDeliveryPickUpStoreList(ids);
        return DeliveryPickUpStoreConvert.INSTANCE.convertList2(deliveryPickUpStoreList);
    }
}
