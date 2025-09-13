package cn.iocoder.yudao.module.product.api.spu.dto;

import cn.iocoder.yudao.framework.common.pojo.PageParam;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ProductSpuPageReqDTO extends PageParam {

    /**
     * 出售中商品
     */
    public static final Integer FOR_SALE = 0;

    /**
     * 仓库中商品
     */
    public static final Integer IN_WAREHOUSE = 1;

    /**
     * 已售空商品
     */
    public static final Integer SOLD_OUT = 2;

    /**
     * 警戒库存
     */
    public static final Integer ALERT_STOCK = 3;

    /**
     * 商品回收站
     */
    public static final Integer RECYCLE_BIN = 4;

    private Long merchantId;

    private String name;

    private Integer tabType;

    private Long categoryId;

    private LocalDateTime[] createTime;
}
