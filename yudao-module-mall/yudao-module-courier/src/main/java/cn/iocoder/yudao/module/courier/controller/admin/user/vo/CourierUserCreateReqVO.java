package cn.iocoder.yudao.module.courier.controller.admin.user.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

@Schema(description = "管理后台 - 配送员用户创建 Request VO")
@Data
public class CourierUserCreateReqVO {

    @Schema(description = "用户名", requiredMode = Schema.RequiredMode.REQUIRED, example = "courier001")
    @NotEmpty(message = "用户名不能为空")
    private String username;

    @Schema(description = "密码", requiredMode = Schema.RequiredMode.REQUIRED, example = "123456")
    @NotEmpty(message = "密码不能为空")
    private String password;

    @Schema(description = "昵称", requiredMode = Schema.RequiredMode.REQUIRED, example = "张三")
    @NotEmpty(message = "昵称不能为空")
    private String nickname;

    @Schema(description = "头像", example = "https://www.iocoder.cn/avatar.jpg")
    private String avatar;

    @Schema(description = "手机号", requiredMode = Schema.RequiredMode.REQUIRED, example = "15601691300")
    @NotEmpty(message = "手机号不能为空")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String mobile;

    @Schema(description = "账号状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "账号状态不能为空")
    private Integer status;

    @Schema(description = "工作状态", example = "0")
    private Integer workStatus;

} 