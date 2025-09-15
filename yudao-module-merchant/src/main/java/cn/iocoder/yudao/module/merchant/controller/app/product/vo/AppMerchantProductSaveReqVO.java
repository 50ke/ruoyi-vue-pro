package cn.iocoder.yudao.module.merchant.controller.app.product.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Schema(description = "商户 APP - 商品 新增/更新 Request VO")
@Data
public class AppMerchantProductSaveReqVO {

    @Schema(description = "商品编号", example = "1")
    private Long id;

    @Schema(description = "商品名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖")
    @NotEmpty(message = "商品名称不能为空")
    private String name;

    @Schema(description = "关键字", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉丝滑不出汗")
    @NotEmpty(message = "商品关键字不能为空")
    private String keyword;

    @Schema(description = "商品简介", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖简介")
    @NotEmpty(message = "商品简介不能为空")
    private String introduction;

    @Schema(description = "商品详情", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖详情")
    @NotEmpty(message = "商品详情不能为空")
    private String description;

    @Schema(description = "商品分类编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "商品分类不能为空")
    private Long categoryId;

    @Schema(description = "商品封面图", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xx.png")
    @NotEmpty(message = "商品封面图不能为空")
    private String picUrl;

    @Schema(description = "商品轮播图", requiredMode = Schema.RequiredMode.REQUIRED,
            example = "[https://www.iocoder.cn/xx.png, https://www.iocoder.cn/xxx.png]")
    private List<String> sliderPicUrls;

    @Schema(description = "排序字段", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "商品排序字段不能为空")
    private Integer sort;

    // ========== SKU 相关字段 =========

//    @Schema(description = "规格类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
//    @NotNull(message = "商品规格类型不能为空")
//    private Boolean specType;

    // ========== SKU 相关字段 =========

    @Schema(description = "SKU 数组")
    @Valid
    private List<ProductSku> skus;

    @Data
    public static class ProductSku {

        @Schema(description = "商品 SKU 名字", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖")
        @NotEmpty(message = "商品 SKU 名字不能为空")
        private String name;

        @Schema(description = "销售价格，单位：分", requiredMode = Schema.RequiredMode.REQUIRED, example = "1999")
        @NotNull(message = "销售价格，单位：分不能为空")
        private Integer price;

        @Schema(description = "市场价", example = "2999")
        private Integer marketPrice;

        @Schema(description = "成本价", example = "19")
        private Integer costPrice;

        @Schema(description = "条形码", example = "15156165456")
        private String barCode;

        @Schema(description = "图片地址", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xx.png")
        @NotNull(message = "图片地址不能为空")
        private String picUrl;

        @Schema(description = "库存", requiredMode = Schema.RequiredMode.REQUIRED, example = "200")
        @NotNull(message = "库存不能为空")
        private Integer stock;

        @Schema(description = "商品重量,单位：kg 千克", example = "1.2")
        private Double weight;

        @Schema(description = "商品体积,单位：m^3 平米", example = "2.5")
        private Double volume;

        @Schema(description = "属性数组")
        private List<Property> properties;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Property {
        @Schema(description = "属性编号", example = "10")
        private Long propertyId;

        @Schema(description = "属性名字", example = "颜色")
        private String propertyName;

        @Schema(description = "属性值编号", example = "10")
        private Long valueId;

        @Schema(description = "属性值名字", example = "红色")
        private String valueName;
    }
}
