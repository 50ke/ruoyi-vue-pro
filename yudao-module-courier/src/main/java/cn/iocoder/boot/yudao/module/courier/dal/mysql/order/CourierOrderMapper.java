package cn.iocoder.boot.yudao.module.courier.dal.mysql.order;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.boot.yudao.module.courier.dal.dataobject.order.CourierOrderDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 配送订单 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierOrderMapper extends BaseMapperX<CourierOrderDO> {

}
