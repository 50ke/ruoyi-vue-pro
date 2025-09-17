package cn.iocoder.yudao.module.merchant.controller.app.product.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Schema(description = "商户 APP - 商品 SPU Response VO")
@Data
public class AppMerchantProductRespVO {

    @Schema(description = "商品 SPU 编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "111")
    private Long id;

    @Schema(description = "商品名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖")
    private String name;

    @Schema(description = "关键字", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉丝滑不出汗")
    private String keyword;

    @Schema(description = "商品简介", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖简介")
    private String introduction;

    @Schema(description = "商品详情", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖详情")
    private String description;

    @Schema(description = "商品分类编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Long categoryId;

    @Schema(description = "商品封面图", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xx.png")
    private String picUrl;

    @Schema(description = "商品轮播图", requiredMode = Schema.RequiredMode.REQUIRED, example = "[https://www.iocoder.cn/xx.png, https://www.iocoder.cn/xxx.png]")
    private List<String> sliderPicUrls;

    @Schema(description = "排序字段", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer sort;

    @Schema(description = "商品状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    private Integer status;

    @Schema(description = "商品创建时间", requiredMode = Schema.RequiredMode.REQUIRED, example = "2023-05-24 00:00:00")
    private LocalDateTime createTime;

    // ========== SKU 相关字段 =========

    @Schema(description = "商品库存", requiredMode = Schema.RequiredMode.REQUIRED, example = "10000")
    private Integer stock;

    @Schema(description = "SKU 数组")
    private List<ProductSku> skus;

    // ========== 统计相关字段 =========

    @Schema(description = "商品销量", requiredMode = Schema.RequiredMode.REQUIRED, example = "2000")
    private Integer salesCount;

    @Schema(description = "虚拟销量", example = "66")
    private Integer virtualSalesCount;

    @Schema(description = "浏览量", requiredMode = Schema.RequiredMode.REQUIRED, example = "888")
    private Integer browseCount;

    @Schema(description = "商户 APP - 商品 SKU Response VO")
    @Data
    public static class ProductSku {

        @Schema(description = "主键", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
        private Long id;

        @Schema(description = "商品 SKU 名字", requiredMode = Schema.RequiredMode.REQUIRED, example = "清凉小短袖")
        private String name;

        @Schema(description = "销售价格，单位：分", requiredMode = Schema.RequiredMode.REQUIRED, example = "1999")
        private Integer price;

        @Schema(description = "市场价", example = "2999")
        private Integer marketPrice;

        @Schema(description = "成本价", example = "19")
        private Integer costPrice;

        @Schema(description = "条形码", example = "15156165456")
        private String barCode;

        @Schema(description = "图片地址", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.iocoder.cn/xx.png")
        private String picUrl;

        @Schema(description = "库存", requiredMode = Schema.RequiredMode.REQUIRED, example = "200")
        private Integer stock;

        @Schema(description = "商品重量,单位：kg 千克", example = "1.2")
        private Double weight;

        @Schema(description = "商品体积,单位：m^3 平米", example = "2.5")
        private Double volume;

        @Schema(description = "属性数组")
        private List<Property> properties;

    }

    @Schema(description = "商品属性")
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
