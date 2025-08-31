package cn.iocoder.yudao.module.courier.service.order;

import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderPageReqVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderDetailRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.mysql.order.CourierOrderMapper;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.trade.api.order.TradeOrderApi;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;

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
        return null;
    }

    @Override
    public AppOrderDetailRespVO getOrderDetail(Long id) {
//        CourierOrderDO courierOrderDO = courierOrderMapper.selectById(id);
//        if (courierOrderDO == null) return null;
//        TradeOrderRespDTO order = tradeOrderApi.getOrder(courierOrderDO.getOrderId());
//        if (order == null) return null;
//        tradeOrderApi.
        return null;
    }

    @Override
    public Boolean updateOrder(AppOrderUpdateReqVO reqVO) {
        return true;
    }

//    @Override
//    public PageResult<AppOrderRespVO> getOrderPage(AppOrderPageReqVO reqVO) {
//        Long courierId = SecurityFrameworkUtils.getLoginUserId();
//
//        // 分页查询配送订单
//        PageResult<CourierOrderDO> pageResult = courierOrderMapper.selectPage(
//                courierId, reqVO.getDeliveryStatus(), reqVO.getPageNo(), reqVO.getPageSize());
//
//        // 转换为 VO
//        return CourierOrderConvert.INSTANCE.convertPage(pageResult);
//    }
//
//    @Override
//    public AppOrderDetailRespVO getOrderDetail(Long id) {
//        Long courierId = SecurityFrameworkUtils.getLoginUserId();
//
//        // 查询配送订单
//        CourierOrderDO courierOrder = courierOrderMapper.selectById(id);
//        if (courierOrder == null) {
//            throw new ServiceException(BAD_REQUEST, "配送订单不存在");
//        }
//
//        // 验证权限
//        if (!courierOrder.getCourierId().equals(courierId)) {
//            throw new ServiceException(BAD_REQUEST, "无权访问此配送订单");
//        }
//
//        // TODO: 这里需要关联查询商城订单信息，获取订单详情
//
//        return CourierOrderConvert.INSTANCE.convert(courierOrder);
//    }
//
//    @Override
//    public Boolean pickupOrder(Long id) {
//        Long courierId = SecurityFrameworkUtils.getLoginUserId();
//
//        // 查询配送订单
//        CourierOrderDO courierOrder = validateCourierOrder(id, courierId);
//
//        // 检查状态
//        if (!CourierDeliveryStatusEnum.PENDING.getStatus().equals(courierOrder.getDeliveryStatus())) {
//            throw new ServiceException(BAD_REQUEST, "订单状态不正确，无法开始取货");
//        }
//
//        // 更新状态为配送中
//        courierOrderMapper.updateById(new CourierOrderDO()
//                .setId(id)
//                .setDeliveryStatus(CourierDeliveryStatusEnum.DELIVERING.getStatus())
//                .setPickupTime(LocalDateTime.now()));
//
//        log.info("配送员 {} 开始取货，订单 {}", courierId, id);
//        return true;
//    }
//
//    @Override
//    public Boolean deliverOrder(Long id) {
//        Long courierId = SecurityFrameworkUtils.getLoginUserId();
//
//        // 查询配送订单
//        CourierOrderDO courierOrder = validateCourierOrder(id, courierId);
//
//        // 检查状态
//        if (!CourierDeliveryStatusEnum.DELIVERING.getStatus().equals(courierOrder.getDeliveryStatus())) {
//            throw new ServiceException(BAD_REQUEST, "订单状态不正确，无法确认送达");
//        }
//
//        // 更新状态为已送达
//        courierOrderMapper.updateById(new CourierOrderDO()
//                .setId(id)
//                .setDeliveryStatus(CourierDeliveryStatusEnum.DELIVERED.getStatus())
//                .setDeliveryTime(LocalDateTime.now()));
//
//        // TODO: 这里需要同步更新商城订单状态
//
//        log.info("配送员 {} 确认送达，订单 {}", courierId, id);
//        return true;
//    }
//
//    @Override
//    public Boolean cancelOrder(Long id) {
//        Long courierId = SecurityFrameworkUtils.getLoginUserId();
//
//        // 查询配送订单
//        CourierOrderDO courierOrder = validateCourierOrder(id, courierId);
//
//        // 检查状态
//        if (CourierDeliveryStatusEnum.DELIVERED.getStatus().equals(courierOrder.getDeliveryStatus())) {
//            throw new ServiceException(BAD_REQUEST, "订单已送达，无法取消");
//        }
//
//        // 更新状态为已取消
//        courierOrderMapper.updateById(new CourierOrderDO()
//                .setId(id)
//                .setDeliveryStatus(CourierDeliveryStatusEnum.CANCELLED.getStatus()));
//
//        log.info("配送员 {} 取消配送，订单 {}", courierId, id);
//        return true;
//    }
//
//    private CourierOrderDO validateCourierOrder(Long id, Long courierId) {
//        CourierOrderDO courierOrder = courierOrderMapper.selectById(id);
//        if (courierOrder == null) {
//            throw new ServiceException(BAD_REQUEST, "配送订单不存在");
//        }
//
//        if (!courierOrder.getCourierId().equals(courierId)) {
//            throw new ServiceException(BAD_REQUEST, "无权操作此配送订单");
//        }
//
//        return courierOrder;
//    }

}
