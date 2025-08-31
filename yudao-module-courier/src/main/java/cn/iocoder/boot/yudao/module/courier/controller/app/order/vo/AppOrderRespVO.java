package cn.iocoder.boot.yudao.module.courier.controller.app.order.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

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
    @Schema(description = "下单时间")
    private LocalDateTime createTime;
    @Schema(description = "商品图片")
    private String pic;
}
