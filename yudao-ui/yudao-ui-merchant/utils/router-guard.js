import { useAuthStore } from '@/store/auth'

// 应用启动时检查登录状态
export const checkLoginOnLaunch = () => {
  const authStore = useAuthStore()
  
  if (!authStore.isLoggedIn) {
	  console.log('------------')
	  uni.redirectTo({
	    url: '/pages/login/login'
	  })
  }
}