// 参考博客方法二重构的请求拦截器
import { baseUrl, tenantId, loginUserType } from '@/utils/config.js';
import { getToken, isTokenExpired, autoRefreshToken, clearToken } from '@/utils/auth.js';

function getPlatform() {
  // 可根据实际平台区分，默认返回 'courier-app'
  return 'courier-app';
}

// 请求队列，防止重复刷新token
let isRefreshing = false;
let requests = [];

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
    const token = getToken();
    if (token) {
      realHeader.Authorization = `Bearer ${token}`;
    }
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
      success: async (res) => {
        if (custom.showLoading !== false) {
          uni.hideLoading();
        }

        const resp = res.data;
        
        // 处理401未授权错误
        if (resp.code === 401) {
          // 如果是刷新token的请求失败，直接清除token并跳转登录
          if (url.includes('/refresh-token')) {
            clearToken();
            uni.reLaunch({ url: '/pages/profile/login' });
            reject(new Error('Token refresh failed'));
            return;
          }

          // 尝试自动刷新token
          if (!isRefreshing) {
            isRefreshing = true;
            try {
              const newToken = await autoRefreshToken();
              // 重新发起原始请求
              const retryResult = await request({ url, method, data, header, custom });
              resolve(retryResult);
            } catch (error) {
              // 刷新失败，清除token并跳转登录
              clearToken();
              uni.reLaunch({ url: '/pages/profile/login' });
              reject(error);
            } finally {
              isRefreshing = false;
            }
          } else {
            // 将请求加入队列，等待token刷新完成后重试
            requests.push(() => {
              request({ url, method, data, header, custom }).then(resolve).catch(reject);
            });
          }
          return;
        }

        // 处理其他错误
        if (resp.code !== 0 && custom.showError !== false) {
          uni.showToast({ title: resp.msg || '请求失败', icon: 'none' });
        }

        resolve(resp);
      },
      fail: (err) => {
        if (custom.showLoading !== false) {
          uni.hideLoading();
        }
        
        // 网络错误处理
        let errorMsg = '网络错误';
        if (err.errMsg) {
          if (err.errMsg.includes('timeout')) {
            errorMsg = '请求超时';
          } else if (err.errMsg.includes('fail')) {
            errorMsg = '网络连接失败';
          }
        }
        
        uni.showToast({ title: errorMsg, icon: 'none' });
        reject(err);
      }
    });
  });
}

// 处理token刷新成功后的队列请求
export function processRequestQueue() {
  requests.forEach(callback => callback());
  requests = [];
}

export default {
  get(url, params = {}, custom = {}) {
    return request({ url, method: 'GET', data: params, custom });
  },
  post(url, data = {}, custom = {}) {
    return request({ url, method: 'POST', data, custom });
  },
  put(url, data = {}, custom = {}) {
    return request({ url, method: 'PUT', data, custom });
  },
  delete(url, data = {}, custom = {}) {
    return request({ url, method: 'DELETE', data, custom });
  }
}; 