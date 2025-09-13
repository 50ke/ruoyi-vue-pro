package cn.iocoder.yudao.module.merchant.service.trade;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.trade.vo.*;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Valid
@Slf4j
public class MerchantTradeServiceImpl implements MerchantTradeService{
    @Override
    public PageResult<AppMerchantTradeOrderRespVO> getTradeOrderPage(Long loginUserId, AppMerchantTradeOrderPageReqVO pageReqVO) {
        return null;
    }

    @Override
    public AppMerchantTradeOrderSummayRespVO getTradeOrderSummary(Long loginUserId) {
        return null;
    }

    @Override
    public void updateTradeOrder(Long loginUserId, AppMerchantTradeOrderUpdateReqVO reqVO) {

    }

    @Override
    public AppMerchantTradeOrderDetailRespVO getTradeOrderDetail(Long loginUserId, Long orderId) {
        return null;
    }
}
