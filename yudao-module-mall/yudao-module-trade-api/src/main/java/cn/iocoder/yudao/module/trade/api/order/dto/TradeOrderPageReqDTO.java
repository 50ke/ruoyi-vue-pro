package cn.iocoder.yudao.module.trade.api.order.dto;

import cn.iocoder.yudao.framework.common.pojo.PageParam;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class TradeOrderPageReqDTO extends PageParam {

    private String no;

    private Long merchantId;

    private String userMobile;

    private List<Long> pickUpStoreIds;

    private String pickUpVerifyCode;

    private Integer status;

    private LocalDateTime[] createTime;
}
