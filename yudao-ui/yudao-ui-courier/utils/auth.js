// 认证相关工具类
import { refreshToken } from '@/api/login.js';

// Token 相关常量
const TOKEN_KEY = 'token';
const REFRESH_TOKEN_KEY = 'refreshToken';
const USER_INFO_KEY = 'userInfo';
const TOKEN_EXPIRE_TIME_KEY = 'tokenExpireTime';

// 登录状态校验与跳转
export function checkLogin(redirect = true) {
  const token = getToken();
  if (!token || isTokenExpired()) {
    if (redirect) {
      const currentPage = getCurrentPages().pop();
      const path = currentPage ? currentPage.route : '';
      const params = currentPage && currentPage.options ? currentPage.options : {};
      let query = '';
      for (const key in params) {
        query += `&${key}=${params[key]}`;
      }
      const redirectUrl = `/pages/profile/login?redirect=/${path}${query ? ('?' + query.slice(1)) : ''}`;
      uni.redirectTo({ url: redirectUrl });
    }
    return false;
  }
  return true;
}

// 获取 Token
export function getToken() {
  return uni.getStorageSync(TOKEN_KEY);
}

// 设置 Token
export function setToken(token, refreshToken, expireTime) {
  uni.setStorageSync(TOKEN_KEY, token);
  uni.setStorageSync(REFRESH_TOKEN_KEY, refreshToken);
  uni.setStorageSync(TOKEN_EXPIRE_TIME_KEY, expireTime);
}

// 清除 Token
export function clearToken() {
  uni.removeStorageSync(TOKEN_KEY);
  uni.removeStorageSync(REFRESH_TOKEN_KEY);
  uni.removeStorageSync(TOKEN_EXPIRE_TIME_KEY);
  uni.removeStorageSync(USER_INFO_KEY);
}

// 检查 Token 是否过期
export function isTokenExpired() {
  const expireTime = uni.getStorageSync(TOKEN_EXPIRE_TIME_KEY);
  if (!expireTime) return true;
  
  // 提前5分钟刷新token
  const now = Date.now();
  const expireTimestamp = new Date(expireTime).getTime();
  return now >= (expireTimestamp - 5 * 60 * 1000);
}

// 自动刷新 Token
export async function autoRefreshToken() {
  try {
    const refreshTokenValue = uni.getStorageSync(REFRESH_TOKEN_KEY);
    if (!refreshTokenValue) {
      throw new Error('No refresh token');
    }

    const response = await refreshToken(refreshTokenValue);
    if (response.code === 0 && response.data) {
      const { accessToken, refreshToken: newRefreshToken, expiresTime } = response.data;
      setToken(accessToken, newRefreshToken, expiresTime);
      return accessToken;
    } else {
      throw new Error(response.msg || 'Token refresh failed');
    }
  } catch (error) {
    console.error('Token refresh failed:', error);
    clearToken();
    // 跳转到登录页
    uni.reLaunch({ url: '/pages/profile/login' });
    throw error;
  }
}

// 获取用户信息
export function getUserInfo() {
  return uni.getStorageSync(USER_INFO_KEY);
}

// 设置用户信息
export function setUserInfo(userInfo) {
  uni.setStorageSync(USER_INFO_KEY, userInfo);
}

// 检查是否已登录
export function isLoggedIn() {
  const token = getToken();
  return token && !isTokenExpired();
}

// 登出
export function logout() {
  clearToken();
  uni.reLaunch({ url: '/pages/profile/login' });
} 