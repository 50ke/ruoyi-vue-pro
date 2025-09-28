package cn.iocoder.yudao.module.product.api.category.dto;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class ProductCategoryRespDTO {
    /**
     * 分类编号
     */
    @TableId
    private Long id;
    /**
     * 父分类编号
     */
    private Long parentId;
    /**
     * 分类名称
     */
    private String name;
    /**
     * 移动端分类图
     * 建议 180*180 分辨率
     */
    private String picUrl;
}
