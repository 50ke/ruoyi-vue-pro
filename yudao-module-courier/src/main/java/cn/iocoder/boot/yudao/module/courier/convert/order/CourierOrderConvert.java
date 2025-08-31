package cn.iocoder.boot.yudao.module.courier.convert.order;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * 配送订单 Convert
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierOrderConvert {

    CourierOrderConvert INSTANCE = Mappers.getMapper(CourierOrderConvert.class);
}
