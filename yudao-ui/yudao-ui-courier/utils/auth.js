// 登录状态校验与跳转
export function checkLogin(redirect = true) {
  const token = uni.getStorageSync('token');
  if (!token) {
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