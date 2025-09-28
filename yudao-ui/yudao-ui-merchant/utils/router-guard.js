import { useAuthStore } from '@/store/auth'

// 需要登录的页面路径
const authPages = [
  'pages/profile/profile',
  'pages/order/order'
  // 添加其他需要认证的页面
]

// 不需要登录的页面路径
const whiteList = [
  'pages/login/login',
  'pages/index/index',
  'pages/product/product'
]

export const createRouterGuard = () => {
  // 页面跳转前的拦截
  uni.addInterceptor('navigateTo', {
    invoke: (args) => {
      return checkAuth(args.url)
    },
    fail: (error) => {
      console.error('导航失败:', error)
    }
  })

  uni.addInterceptor('redirectTo', {
    invoke: (args) => {
      return checkAuth(args.url)
    }
  })

  uni.addInterceptor('switchTab', {
    invoke: (args) => {
      return checkAuth(args.url)
    }
  })

  uni.addInterceptor('reLaunch', {
    invoke: (args) => {
      return checkAuth(args.url)
    }
  })
}

// 检查认证状态
const checkAuth = async (url) => {
  const authStore = useAuthStore()
  
  // 提取页面路径
  const path = url.split('?')[0]
  
  // 检查是否在白名单
  if (whiteList.includes(path)) {
    return true
  }
  
  // 检查是否需要认证
  if (authPages.includes(path)) {
    const isAuthenticated = await authStore.checkAuth()
    
    if (!isAuthenticated) {
      // 未登录，跳转到登录页
      uni.redirectTo({
        url: '/pages/login/login'
      })
      return false
    }
  }
  
  return true
}

// 应用启动时检查登录状态
export const checkLoginOnLaunch = () => {
  const authStore = useAuthStore()
  
  if (!authStore.isLoggedIn) {
    // 如果当前页面不是登录页，则跳转到登录页
    const currentPage = getCurrentPages()[0]
    if (currentPage && !whiteList.includes(currentPage.route)) {
      uni.redirectTo({
        url: '/pages/login/login'
      })
    }
  }
}