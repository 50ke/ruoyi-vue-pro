import http from '@/utils/request.js';

// 获取配送员信息
export function getCourierProfile() {
  return http.get('/trade/delivery/express/auth/get');
}

// 获取认证状态
export function getCourierAuthStatus() {
  return http.get('/courier/auth/status');
}