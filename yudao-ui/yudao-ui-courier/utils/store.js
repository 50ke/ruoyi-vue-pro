// 全局状态管理
import { getToken, getUserInfo, isLoggedIn } from './auth.js';

class Store {
  constructor() {
    this.state = {
      // 认证状态
      isAuthenticated: false,
      // 用户信息
      userInfo: null,
      // 加载状态
      loading: false,
      // 错误信息
      error: null
    };
    
    // 初始化状态
    this.init();
  }
  
  // 初始化状态
  init() {
    this.state.isAuthenticated = isLoggedIn();
    this.state.userInfo = getUserInfo();
  }
  
  // 设置认证状态
  setAuthStatus(status) {
    this.state.isAuthenticated = status;
  }
  
  // 设置用户信息
  setUserInfo(userInfo) {
    this.state.userInfo = userInfo;
    this.state.isAuthenticated = !!userInfo;
  }
  
  // 设置加载状态
  setLoading(loading) {
    this.state.loading = loading;
  }
  
  // 设置错误信息
  setError(error) {
    this.state.error = error;
  }
  
  // 清除错误信息
  clearError() {
    this.state.error = null;
  }
  
  // 获取状态
  getState() {
    return this.state;
  }
  
  // 检查是否有权限
  hasPermission(permission) {
    if (!this.state.userInfo || !this.state.userInfo.permissions) {
      return false;
    }
    return this.state.userInfo.permissions.includes(permission);
  }
  
  // 检查是否有角色
  hasRole(role) {
    if (!this.state.userInfo || !this.state.userInfo.roles) {
      return false;
    }
    return this.state.userInfo.roles.includes(role);
  }
  
  // 重置状态
  reset() {
    this.state = {
      isAuthenticated: false,
      userInfo: null,
      loading: false,
      error: null
    };
  }
}

// 创建全局实例
const store = new Store();

export default store;
