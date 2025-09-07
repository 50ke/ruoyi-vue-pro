package cn.iocoder.yudao.module.courier.convert.order;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.collection.CollectionUtils;
import cn.iocoder.yudao.framework.ip.core.utils.AreaUtils;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderDetailRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderRespVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.order.CourierOrderDO;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderRespDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;
import java.util.Map;


/**
 * 配送订单 Convert
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierOrderConvert {

    CourierOrderConvert INSTANCE = Mappers.getMapper(CourierOrderConvert.class);

    default PageResult<AppOrderRespVO> convertPage(PageResult<CourierOrderDO> pageResult, List<TradeOrderRespDTO> orderList) {
        Map<Long, TradeOrderRespDTO> orderMap = CollectionUtils.convertMap(orderList, TradeOrderRespDTO::getId);
        // 转化 List
        List<AppOrderRespVO> orderVOs = CollectionUtils.convertList(pageResult.getList(), courierOrder -> {
            TradeOrderRespDTO xOrder = orderMap.get(courierOrder.getOrderId());
            AppOrderRespVO respVO = new AppOrderRespVO();
            respVO.setId(courierOrder.getId());
            respVO.setNo(xOrder.getNo());
            respVO.setPics(xOrder.getOrderItems().stream().map(TradeOrderRespDTO.OrderItem::getPicUrl).toList());
            respVO.setDeliveryStatus(courierOrder.getDeliveryStatus());
            respVO.setPayTime(xOrder.getPayTime());
            respVO.setPickupTime(courierOrder.getPickupTime());
            respVO.setDeliveryTime(courierOrder.getDeliveryTime());
            respVO.setReceiverMobile(xOrder.getReceiverMobile());
            respVO.setReceiverName(xOrder.getReceiverName());
            respVO.setReceiverDetailAddress(xOrder.getReceiverDetailAddress());
            respVO.setReceiverDetailArea(AreaUtils.format(xOrder.getReceiverAreaId(), " "));
            return respVO;
        });
        return new PageResult<>(orderVOs, pageResult.getTotal());
    }

    AppOrderDetailRespVO convert(TradeOrderRespDTO order);
}
