package cn.iocoder.yudao.module.trade.api.order.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单信息 Response DTO
 *
 * @author HUIHUI
 */
@Data
public class TradeOrderRespDTO {
    // ========== 订单基本信息 ==========
    private Long id;
    private String no;
    private LocalDateTime createTime;
    private Integer type;
    private Integer terminal;
    private Long userId;
    private String userIp;
    private String userRemark;
    private Integer status;
    private Integer productCount;
    private LocalDateTime finishTime;
    private LocalDateTime cancelTime;
    private Integer cancelType;
    private String remark;

    // ========== 价格 + 支付基本信息 ==========
    private Long payOrderId;
    private Boolean payStatus;
    private LocalDateTime payTime;
    private String payChannelCode;
    private Integer totalPrice;
    private Integer discountPrice;
    private Integer deliveryPrice;
    private Integer adjustPrice;
    private Integer payPrice;

    // ========== 收件 + 物流基本信息 ==========
    private Integer deliveryType;
    private Long pickUpStoreId;
    private Long pickUpVerifyCode;
    private Long deliveryTemplateId;
    private Long logisticsId;
    private String logisticsNo;
    private LocalDateTime deliveryTime;
    private LocalDateTime receiveTime;
    private String receiverName;
    private String receiverMobile;
    private Integer receiverAreaId;
    private String receiverDetailAddress;

    // ========== 售后基本信息 ==========
    private Integer afterSaleStatus;
    private Integer refundPrice;

    // ========== 营销基本信息 ==========
    private Long couponId;
    private Integer couponPrice;
    private Integer pointPrice;
    private Integer vipPrice;
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
    private String receiverAreaName;

    @Data
    public static class OrderLog {
        private String content;
        private LocalDateTime createTime;
        private Integer userType;
    }

    @Data
    public static class MemberUser {
        private Long id;
        private String nickname;
        private String avatar;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Property {
        private Long propertyId;
        private String propertyName;
        private Long valueId;
        private String valueName;
    }

    @Data
    public static class Item {
        // ========== 订单项基本信息 ==========
        private Long id;
        private Long userId;
        private Long orderId;
        // ========== 商品基本信息 ==========
        private Long spuId;
        private String spuName;
        private Long skuId;
        private String picUrl;
        private Integer count;
        // ========== 价格 + 支付基本信息 ==========
        private Integer price;
        private Integer discountPrice;
        private Integer payPrice;
        private Integer orderPartPrice;
        private Integer orderDividePrice;

        // ========== 营销基本信息 ==========
        // TODO 芋艿：在捉摸一下
        // ========== 售后基本信息 ==========
        private Integer afterSaleStatus;
        /**
         * 属性数组
         */
        private List<Property> properties;
    }
}
