package cn.iocoder.yudao.module.product.api.spu.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ProductSpuDetailRespDTO {

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

    private Integer status;

    private LocalDateTime createTime;

    // ========== SKU 相关字段 =========

    private Boolean specType;

    private Integer price;

    private Integer marketPrice;

    private Integer costPrice;

    private Integer stock;

    private List<ProductSku> skus;

    // ========== 物流相关字段 =========

    private List<Integer> deliveryTypes;

    private Long deliveryTemplateId;

    // ========== 营销相关字段 =========

    private Integer giveIntegral;

    private Boolean subCommissionType;

    // ========== 统计相关字段 =========

    private Integer salesCount;

    private Integer virtualSalesCount;

    private Integer browseCount;

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
