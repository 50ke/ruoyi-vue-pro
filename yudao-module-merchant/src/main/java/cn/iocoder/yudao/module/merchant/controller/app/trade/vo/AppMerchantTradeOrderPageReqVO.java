package cn.iocoder.yudao.module.merchant.controller.app.trade.vo;

import cn.iocoder.yudao.framework.common.enums.TerminalEnum;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.yudao.framework.common.validation.InEnum;
import cn.iocoder.yudao.framework.common.validation.Mobile;
import cn.iocoder.yudao.module.trade.enums.order.TradeOrderStatusEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.List;

import static cn.iocoder.yudao.framework.common.util.date.DateUtils.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;

@Schema(description = "商户 APP - 交易订单的分页 Request VO")
@Data
public class AppMerchantTradeOrderPageReqVO  extends PageParam {
    @Schema(description = "订单号", example = "88888888")
    private String no;

    @Schema(description = "用户手机号", example = "小王")
    private String userMobile;

    @Schema(description = "自提门店编号", example = "[1,2]")
    private List<Long> pickUpStoreIds;

    @Schema(description = "自提核销码", example = "12345678")
    private String pickUpVerifyCode;

    @Schema(description = "订单状态", example = "1")
    @InEnum(value = TradeOrderStatusEnum.class, message = "订单状态必须是 {value}")
    private Integer status;

    @Schema(description = "创建时间", example = "2025-09-01 00:00:00,2025-10-01 00:00:00")
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private LocalDateTime[] createTime;
}
