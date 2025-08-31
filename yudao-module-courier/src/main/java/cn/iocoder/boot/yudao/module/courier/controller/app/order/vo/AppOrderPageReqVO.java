package cn.iocoder.boot.yudao.module.courier.controller.app.order.vo;

import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.boot.yudao.module.courier.enums.CourierDeliveryStatusEnum;
import cn.iocoder.yudao.framework.common.validation.InEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Schema(description = "配送员 - 配送订单分页 Request VO")
@Data
@EqualsAndHashCode(callSuper = true)
public class AppOrderPageReqVO extends PageParam {

    @Schema(description = "配送状态", example = "1")
    @InEnum(value = CourierDeliveryStatusEnum.class, message = "配送状态必须是 {value}")
    private Integer deliveryStatus;
}
