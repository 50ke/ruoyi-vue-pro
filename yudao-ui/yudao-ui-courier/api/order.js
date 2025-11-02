import { request } from '@/utils/request'

export const orderApi = {
  // 获得配送订单分页
  getCourierOrderPage(data) {
    return request({
      url: '/app-api/courier/order/page',
      method: 'GET',
      data
    })
  },

  // 获得配送订单详情
  getCourierOrderDetail(orderId) {
    return request({
      url: `/app-api/courier/order/get/${orderId}`,
      method: 'GET'
    })
  },

  // 修改配送订单
  updateCourierOrder(data) {
    return request({
      url: '/app-api/courier/order/update',
      method: 'POST',
      data
    })
  }
}