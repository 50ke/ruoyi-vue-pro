package cn.iocoder.yudao.module.merchant.dal.mysql.product;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.merchant.dal.dataobject.product.MerchantStoreProductSpuDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商户和商品SPU关联 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface MerchantStoreProductSpuMapper extends BaseMapperX<MerchantStoreProductSpuDO> {

}
