package cn.iocoder.yudao.module.product.api.spu.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
public class ProductSpuSaveReqDTO {
    private Long id;

    private String name;

    private String keyword;

    private String introduction;

    private String description;

    private Long categoryId;

    private Long brandId;

    private String picUrl;

    private List<String> sliderPicUrls;

    private Integer sort;

    // ========== SKU 相关字段 =========

    private Boolean specType = Boolean.FALSE;

    // ========== 物流相关字段 =========

    private List<Integer> deliveryTypes;

    private Long deliveryTemplateId;

    // ========== 营销相关字段 =========

    private Integer giveIntegral = 0;

    private Boolean subCommissionType = Boolean.FALSE;

    // ========== 统计相关字段 =========

    private Integer virtualSalesCount;

    private Integer salesCount;

    private Integer browseCount;

    // ========== SKU 相关字段 =========

    private List<ProductSku> skus;

    @Data
    public static class ProductSku {
        private String name;
        private Integer price;
        private Integer marketPrice;
        private Integer costPrice;
        private String barCode;
        private String picUrl;
        private Integer stock;
        private Double weight;
        private Double volume;
        private Integer firstBrokeragePrice;
        private Integer secondBrokeragePrice;
        private List<Property> properties;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Property {
        private Long propertyId;
        private String propertyName;
        private Long valueId;
        private String valueName;
    }
}
