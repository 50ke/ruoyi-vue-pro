package cn.iocoder.yudao.module.merchant.controller.app.trade;

import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.trade.vo.*;
import cn.iocoder.yudao.module.merchant.service.trade.MerchantTradeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;
import static cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils.getLoginUserId;

@Tag(name = "商户 APP - 交易订单管理")
@RestController
@RequestMapping("/merchant/trade/order")
@Validated
@Slf4j
public class AppMerchantTradeOrderController {

    @Resource
    private MerchantTradeService merchantTradeService;

    @GetMapping("/page")
    @Operation(summary = "获得交易订单分页")
    public CommonResult<PageResult<AppMerchantTradeOrderRespVO>> getTradeOrderPage(@Valid AppMerchantTradeOrderPageReqVO pageReqVO) {
        return success(merchantTradeService.getTradeOrderPage(getLoginUserId(), pageReqVO));
    }

    @GetMapping("/summary")
    @Operation(summary = "获得交易订单统计")
    public CommonResult<AppMerchantTradeOrderSummaryRespVO> getTradeOrderSummary() {
        return success(merchantTradeService.getTradeOrderSummary(getLoginUserId()));
    }

    @PutMapping("/update-remark")
    @Operation(summary = "订单备注")
    public CommonResult<Boolean> updateTradeOrderRemark(@Valid @RequestBody AppMerchantTradeOrderUpdateReqVO reqVO) {
        merchantTradeService.updateTradeOrderRemark(getLoginUserId(), reqVO);
        return success(true);
    }

    @PutMapping("/delivery")
    @Operation(summary = "订单发货")
    public CommonResult<Boolean> deliveryTradeOrder(@Valid @RequestBody AppMerchantTradeOrderUpdateReqVO reqVO) {
        merchantTradeService.deliveryTradeOrder(getLoginUserId(), reqVO);
        return success(true);
    }

    @PutMapping("/pick-up-by-verify-code")
    @Operation(summary = "订单核销")
    public CommonResult<Boolean> pickUpTradeOrder(@Valid @RequestBody AppMerchantTradeOrderUpdateReqVO reqVO) {
        merchantTradeService.pickUpTradeOrder(getLoginUserId(), reqVO);
        return success(true);
    }

    @GetMapping("/get-detail/{orderId}")
    @Operation(summary = "获得交易订单详情")
    public CommonResult<AppMerchantTradeOrderDetailRespVO> getTradeOrderDetail(@PathVariable Long orderId) {
        return success(merchantTradeService.getTradeOrderDetail(getLoginUserId(), orderId));
    }
}
