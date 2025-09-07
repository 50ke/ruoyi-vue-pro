package cn.iocoder.yudao.module.trade.api.delivery;

import cn.iocoder.yudao.module.trade.api.delivery.dto.TradeDeliveryPickUpStoreRespDTO;

import java.util.Collection;
import java.util.List;

public interface TradeDeliveryApi {

    List<TradeDeliveryPickUpStoreRespDTO> getPickUpStoreList(Collection<Long> ids);
}
