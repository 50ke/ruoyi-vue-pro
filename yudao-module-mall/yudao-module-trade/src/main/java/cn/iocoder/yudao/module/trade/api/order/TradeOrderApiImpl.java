package cn.iocoder.yudao.module.trade.api.order;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.member.api.user.MemberUserApi;
import cn.iocoder.yudao.module.member.api.user.dto.MemberUserRespDTO;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderPageReqDTO;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderRespDTO;
import cn.iocoder.yudao.module.trade.controller.admin.order.vo.TradeOrderDeliveryReqVO;
import cn.iocoder.yudao.module.trade.controller.admin.order.vo.TradeOrderDetailRespVO;
import cn.iocoder.yudao.module.trade.controller.admin.order.vo.TradeOrderPageReqVO;
import cn.iocoder.yudao.module.trade.controller.admin.order.vo.TradeOrderRemarkReqVO;
import cn.iocoder.yudao.module.trade.convert.order.TradeOrderConvert;
import cn.iocoder.yudao.module.trade.dal.dataobject.order.TradeOrderDO;
import cn.iocoder.yudao.module.trade.dal.dataobject.order.TradeOrderItemDO;
import cn.iocoder.yudao.module.trade.dal.dataobject.order.TradeOrderLogDO;
import cn.iocoder.yudao.module.trade.service.order.TradeOrderLogService;
import cn.iocoder.yudao.module.trade.service.order.TradeOrderQueryService;
import cn.iocoder.yudao.module.trade.service.order.TradeOrderUpdateService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.Collection;
import java.util.List;

/**
 * 订单 API 接口实现类
 *
 * @author HUIHUI
 */
@Service
@Validated
public class TradeOrderApiImpl implements TradeOrderApi {

    @Resource
    private TradeOrderUpdateService tradeOrderUpdateService;
    @Resource
    private TradeOrderQueryService tradeOrderQueryService;
    @Resource
    private MemberUserApi memberUserApi;
    @Resource
    private TradeOrderLogService tradeOrderLogService;

    @Override
    public List<TradeOrderRespDTO> getOrderList(Collection<Long> ids) {
        List<TradeOrderItemDO> orderItemDOList = tradeOrderQueryService.getOrderItemListByOrderId(ids);
        return TradeOrderConvert.INSTANCE.convertList04(tradeOrderQueryService.getOrderList(ids), orderItemDOList);
    }

    @Override
    public TradeOrderRespDTO getOrder(Long id) {
        // 查询订单
        TradeOrderDO order = tradeOrderQueryService.getOrder(id);
        if (order == null) {
            return null;
        }
        // 查询订单项
        List<TradeOrderItemDO> orderItems = tradeOrderQueryService.getOrderItemListByOrderId(id);

        // 拼接数据
        MemberUserRespDTO user = memberUserApi.getUser(order.getUserId());
        MemberUserRespDTO brokerageUser = order.getBrokerageUserId() != null ?
                memberUserApi.getUser(order.getBrokerageUserId()) : null;
        List<TradeOrderLogDO> orderLogs = tradeOrderLogService.getOrderLogListByOrderId(id);
        TradeOrderDetailRespVO respVO = TradeOrderConvert.INSTANCE.convert(order, orderItems, orderLogs, user, brokerageUser);
        return BeanUtils.toBean(respVO, TradeOrderRespDTO.class);
//        List<TradeOrderItemDO> orderItemDOList = tradeOrderQueryService.getOrderItemListByOrderId(id);
//        return TradeOrderConvert.INSTANCE.convert01(tradeOrderQueryService.getOrder(id), orderItemDOList);
    }

    @Override
    public void cancelPaidOrder(Long userId, Long orderId, Integer cancelType) {
        tradeOrderUpdateService.cancelPaidOrder(userId, orderId, cancelType);
    }

    @Override
    public void updateOrderRemark(Long orderId, String remark) {
        TradeOrderRemarkReqVO reqVO = new TradeOrderRemarkReqVO();
        reqVO.setId(orderId);
        reqVO.setRemark(remark);
        tradeOrderUpdateService.updateOrderRemark(reqVO);
    }

    @Override
    public void pickUpTradeOrder(Long userId, Long orderId, String pickUpVerifyCode) {
        tradeOrderUpdateService.pickUpOrder(userId, orderId, pickUpVerifyCode);
    }

    @Override
    public void deliveryTradeOrder(Long orderId) {
        TradeOrderDeliveryReqVO reqVO = new TradeOrderDeliveryReqVO();
        reqVO.setId(orderId);
        reqVO.setLogisticsId(TradeOrderDO.LOGISTICS_ID_NULL);
        tradeOrderUpdateService.deliveryOrder(reqVO);
    }

    @Override
    public PageResult<TradeOrderRespDTO> getTradeOrderPage(TradeOrderPageReqDTO pageReqDTO) {
        TradeOrderPageReqVO pageReqVO = BeanUtils.toBean(pageReqDTO, TradeOrderPageReqVO.class);
        PageResult<TradeOrderDO> orderPage = tradeOrderQueryService.getOrderPage(pageReqVO);
        return BeanUtils.toBean(orderPage, TradeOrderRespDTO.class);
    }

}
