package cn.iocoder.yudao.module.merchant.controller.app.trade.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Schema(description = "商户 APP - 交易订单详情 Response VO")
@Data
public class AppMerchantTradeOrderDetailRespVO {
    // ========== 订单基本信息 ==========

    @Schema(description = "订单编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long id;

    @Schema(description = "订单流水号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1146347329394184195")
    private String no;

    @Schema(description = "下单时间", requiredMode = Schema.RequiredMode.REQUIRED)
    private LocalDateTime createTime;

    @Schema(description = "订单类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer type;

    @Schema(description = "订单来源", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer terminal;

    @Schema(description = "用户编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "2048")
    private Long userId;

    @Schema(description = "用户 IP", requiredMode = Schema.RequiredMode.REQUIRED, example = "127.0.0.1")
    private String userIp;

    @Schema(description = "用户备注", requiredMode = Schema.RequiredMode.REQUIRED, example = "你猜")
    private String userRemark;

    @Schema(description = "订单状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer status;

    @Schema(description = "购买的商品数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "10")
    private Integer productCount;

    @Schema(description = "订单完成时间")
    private LocalDateTime finishTime;

    @Schema(description = "订单取消时间")
    private LocalDateTime cancelTime;

    @Schema(description = "取消类型", example = "10")
    private Integer cancelType;

    @Schema(description = "商家备注", example = "你猜一下")
    private String remark;

    // ========== 价格 + 支付基本信息 ==========

    @Schema(description = "支付订单编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long payOrderId;

    @Schema(description = "是否已支付", requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
    private Boolean payStatus;

    @Schema(description = "付款时间")
    private LocalDateTime payTime;

    @Schema(description = "支付渠道", requiredMode = Schema.RequiredMode.REQUIRED, example = "wx_lite")
    private String payChannelCode;

    @Schema(description = "商品原价（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "1000")
    private Integer totalPrice;

    @Schema(description = "订单优惠（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer discountPrice;

    @Schema(description = "运费金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer deliveryPrice;

    @Schema(description = "订单调价（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer adjustPrice;

    @Schema(description = "应付金额（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "1000")
    private Integer payPrice;

    // ========== 收件 + 物流基本信息 ==========

    @Schema(description = "配送方式", example = "10")
    private Integer deliveryType;

    @Schema(description = "自提门店", example = "10")
    private Long pickUpStoreId;

    @Schema(description = "自提核销码", example = "10")
    private Long pickUpVerifyCode;

    @Schema(description = "配送模板编号", example = "1024")
    private Long deliveryTemplateId;

    @Schema(description = "发货物流公司编号", example = "1024")
    private Long logisticsId;

    @Schema(description = "发货物流单号", example = "1024")
    private String logisticsNo;

    @Schema(description = "发货时间")
    private LocalDateTime deliveryTime;

    @Schema(description = "收货时间")
    private LocalDateTime receiveTime;

    @Schema(description = "收件人名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "张三")
    private String receiverName;

    @Schema(description = "收件人手机", requiredMode = Schema.RequiredMode.REQUIRED, example = "13800138000")
    private String receiverMobile;

    @Schema(description = "收件人地区编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "110000")
    private Integer receiverAreaId;

    @Schema(description = "收件人详细地址", requiredMode = Schema.RequiredMode.REQUIRED, example = "中关村大街 1 号")
    private String receiverDetailAddress;

    // ========== 售后基本信息 ==========

    @Schema(description = "售后状态", example = "1")
    private Integer afterSaleStatus;

    @Schema(description = "退款金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer refundPrice;

    // ========== 营销基本信息 ==========

    @Schema(description = "优惠劵编号", example = "1024")
    private Long couponId;

    @Schema(description = "优惠劵减免金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer couponPrice;

    @Schema(description = "积分抵扣的金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
    private Integer pointPrice;

    @Schema(description = "VIP 减免金额", requiredMode = Schema.RequiredMode.REQUIRED, example = "888")
    private Integer vipPrice;

    @Schema(description = "推广人编号", example = "1")
    private Long brokerageUserId;













    /**
     * 订单项列表
     */
    private List<Item> items;

    /**
     * 下单用户信息
     */
    private MemberUser user;
    /**
     * 推广用户信息
     */
    private MemberUser brokerageUser;

    /**
     * 操作日志列表
     */
    private List<OrderLog> logs;

    @Schema(description = "收件人地区名字", requiredMode = Schema.RequiredMode.REQUIRED, example = "上海 上海市 普陀区")
    private String receiverAreaName;

    @Schema(description = "商户APP - 交易订单的操作日志")
    @Data
    public static class OrderLog {

        @Schema(description = "操作详情", requiredMode = Schema.RequiredMode.REQUIRED, example = "订单发货")
        private String content;

        @Schema(description = "创建时间", requiredMode = Schema.RequiredMode.REQUIRED, example = "2023-06-01 10:50:20")
        private LocalDateTime createTime;

        @Schema(description = "用户类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Integer userType;

    }

    @Schema(description = "商户APP - 会员用户 Response VO")
    @Data
    public static class MemberUser {

        @Schema(description = "用户 ID", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long id;

        @Schema(description = "用户昵称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋道源码")
        private String nickname;

        @Schema(description = "用户头像", example = "https://www.iocoder.cn/xxx.png")
        private String avatar;

    }

    @Schema(description = "商品属性")
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Property {

        @Schema(description = "属性编号", example = "10")
        private Long propertyId;

        @Schema(description = "属性名字", example = "颜色")
        private String propertyName;

        @Schema(description = "属性值编号", example = "10")
        private Long valueId;

        @Schema(description = "属性值名字", example = "红色")
        private String valueName;

    }

    @Schema(description = "商户APP - 交易订单的详情的订单项目")
    @Data
    public static class Item {

        // ========== 订单项基本信息 ==========

        @Schema(description = "编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long id;

        @Schema(description = "用户编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long userId;

        @Schema(description = "订单编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long orderId;

        // ========== 商品基本信息 ==========

        @Schema(description = "商品 SPU 编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long spuId;

        @Schema(description = "商品 SPU 名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋道源码")
        private String spuName;

        @Schema(description = "商品 SKU 编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Long skuId;

        @Schema(description = "商品图片", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/1.png")
        private String picUrl;

        @Schema(description = "购买数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Integer count;

        // ========== 价格 + 支付基本信息 ==========

        @Schema(description = "商品原价（单）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
        private Integer price;

        @Schema(description = "商品优惠（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
        private Integer discountPrice;

        @Schema(description = "商品实付金额（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
        private Integer payPrice;

        @Schema(description = "子订单分摊金额（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
        private Integer orderPartPrice;

        @Schema(description = "分摊后子订单实付金额（总）", requiredMode = Schema.RequiredMode.REQUIRED, example = "100")
        private Integer orderDividePrice;

        // ========== 营销基本信息 ==========

        // TODO 芋艿：在捉摸一下

        // ========== 售后基本信息 ==========

        @Schema(description = "售后状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
        private Integer afterSaleStatus;

        /**
         * 属性数组
         */
        private List<Property> properties;
    }
}
