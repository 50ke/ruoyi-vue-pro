package cn.iocoder.yudao.module.product.api.spu.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ProductSpuPageRespDTO {

    private Long id;

    private String name;

    private Long categoryId;

    private String picUrl;

    private Integer sort;

    private Integer status;

    private LocalDateTime createTime;

    private Integer stock;

    private Integer salesCount;
}
