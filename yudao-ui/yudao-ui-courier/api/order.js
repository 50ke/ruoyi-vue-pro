import http from '@/utils/request.js';

// 订单分页列表（POST）
export function getOrderPage(params) {
  return http.post('/trade/delivery/express/order/page', params);
}

// 订单详情（GET，orderId为路径参数）
export function getOrderDetail(orderId) {
  return http.get(`/trade/delivery/express/order/detail/${orderId}`);
}

// 配送状态变更（POST）
export function updateOrderStatus(data) {
  return http.post('/trade/delivery/express/order/update-status', data);
} 