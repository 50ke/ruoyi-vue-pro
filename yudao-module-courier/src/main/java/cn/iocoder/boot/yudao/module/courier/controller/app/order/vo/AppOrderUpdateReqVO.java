package cn.iocoder.boot.yudao.module.courier.controller.app.order.vo;

import cn.iocoder.boot.yudao.module.courier.enums.CourierDeliveryStatusEnum;
import cn.iocoder.yudao.framework.common.validation.InEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class AppOrderUpdateReqVO {

    @Schema(description = "配送订单编号", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long id;

    @Schema(description = "配送状态", requiredMode = Schema.RequiredMode.REQUIRED)
    @InEnum(CourierDeliveryStatusEnum.class)
    private Integer deliveryStatus;
}
