// 认证中间件
import { checkLogin, isLoggedIn, getUserInfo } from './auth.js';
import store from './store.js';

// 认证中间件 - 检查是否已登录
export function requireAuth() {
  return function(target, name, descriptor) {
    const original = descriptor.value;
    
    descriptor.value = function(...args) {
      if (!isLoggedIn()) {
        uni.showToast({ title: '请先登录', icon: 'none' });
        uni.redirectTo({ url: '/pages/profile/login' });
        return;
      }
      return original.apply(this, args);
    };
    
    return descriptor;
  };
}

// 权限中间件 - 检查是否有指定权限
export function requirePermission(permission) {
  return function(target, name, descriptor) {
    const original = descriptor.value;
    
    descriptor.value = function(...args) {
      if (!store.hasPermission(permission)) {
        uni.showToast({ title: '权限不足', icon: 'none' });
        return;
      }
      return original.apply(this, args);
    };
    
    return descriptor;
  };
}

// 角色中间件 - 检查是否有指定角色
export function requireRole(role) {
  return function(target, name, descriptor) {
    const original = descriptor.value;
    
    descriptor.value = function(...args) {
      if (!store.hasRole(role)) {
        uni.showToast({ title: '角色权限不足', icon: 'none' });
        return;
      }
      return original.apply(this, args);
    };
    
    return descriptor;
  };
}

// 页面认证检查 - 在页面onLoad中使用
export function checkPageAuth() {
  return new Promise((resolve, reject) => {
    if (!isLoggedIn()) {
      uni.showToast({ title: '请先登录', icon: 'none' });
      uni.redirectTo({ url: '/pages/profile/login' });
      reject(new Error('未登录'));
      return;
    }
    resolve();
  });
}

// 页面权限检查 - 在页面onLoad中使用
export function checkPagePermission(permission) {
  return new Promise((resolve, reject) => {
    if (!store.hasPermission(permission)) {
      uni.showToast({ title: '权限不足', icon: 'none' });
      uni.navigateBack();
      reject(new Error('权限不足'));
      return;
    }
    resolve();
  });
}

// 页面角色检查 - 在页面onLoad中使用
export function checkPageRole(role) {
  return new Promise((resolve, reject) => {
    if (!store.hasRole(role)) {
      uni.showToast({ title: '角色权限不足', icon: 'none' });
      uni.navigateBack();
      reject(new Error('角色权限不足'));
      return;
    }
    resolve();
  });
}

// 获取当前用户信息
export function getCurrentUser() {
  return getUserInfo();
}

// 检查当前用户是否在线
export function isUserOnline() {
  const userInfo = getUserInfo();
  return userInfo && userInfo.workStatus === 1;
}

// 更新用户工作状态
export function updateWorkStatus(status) {
  const userInfo = getUserInfo();
  if (userInfo) {
    userInfo.workStatus = status;
    store.setUserInfo(userInfo);
  }
}

// 认证状态监听器
export function createAuthListener(callback) {
  let lastAuthState = isLoggedIn();
  
  return function() {
    const currentAuthState = isLoggedIn();
    if (currentAuthState !== lastAuthState) {
      lastAuthState = currentAuthState;
      callback(currentAuthState);
    }
  };
}
