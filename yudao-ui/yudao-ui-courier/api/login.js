import http from '@/utils/request.js';

// 配送员-微信登录
export function weixinLogin(data) {
  return http.post('/courier/auth/weixin-mini-app-login', data);
}

// 配送员-刷新token
export function refreshToken(refreshToken) {
  return http.post(`/courier/auth/refresh-token?refreshToken=${refreshToken}`);
}

// 配送员-登出
export function logout() {
  return http.post('/courier/auth/logout');
} 