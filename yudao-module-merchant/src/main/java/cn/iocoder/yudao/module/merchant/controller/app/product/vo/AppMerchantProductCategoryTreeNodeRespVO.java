package cn.iocoder.yudao.module.merchant.controller.app.product.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Schema(description = "商户 APP - 商品分类 Response VO")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppMerchantProductCategoryTreeNodeRespVO {

    @Schema(description = "分类编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "2")
    private Long value;

    @Schema(description = "分类名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "办公文具")
    private String text;

    @Schema(description = "分类图片", requiredMode = Schema.RequiredMode.REQUIRED)
    private String picUrl;

    @Schema(description = "父分类编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private List<AppMerchantProductCategoryTreeNodeRespVO> children;
}
