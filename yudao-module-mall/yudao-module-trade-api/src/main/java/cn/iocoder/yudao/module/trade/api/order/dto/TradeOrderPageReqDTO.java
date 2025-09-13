package cn.iocoder.yudao.module.trade.api.order.dto;

import cn.iocoder.yudao.framework.common.pojo.PageParam;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class TradeOrderPageReqDTO extends PageParam {

    private String no;

    private Long userId;

    private Long merchantId;

    private String userNickname;

    private String userMobile;

    private Integer deliveryType;

    private Long logisticsId;

    private List<Long> pickUpStoreIds;

    private String pickUpVerifyCode;

    private Integer type;

    private Integer status;

    private String payChannelCode;

    private LocalDateTime[] createTime;

    private Integer terminal;
}
