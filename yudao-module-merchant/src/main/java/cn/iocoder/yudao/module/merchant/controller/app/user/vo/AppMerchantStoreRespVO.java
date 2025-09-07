package cn.iocoder.yudao.module.merchant.controller.app.user.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalTime;

@Schema(description = "商户 APP - 门店信息 Response VO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AppMerchantStoreRespVO {

    @Schema(description = "门店编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Long id;

    @Schema(description = "门店名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private String name;

    @Schema(description = "门店简介", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private String introduction;

    @Schema(description = "门店手机", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private String phone;

    @Schema(description = "门店区域编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "18733")
    private Integer areaId;

    @Schema(description = "门店地区名字", requiredMode = Schema.RequiredMode.REQUIRED, example = "上海上海市普陀区")
    private String areaName;

    @Schema(description = "门店详细地址", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private String detailAddress;

    @Schema(description = "门店logo", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private String logo;

    @Schema(description = "营业开始时间", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "营业开始时间不能为空")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime openingTime;

    @Schema(description = "营业结束时间", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "营业结束时间不能为空")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime closingTime;

    @Schema(description = "纬度", requiredMode = Schema.RequiredMode.REQUIRED, example = "5.88")
    private Double latitude;

    @Schema(description = "经度", requiredMode = Schema.RequiredMode.REQUIRED, example = "6.99")
    private Double longitude;
}
