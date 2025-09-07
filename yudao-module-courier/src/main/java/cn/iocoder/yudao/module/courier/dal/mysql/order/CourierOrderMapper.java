package cn.iocoder.yudao.module.courier.dal.mysql.order;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderPageReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.order.CourierOrderDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 配送订单 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierOrderMapper extends BaseMapperX<CourierOrderDO> {

    default PageResult<CourierOrderDO> selectPage(AppOrderPageReqVO reqVO, Long courierId){
        return selectPage(reqVO, new LambdaQueryWrapperX<CourierOrderDO>()
                .eq(CourierOrderDO::getCourierId, courierId)
                .eqIfPresent(CourierOrderDO::getDeliveryStatus, reqVO.getDeliveryStatus()));
    }
}
