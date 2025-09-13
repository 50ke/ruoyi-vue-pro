package cn.iocoder.yudao.module.merchant.service.trade;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.trade.vo.*;
import jakarta.validation.Valid;

public interface MerchantTradeService {
    PageResult<AppMerchantTradeOrderRespVO> getTradeOrderPage(Long loginUserId, @Valid AppMerchantTradeOrderPageReqVO pageReqVO);

    AppMerchantTradeOrderSummaryRespVO getTradeOrderSummary(Long loginUserId);

    AppMerchantTradeOrderDetailRespVO getTradeOrderDetail(Long loginUserId, Long orderId);

    void updateTradeOrderRemark(Long loginUserId, @Valid AppMerchantTradeOrderUpdateReqVO reqVO);

    void deliveryTradeOrder(Long loginUserId, @Valid AppMerchantTradeOrderUpdateReqVO reqVO);

    void pickUpTradeOrder(Long loginUserId, @Valid AppMerchantTradeOrderUpdateReqVO reqVO);


}
