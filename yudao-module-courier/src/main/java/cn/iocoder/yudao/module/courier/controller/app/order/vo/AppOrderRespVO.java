package cn.iocoder.yudao.module.courier.controller.app.order.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Schema(description = "配送员 - 配送订单 Response VO")
@Data
public class AppOrderRespVO {
    @Schema(description = "配送订单编号", example = "1001")
    private Long id;
    @Schema(description = "订单号")
    private String no;
    @Schema(description = "收件人姓名")
    private String receiverName;
    @Schema(description = "收件人手机")
    private String receiverMobile;
    @Schema(description = "收件人地区")
    private String receiverDetailArea;
    @Schema(description = "收件人地址")
    private String receiverDetailAddress;
    @Schema(description = "配送状态")
    private Integer deliveryStatus;
    @Schema(description = "支付时间")
    private LocalDateTime payTime;
    @Schema(description = "取货时间")
    private LocalDateTime pickupTime;
    @Schema(description = "送达时间")
    private LocalDateTime deliveryTime;
    @Schema(description = "商品图片")
    private List<String> pics;
}
