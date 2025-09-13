package cn.iocoder.yudao.module.courier.service.order;

import cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil;
import cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils;
import cn.iocoder.yudao.framework.web.core.util.WebFrameworkUtils;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderPageReqVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderDetailRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderUpdateReqVO;
import cn.iocoder.yudao.module.courier.convert.order.CourierOrderConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.order.CourierOrderDO;
import cn.iocoder.yudao.module.courier.dal.mysql.order.CourierOrderMapper;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.courier.enums.CourierDeliveryStatusEnum;
import cn.iocoder.yudao.module.trade.api.order.TradeOrderApi;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderRespDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import static cn.iocoder.yudao.framework.common.util.collection.CollectionUtils.convertSet;
import static cn.iocoder.yudao.module.courier.enums.ErrorCodeConstants.*;

/**
 * 配送订单 Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Validated
@Slf4j
public class CourierOrderServiceImpl implements CourierOrderService {

    @Resource
    private CourierOrderMapper courierOrderMapper;

    @Resource
    private TradeOrderApi tradeOrderApi;


    @Override
    public PageResult<AppOrderRespVO> getOrderPage(AppOrderPageReqVO reqVO) {
        PageResult<CourierOrderDO> pageResult = courierOrderMapper.selectPage(reqVO, WebFrameworkUtils.getLoginUserId());
        List<TradeOrderRespDTO> orderList = tradeOrderApi.getOrderList(convertSet(pageResult.getList(), CourierOrderDO::getOrderId));
        return CourierOrderConvert.INSTANCE.convertPage(pageResult, orderList);
    }

    @Override
    public AppOrderDetailRespVO getOrderDetail(Long id) {
        CourierOrderDO courierOrderDO = courierOrderMapper.selectById(id);
        if (courierOrderDO == null || !Objects.equals(courierOrderDO.getCourierId(), SecurityFrameworkUtils.getLoginUserId())){
            throw ServiceExceptionUtil.exception(DELIVERY_ORDER_NOT_EXISTS);
        }
        TradeOrderRespDTO order = tradeOrderApi.getOrder(courierOrderDO.getOrderId());
        if (order == null){
            throw ServiceExceptionUtil.exception(DELIVERY_ORDER_NOT_EXISTS);
        }
        return CourierOrderConvert.INSTANCE.convert(order);
    }

    @Override
    public void updateOrder(AppOrderUpdateReqVO reqVO) {
        CourierOrderDO courierOrderDO = courierOrderMapper.selectById(reqVO.getId());
        if (courierOrderDO == null || !Objects.equals(courierOrderDO.getCourierId(), SecurityFrameworkUtils.getLoginUserId())){
            throw ServiceExceptionUtil.exception(DELIVERY_ORDER_NOT_EXISTS);
        }
        if (Objects.equals(reqVO.getDeliveryStatus(), CourierDeliveryStatusEnum.DELIVERING.getStatus())){
            if (Objects.equals(courierOrderDO.getDeliveryStatus(), CourierDeliveryStatusEnum.PENDING.getStatus())){
                courierOrderDO.setStatus(reqVO.getDeliveryStatus());
                courierOrderDO.setPickupTime(LocalDateTime.now());
            }else {
                throw ServiceExceptionUtil.exception(DELIVERY_ORDER_STATUS_ERROR);
            }
        } else if (Objects.equals(reqVO.getDeliveryStatus(), CourierDeliveryStatusEnum.DELIVERED.getStatus())) {
            if (Objects.equals(courierOrderDO.getDeliveryStatus(), CourierDeliveryStatusEnum.DELIVERING.getStatus())){
                courierOrderDO.setStatus(reqVO.getDeliveryStatus());
                courierOrderDO.setDeliveryTime(LocalDateTime.now());
            }else {
                throw ServiceExceptionUtil.exception(DELIVERY_ORDER_STATUS_ERROR);
            }
        } else if (Objects.equals(reqVO.getDeliveryStatus(), CourierDeliveryStatusEnum.CANCELLED.getStatus())) {
            if (Objects.equals(courierOrderDO.getDeliveryStatus(), CourierDeliveryStatusEnum.DELIVERING.getStatus())){
                courierOrderDO.setStatus(reqVO.getDeliveryStatus());
            }else {
                throw ServiceExceptionUtil.exception(DELIVERY_ORDER_STATUS_ERROR);
            }
        }
        courierOrderMapper.updateById(courierOrderDO);
    }

    @Override
    public Long createOrder(Long courierId, Long orderId) {
        CourierOrderDO courierOrderDO = new CourierOrderDO();
        courierOrderDO.setCourierId(courierId);
        courierOrderDO.setOrderId(orderId);
        courierOrderDO.setDeliveryStatus(CourierDeliveryStatusEnum.PENDING.getStatus());
        courierOrderMapper.insert(courierOrderDO);
        return courierOrderDO.getId();
    }
}
