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

    @PostMapping("/page")
    @Operation(summary = "获得交易订单分页")
    public CommonResult<PageResult<AppMerchantTradeOrderRespVO>> getTradeOrderPage(@Valid @RequestBody AppMerchantTradeOrderPageReqVO pageReqVO) {
        return success(merchantTradeService.getTradeOrderPage(getLoginUserId(), pageReqVO));
    }

    @GetMapping("/summary")
    @Operation(summary = "获得交易订单统计")
    public CommonResult<AppMerchantTradeOrderSummayRespVO> getTradeOrderSummary() {
        return success(merchantTradeService.getTradeOrderSummary(getLoginUserId()));
    }

    @PutMapping("/update")
    @Operation(summary = "修改交易订单")
    public CommonResult<Boolean> updateTradeOrder(@Valid @RequestBody AppMerchantTradeOrderUpdateReqVO reqVO) {
        merchantTradeService.updateTradeOrder(getLoginUserId(), reqVO);
        return success(true);
    }

    @GetMapping("/get-detail/{orderId}")
    @Operation(summary = "获得交易订单详情")
    public CommonResult<AppMerchantTradeOrderDetailRespVO> getTradeOrderDetail(@PathVariable Long orderId) {
        return success(merchantTradeService.getTradeOrderDetail(getLoginUserId(), orderId));
    }
}
