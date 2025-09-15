package cn.iocoder.yudao.module.product.api.brand.dto;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import lombok.Data;

@Data
public class ProductBrandRespDTO {
    /**
     * 品牌编号
     */
    private Long id;
    /**
     * 品牌名称
     */
    private String name;
    /**
     * 品牌图片
     */
    private String picUrl;
    /**
     * 品牌排序
     */
    private Integer sort;
    /**
     * 品牌描述
     */
    private String description;
    /**
     * 状态
     * 枚举 {@link CommonStatusEnum}
     */
    private Integer status;
}
