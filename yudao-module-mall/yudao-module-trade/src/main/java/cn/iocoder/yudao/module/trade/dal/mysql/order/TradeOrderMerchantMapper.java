package cn.iocoder.yudao.module.trade.dal.mysql.order;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.trade.dal.dataobject.order.TradeOrderMerchantDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TradeOrderMerchantMapper extends BaseMapperX<TradeOrderMerchantDO> {
}
