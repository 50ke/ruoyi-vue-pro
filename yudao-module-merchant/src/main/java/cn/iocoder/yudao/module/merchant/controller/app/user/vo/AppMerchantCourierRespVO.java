package cn.iocoder.yudao.module.merchant.controller.app.user.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Schema(description = "商户 APP - 配送员信息 Response VO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AppMerchantCourierRespVO {

    @Schema(description = "配送员编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Long id;

    @Schema(description = "配送员昵称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋艿")
    private String nickname;

    @Schema(description = "配送员头像", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xxx.png")
    private String avatar;

    @Schema(description = "配送员手机号", requiredMode = Schema.RequiredMode.REQUIRED, example = "15601691300")
    private String mobile;

    @Schema(description = "帐号状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer status;

    @Schema(description = "配送员工作状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer workStatus;
}
