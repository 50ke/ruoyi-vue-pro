package cn.iocoder.yudao.module.trade.api.delivery.dto;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import lombok.Data;

import java.time.LocalTime;

@Data
public class TradeDeliveryPickUpStoreRespDTO {

    /**
     * 编号
     */
    private Long id;

    /**
     * 门店名称
     */
    private String name;

    /**
     * 门店简介
     */
    private String introduction;

    /**
     * 门店手机
     */
    private String phone;

    /**
     * 区域编号
     */
    private Integer areaId;

    /**
     * 门店详细地址
     */
    private String detailAddress;

    /**
     * 门店 logo
     */
    private String logo;

    /**
     * 营业开始时间
     */
    private LocalTime openingTime;

    /**
     * 营业结束时间
     */
    private LocalTime closingTime;

    /**
     * 纬度
     */
    private Double latitude;
    /**
     * 经度
     */
    private Double longitude;

    /**
     * 门店状态
     * 枚举 {@link CommonStatusEnum}
     */
    private Integer status;
}
