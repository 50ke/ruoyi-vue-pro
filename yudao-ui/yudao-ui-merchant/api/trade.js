import { request } from '@/utils/request'

export const tradeApi = {
  // 获得交易订单统计
  getTradeOrderSummary() {
    return request({
      url: '/app-api/merchant/trade/order/summary',
      method: 'GET'
    })
  },

  // 获得交易订单分页
  getTradeOrderPage(data) {
    return request({
      url: '/app-api/merchant/trade/order/page',
      method: 'GET',
      data
    })
  },

  // 获得交易订单详情
  getTradeOrderDetail(orderId) {
    return request({
      url: `/app-api/merchant/trade/order/get-detail/${orderId}`,
      method: 'GET'
    })
  },

  // 订单备注
  updateTradeOrderRemark(data) {
    return request({
      url: '/app-api/merchant/trade/order/update-remark',
      method: 'PUT',
      data
    })
  },

  // 订单核销
  pickUpTradeOrder(data) {
    return request({
      url: '/app-api/merchant/trade/order/pick-up-by-verify-code',
      method: 'PUT',
      data
    })
  },

  // 订单发货
  deliveryTradeOrder(data) {
    return request({
      url: '/app-api/merchant/trade/order/delivery',
      method: 'PUT',
      data
    })
  }
}
