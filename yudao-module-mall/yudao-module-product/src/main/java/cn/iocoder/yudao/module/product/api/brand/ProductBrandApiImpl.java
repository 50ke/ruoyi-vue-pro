package cn.iocoder.yudao.module.product.api.brand;

import cn.hutool.core.collection.CollUtil;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.product.api.brand.dto.ProductBrandRespDTO;
import cn.iocoder.yudao.module.product.dal.dataobject.brand.ProductBrandDO;
import cn.iocoder.yudao.module.product.service.brand.ProductBrandService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.List;

@Service
@Validated
public class ProductBrandApiImpl implements ProductBrandApi{

    @Resource
    private ProductBrandService productBrandService;

    @Override
    public ProductBrandRespDTO getDefaultBrand() {
        List<ProductBrandDO> brandList = productBrandService.getBrandList();
        if (CollUtil.isEmpty(brandList)){
            return null;
        }
        ProductBrandDO brandDO = brandList.get(0);
        return BeanUtils.toBean(brandDO, ProductBrandRespDTO.class);
    }
}
