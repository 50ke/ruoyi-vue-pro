package cn.iocoder.yudao.module.merchant.dal.mysql.trade;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.merchant.dal.dataobject.trade.MerchantTradeOrderDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商户和订单关联 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface MerchantTradeOrderMapper extends BaseMapperX<MerchantTradeOrderDO> {

}
