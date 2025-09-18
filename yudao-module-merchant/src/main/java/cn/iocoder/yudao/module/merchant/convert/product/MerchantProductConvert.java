package cn.iocoder.yudao.module.merchant.convert.product;

import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductRespVO;
import cn.iocoder.yudao.module.product.api.sku.dto.ProductSkuRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuDetailRespDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface MerchantProductConvert {

    MerchantProductConvert INSTANCE = Mappers.getMapper(MerchantProductConvert.class);

    default AppMerchantProductRespVO convert(ProductSpuDetailRespDTO respDTO, List<ProductSkuRespDTO> skus, List<Long> storeIdList){
        AppMerchantProductRespVO respVO = BeanUtils.toBean(respDTO, AppMerchantProductRespVO.class);
        List<AppMerchantProductRespVO.ProductSku> skuList = BeanUtils.toBean(skus, AppMerchantProductRespVO.ProductSku.class);
        respVO.setSkus(skuList);
        respVO.setStoreId(storeIdList);
        return respVO;
    }
}
