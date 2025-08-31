package cn.iocoder.boot.yudao.module.courier.controller.app.order.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Schema(description = "配送员 - 配送订单详情 Response VO")
@Data
public class AppOrderDetailRespVO {
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
    @Schema(description = "取货时间")
    private LocalDateTime pickupTime;
    @Schema(description = "送达时间")
    private LocalDateTime deliveryTime;
    @Schema(description = "用户备注")
    private String userRemark;
    @Schema(description = "商品明细")
    private List<OrderItem> items;

    @Schema(description = "配送订单 App - 订单项")
    @Data
    public static class OrderItem {

        @Schema(description = "商品 SPU 名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋道源码")
        private String spuName;

        @Schema(description = "商品图片", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/1.png")
        private String picUrl;

        @Schema(description = "购买数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Integer count;

        @Schema(description = "商品属性值", requiredMode = Schema.RequiredMode.REQUIRED, example = "[]")
        private List<ProductPropertyValue> properties;
    }


    @Schema(description = "配送订单 App - 商品属性")
    @Data
    public static class ProductPropertyValue {
        @Schema(description = "属性的编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long propertyId;

        @Schema(description = "属性的名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "颜色")
        private String propertyName;

        @Schema(description = "属性值的编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
        private Long valueId;

        @Schema(description = "属性值的名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "红色")
        private String valueName;
    }
}
