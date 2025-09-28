package cn.iocoder.yudao.module.product.api.category;

import cn.iocoder.yudao.module.product.api.category.dto.ProductCategoryRespDTO;

import java.util.Collection;
import java.util.List;

/**
 * 商品分类 API 接口
 *
 * @author owen
 */
public interface ProductCategoryApi {

    /**
     * 校验商品分类是否有效。如下情况，视为无效：
     * 1. 商品分类编号不存在
     * 2. 商品分类被禁用
     *
     * @param ids 商品分类编号数组
     */
    void validateCategoryList(Collection<Long> ids);

    /**
     * 根据parentId查询商品分类
     * @param parentId 父分类ID
     * @return 分类
     */
    List<ProductCategoryRespDTO> getCategoryListByParentId(Long parentId);
}
