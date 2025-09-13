package cn.iocoder.yudao.module.merchant.controller.app.trade.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AppMerchantTradeOrderUpdateReqVO {

    @Schema(description = "订单编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    @NotNull(message = "订单编号不能为空")
    private Long id;

    @Schema(description = "商家备注", example = "你猜一下")
    private String remark;

    @Schema(description = "自提核销码", example = "123456")
    private String pickUpVerifyCode;

    @Schema(description = "配送员ID", example = "1")
    private Long courierId;
}
