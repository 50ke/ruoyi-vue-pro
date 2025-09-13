package cn.iocoder.yudao.module.merchant.service.trade;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.trade.vo.*;
import jakarta.validation.Valid;

public interface MerchantTradeService {
    PageResult<AppMerchantTradeOrderRespVO> getTradeOrderPage(Long loginUserId, @Valid AppMerchantTradeOrderPageReqVO pageReqVO);

    AppMerchantTradeOrderSummayRespVO getTradeOrderSummary(Long loginUserId);

    void updateTradeOrder(Long loginUserId, @Valid AppMerchantTradeOrderUpdateReqVO reqVO);

    AppMerchantTradeOrderDetailRespVO getTradeOrderDetail(Long loginUserId, Long orderId);
}
