package cn.iocoder.yudao.module.merchant.service.trade;

import cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.courier.api.order.CourierOrderApi;
import cn.iocoder.yudao.module.merchant.controller.app.trade.vo.*;
import cn.iocoder.yudao.module.merchant.dal.dataobject.trade.MerchantTradeOrderDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.trade.MerchantTradeOrderMapper;
import cn.iocoder.yudao.module.merchant.service.user.MerchantUserService;
import cn.iocoder.yudao.module.trade.api.order.TradeOrderApi;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderPageReqDTO;
import cn.iocoder.yudao.module.trade.api.order.dto.TradeOrderRespDTO;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static cn.iocoder.yudao.module.merchant.enums.ErrorCodeConstants.*;

@Service
@Valid
@Slf4j
public class MerchantTradeServiceImpl implements MerchantTradeService{

    @Resource
    private TradeOrderApi tradeOrderApi;

    @Resource
    private CourierOrderApi courierOrderApi;

    @Resource
    private MerchantUserService merchantUserService;

    @Resource
    private MerchantTradeOrderMapper merchantTradeOrderMapper;

    @Override
    public PageResult<AppMerchantTradeOrderRespVO> getTradeOrderPage(Long loginUserId, AppMerchantTradeOrderPageReqVO pageReqVO) {
        TradeOrderPageReqDTO pageReqDTO = BeanUtils.toBean(pageReqVO, TradeOrderPageReqDTO.class);
        pageReqDTO.setMerchantId(loginUserId);
        PageResult<TradeOrderRespDTO> pageRespDTO = tradeOrderApi.getTradeOrderPage(pageReqDTO);
        return BeanUtils.toBean(pageRespDTO, AppMerchantTradeOrderRespVO.class);
    }

    @Override
    public AppMerchantTradeOrderSummaryRespVO getTradeOrderSummary(Long loginUserId) {
        AppMerchantTradeOrderSummaryRespVO respVO = new AppMerchantTradeOrderSummaryRespVO();
        respVO.setOrderCount(1L);
        respVO.setProductCount(2L);
        respVO.setOrderPrice(12L);
        return respVO;
    }

    @Override
    public AppMerchantTradeOrderDetailRespVO getTradeOrderDetail(Long loginUserId, Long orderId) {
        validateMerchantTradeOrderExists(loginUserId, orderId);
        TradeOrderRespDTO order = tradeOrderApi.getOrder(orderId);
        return BeanUtils.toBean(order, AppMerchantTradeOrderDetailRespVO.class);
    }

    @Override
    public void updateTradeOrderRemark(Long loginUserId, AppMerchantTradeOrderUpdateReqVO reqVO) {
        validateMerchantTradeOrderExists(loginUserId, reqVO.getId());
        tradeOrderApi.updateOrderRemark(reqVO.getId(), reqVO.getRemark());
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deliveryTradeOrder(Long loginUserId, AppMerchantTradeOrderUpdateReqVO reqVO) {
        validateMerchantTradeOrderExists(loginUserId, reqVO.getId());
        validateMerchantCourierExists(loginUserId, reqVO.getCourierId());
        tradeOrderApi.deliveryTradeOrder(reqVO.getId());
        courierOrderApi.createCourierOrder(reqVO.getCourierId(), reqVO.getId());
    }

    @Override
    public void pickUpTradeOrder(Long loginUserId, AppMerchantTradeOrderUpdateReqVO reqVO) {
        validateMerchantTradeOrderExists(loginUserId, reqVO.getId());
        tradeOrderApi.pickUpTradeOrder(loginUserId, reqVO.getId(), reqVO.getPickUpVerifyCode());
    }

    private void validateMerchantTradeOrderExists(Long loginUserId, Long orderId){
        boolean exists = merchantTradeOrderMapper.exists(new LambdaQueryWrapperX<MerchantTradeOrderDO>()
                .eq(MerchantTradeOrderDO::getOrderId, orderId)
                .eq(MerchantTradeOrderDO::getMerchantId, loginUserId));
        if (!exists){
            throw ServiceExceptionUtil.exception(TRADER_ORDER_NOT_EXISTS);
        }
    }

    private void validateMerchantCourierExists(Long loginUserId, Long courierId){
        if (!merchantUserService.existCourier(loginUserId, courierId)){
            throw ServiceExceptionUtil.exception(USER_NOT_EXISTS);
        }
    }
}
