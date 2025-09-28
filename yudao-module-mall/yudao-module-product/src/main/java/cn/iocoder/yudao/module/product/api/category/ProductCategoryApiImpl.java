package cn.iocoder.yudao.module.product.api.category;

import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.product.api.category.dto.ProductCategoryRespDTO;
import cn.iocoder.yudao.module.product.dal.dataobject.category.ProductCategoryDO;
import cn.iocoder.yudao.module.product.service.category.ProductCategoryService;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;
import java.util.Collection;
import java.util.List;

/**
 * 商品分类 API 接口实现类
 *
 * @author owen
 */
@Service
@Validated
public class ProductCategoryApiImpl implements ProductCategoryApi {

    @Resource
    private ProductCategoryService productCategoryService;

    @Override
    public void validateCategoryList(Collection<Long> ids) {
        productCategoryService.validateCategoryList(ids);
    }

    @Override
    public List<ProductCategoryRespDTO> getCategoryListByParentId(Long parentId) {
        List<ProductCategoryDO> productCategoryDOList = productCategoryService.getCategoryByParentId(parentId);
        return BeanUtils.toBean(productCategoryDOList, ProductCategoryRespDTO.class);
    }

}
