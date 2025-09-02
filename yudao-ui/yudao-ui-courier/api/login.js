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

// 配送员-获取用户信息
export function getUserInfo() {
  return http.get('/courier/auth/profile');
}

// 配送员-更新用户信息
export function updateUserInfo(data) {
  return http.put('/courier/auth/profile', data);
}

// 配送员-修改密码
export function changePassword(data) {
  return http.post('/courier/auth/change-password', data);
}

// 配送员-发送验证码
export function sendSmsCode(mobile) {
  return http.post('/courier/auth/send-sms-code', { mobile });
}

// 配送员-验证验证码
export function verifySmsCode(mobile, code) {
  return http.post('/courier/auth/verify-sms-code', { mobile, code });
}

// 配送员-绑定手机号
export function bindMobile(data) {
  return http.post('/courier/auth/bind-mobile', data);
}

// 配送员-解绑手机号
export function unbindMobile() {
  return http.post('/courier/auth/unbind-mobile');
}

// 配送员-更新头像
export function updateAvatar(avatarUrl) {
  return http.post('/courier/auth/update-avatar', { avatarUrl });
}

// 配送员-更新工作状态
export function updateWorkStatus(status) {
  return http.post('/courier/auth/update-work-status', { status });
} 