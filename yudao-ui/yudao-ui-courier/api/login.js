import http from '@/utils/request.js';

// 配送员-用户名+密码登录
export function loginByUsername(data) {
  return http.post('/trade/delivery/express/auth/login', data);
}

// 配送员-手机验证码登录
export function loginBySms(data) {
  return http.post('/trade/delivery/express/auth/sms-login', data);
}

// 配送员-发送验证码
export function sendSmsCode(data) {
  return http.post('/trade/delivery/express/auth/send-sms-code', data);
}

// 配送员-重置密码
export function resetPassword(data) {
  return http.post('/trade/delivery/express/auth/reset-password', data);
}

// 配送员-刷新token
export function refreshToken(refreshToken) {
  return http.post(`/trade/delivery/express/auth/refresh-token?refreshToken=${refreshToken}`);
}

// 配送员-登出
export function logout() {
  return http.post('/trade/delivery/express/auth/logout');
} 