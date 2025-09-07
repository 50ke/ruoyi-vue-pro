package cn.iocoder.yudao.module.courier.controller.app.user.vo;

import cn.iocoder.yudao.module.courier.enums.CourierWorkStatusEnum;
import cn.iocoder.yudao.framework.common.validation.InEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "用户 App - 配送员用户更新 Request VO")
@Data
public class AppCourierUserUpdateReqVO {

    @Schema(description = "工作状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @InEnum(CourierWorkStatusEnum.class)
    private Integer workStatus;

}
