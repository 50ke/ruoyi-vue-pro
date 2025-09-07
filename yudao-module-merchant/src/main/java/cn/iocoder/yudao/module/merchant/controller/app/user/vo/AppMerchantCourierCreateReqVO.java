package cn.iocoder.yudao.module.merchant.controller.app.user.vo;

import cn.iocoder.yudao.framework.common.validation.Mobile;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Schema(description = "商户 APP - 配送员创建 Request VO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AppMerchantCourierCreateReqVO {

    @Schema(description = "配送员昵称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋艿")
    @NotBlank(message = "配送员姓名不能为空")
    private String nickname;

    @Schema(description = "配送员头像", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xxx.png")
    @NotBlank(message = "配送员头像不能为空")
    private String avatar;

    @Schema(description = "配送员手机号", requiredMode = Schema.RequiredMode.REQUIRED, example = "15601691300")
    @NotBlank(message = "配送员手机号不能为空")
    @Mobile
    private String mobile;

    @Schema(description = "门店ID集合", requiredMode = Schema.RequiredMode.REQUIRED, example = "15601691300")
    private List<Long> storeIds;
}
