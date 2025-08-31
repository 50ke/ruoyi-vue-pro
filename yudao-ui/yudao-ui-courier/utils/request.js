// 参考商城端sheep/request/index.js重构
import { baseUrl, tenantId, loginUserType } from '@/utils/config.js';

function getPlatform() {
  // 可根据实际平台区分，默认返回 'courier-app'
  return 'courier-app';
}

function request({ url, method = 'GET', data = {}, header = {}, custom = {} }) {
  let realHeader = {
    'Content-Type': 'application/json',
    Accept: 'application/json',
    'tenant-id': tenantId,
    'login-user-type': loginUserType,
    platform: getPlatform(),
    ...header
  };
  // 默认所有请求都加token，除非custom.auth===false
  if (custom.auth !== false) {
    const token = uni.getStorageSync('token');
    if (token) realHeader.Authorization = token;
  }
  if (custom.showLoading !== false) {
    uni.showLoading({ title: custom.loadingMsg || '加载中', mask: true });
  }
  return new Promise((resolve, reject) => {
    uni.request({
      url: baseUrl + url,
      method,
      data,
      header: realHeader,
      success: (res) => {
        if (custom.showLoading !== false) {
          uni.hideLoading();
        }
        const resp = res.data;
        if (resp.code === 401) {
          uni.removeStorageSync('token');
          uni.removeStorageSync('refreshToken');
          uni.redirectTo({ url: '/pages/profile/login' });
          return;
        }
        if (resp.code !== 0 && custom.showError !== false) {
          uni.showToast({ title: resp.msg || '请求失败', icon: 'none' });
        }
        resolve(resp);
      },
      fail: (err) => {
        if (custom.showLoading !== false) {
          uni.hideLoading();
        }
        uni.showToast({ title: '网络错误', icon: 'none' });
        reject(err);
      }
    });
  });
}

export default {
  get(url, params = {}, custom = {}) {
    return request({ url, method: 'GET', data: params, custom });
  },
  post(url, data = {}, custom = {}) {
    return request({ url, method: 'POST', data, custom });
  }
}; 