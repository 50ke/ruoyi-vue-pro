// 路由守卫和权限控制
import { checkLogin, isLoggedIn } from './auth.js';
import store from './store.js';

// 需要登录的页面路径
const AUTH_REQUIRED_PATHS = [
  '/pages/profile/profile',
  '/pages/order/',
  '/pages/index/'
];

// 不需要登录的页面路径
const PUBLIC_PATHS = [
  '/pages/profile/login'
];

// 检查页面是否需要认证
function isAuthRequired(path) {
  return AUTH_REQUIRED_PATHS.some(authPath => path.startsWith(authPath));
}

// 检查页面是否为公开页面
function isPublicPath(path) {
  return PUBLIC_PATHS.some(publicPath => path === publicPath);
}

// 路由前置守卫
export function beforeEach(to, from, next) {
  const path = to.path;
  
  // 如果是公开页面，直接放行
  if (isPublicPath(path)) {
    next();
    return;
  }
  
  // 检查是否需要认证
  if (isAuthRequired(path)) {
    if (!isLoggedIn()) {
      // 未登录，跳转到登录页
      const redirectUrl = encodeURIComponent(path);
      uni.redirectTo({ 
        url: `/pages/profile/login?redirect=${redirectUrl}` 
      });
      return;
    }
    
    // 已登录，检查权限（如果有权限要求）
    if (to.meta && to.meta.permission) {
      if (!store.hasPermission(to.meta.permission)) {
        uni.showToast({ 
          title: '权限不足', 
          icon: 'none' 
        });
        return;
      }
    }
    
    if (to.meta && to.meta.role) {
      if (!store.hasRole(to.meta.role)) {
        uni.showToast({ 
          title: '角色权限不足', 
          icon: 'none' 
        });
        return;
      }
    }
  }
  
  next();
}

// 路由后置守卫
export function afterEach(to, from) {
  // 更新页面标题
  if (to.meta && to.meta.title) {
    uni.setNavigationBarTitle({ title: to.meta.title });
  }
  
  // 记录页面访问日志
  console.log(`页面跳转: ${from.path} -> ${to.path}`);
}

// 检查当前页面权限
export function checkPagePermission(permission) {
  if (!permission) return true;
  return store.hasPermission(permission);
}

// 检查当前页面角色
export function checkPageRole(role) {
  if (!role) return true;
  return store.hasRole(role);
}

// 权限指令
export function permissionDirective(el, binding) {
  const { value } = binding;
  if (value && !checkPagePermission(value)) {
    el.style.display = 'none';
  }
}

// 角色指令
export function roleDirective(el, binding) {
  const { value } = binding;
  if (value && !checkPageRole(value)) {
    el.style.display = 'none';
  }
}
