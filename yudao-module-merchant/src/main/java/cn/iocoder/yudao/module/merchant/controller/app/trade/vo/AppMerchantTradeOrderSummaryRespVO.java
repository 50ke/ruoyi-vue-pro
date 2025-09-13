package cn.iocoder.yudao.module.merchant.controller.app.trade.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class AppMerchantTradeOrderSummaryRespVO {

    @Schema(description = "订单金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long orderPrice;

    @Schema(description = "订单数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long orderCount;

    @Schema(description = "商品数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long productCount;
}
