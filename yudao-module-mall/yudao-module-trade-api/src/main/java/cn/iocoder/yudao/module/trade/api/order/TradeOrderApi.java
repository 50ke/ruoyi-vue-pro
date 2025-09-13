package cn.iocoder.yudao.module.trade.api.order;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderPageReqDTO;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderRespDTO;

import java.util.Collection;
import java.util.List;

/**
 * 订单 API 接口
 *
 * @author HUIHUI
 */
public interface TradeOrderApi {

    /**
     * 获得订单列表
     *
     * @param ids 订单编号数组
     * @return 订单列表
     */
    List<TradeOrderRespDTO> getOrderList(Collection<Long> ids);

    /**
     * 获得订单
     *
     * @param id 订单编号
     * @return 订单
     */
    TradeOrderRespDTO getOrder(Long id);

    /**
     * 取消支付订单
     *
     * @param userId 用户编号
     * @param orderId 订单编号
     * @param cancelType 取消类型
     */
    void cancelPaidOrder(Long userId, Long orderId, Integer cancelType);

    /**
     * 更新订单备注
     */
    void updateOrderRemark(Long orderId, String remark);

    /**
     * 订单核销
     * @param userId 核销用户ID
     * @param orderId 订单ID
     * @param pickUpVerifyCode 核销码
     */
    void pickUpTradeOrder(Long userId, Long orderId, String pickUpVerifyCode);

    /**
     * 订单发货
     * @param orderId 订单ID
     */
    void deliveryTradeOrder(Long orderId);

    /**
     * 获取订单分页
     * @param pageReqDTO 查询参数
     * @return 订单分页
     */
    PageResult<TradeOrderRespDTO> getTradeOrderPage(TradeOrderPageReqDTO pageReqDTO);
}
