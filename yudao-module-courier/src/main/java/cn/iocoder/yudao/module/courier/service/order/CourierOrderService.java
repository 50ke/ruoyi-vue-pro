package cn.iocoder.yudao.module.courier.service.order;

import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderPageReqVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderDetailRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderUpdateReqVO;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import jakarta.validation.Valid;

/**
 * 配送订单 Service 接口
 *
 * @author 芋道源码
 */
public interface CourierOrderService {

    /**
     * 获得配送订单分页
     *
     * @param reqVO 分页查询
     * @return 配送订单分页
     */
    PageResult<AppOrderRespVO> getOrderPage(AppOrderPageReqVO reqVO);

    /**
     * 获得配送订单详情
     *
     * @param id 配送订单编号
     * @return 配送订单详情
     */
    AppOrderDetailRespVO getOrderDetail(Long id);

    /**
     * 修改订单状态
     * @param reqVO 订单信息
     */
    void updateOrder(@Valid AppOrderUpdateReqVO reqVO);

    /**
     * 创建配送订单
     * @param courierId 配送员ID
     * @param orderId 订单ID
     */
    Long createOrder(Long courierId, Long orderId);
}
