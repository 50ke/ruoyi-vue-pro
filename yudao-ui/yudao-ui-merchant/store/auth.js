import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authApi } from '@/api/auth'

export const useAuthStore = defineStore('auth', () => {
  // 状态
  const accessToken = ref(uni.getStorageSync('accessToken') || '')
  const refreshToken = ref(uni.getStorageSync('refreshToken') || '')
  const userInfo = ref(uni.getStorageSync('userInfo') || null)
  const isRefreshing = ref(false)
  const refreshSubscribers = ref([])

  // Getter
  const isLoggedIn = computed(() => !!accessToken.value)
  const getUserInfo = computed(() => userInfo.value)

  // Actions
  const setTokens = (tokens) => {
    accessToken.value = tokens.accessToken
    refreshToken.value = tokens.refreshToken
    userInfo.value = tokens.userInfo || userInfo.value
    
    // 持久化存储
    uni.setStorageSync('accessToken', tokens.accessToken)
    uni.setStorageSync('refreshToken', tokens.refreshToken)
    if (tokens.userInfo) {
      uni.setStorageSync('userInfo', tokens.userInfo)
    }
  }

  const clearTokens = () => {
    accessToken.value = ''
    refreshToken.value = ''
    userInfo.value = null
    
    uni.removeStorageSync('accessToken')
    uni.removeStorageSync('refreshToken')
    uni.removeStorageSync('userInfo')
  }

  const login = async (loginData) => {
    try {
      const response = await authApi.weixinMiniAppLogin(loginData)
      if (response.code === 200) {
        setTokens({
          accessToken: response.data.accessToken,
          refreshToken: response.data.refreshToken,
          userInfo: {
            userId: response.data.userId,
            expiresTime: response.data.expiresTime
          }
        })
        return Promise.resolve(response)
      } else {
        return Promise.reject(new Error(response.msg || '登录失败'))
      }
    } catch (error) {
      return Promise.reject(error)
    }
  }

  const logout = async () => {
    try {
      // 调用登出接口
      await authApi.logout()
    } catch (error) {
      console.error('登出接口调用失败:', error)
    } finally {
      // 无论接口是否成功，都清理本地状态
      clearTokens()
    }
  }

  // 无痛刷新 Token 机制
  const refreshAccessToken = async () => {
    if (!refreshToken.value) {
      throw new Error('没有可用的刷新令牌')
    }

    if (isRefreshing.value) {
      // 如果正在刷新，返回一个 Promise 等待刷新完成
      return new Promise((resolve, reject) => {
        refreshSubscribers.value.push({ resolve, reject })
      })
    }

    isRefreshing.value = true

    try {
      const response = await authApi.refreshToken(refreshToken.value)
      if (response.code === 200) {
        setTokens({
          accessToken: response.data.accessToken,
          refreshToken: response.data.refreshToken,
          userInfo: {
            userId: response.data.userId,
            expiresTime: response.data.expiresTime
          }
        })
        
        // 通知所有等待的请求
        refreshSubscribers.value.forEach(subscriber => subscriber.resolve())
        refreshSubscribers.value = []
        
        return Promise.resolve(response)
      } else {
        throw new Error(response.msg || '刷新令牌失败')
      }
    } catch (error) {
      // 通知所有等待的请求失败
      refreshSubscribers.value.forEach(subscriber => subscriber.reject(error))
      refreshSubscribers.value = []
      
      // 刷新失败，清理登录状态
      clearTokens()
      throw error
    } finally {
      isRefreshing.value = false
    }
  }

  // 检查登录状态
  const checkAuth = async () => {
    if (!isLoggedIn.value) {
      return false
    }
    
    // 这里可以添加更复杂的检查逻辑，比如验证 token 是否即将过期
    return true
  }

  return {
    // State
    accessToken,
    refreshToken,
    userInfo,
    isRefreshing,
    
    // Getter
    isLoggedIn,
    getUserInfo,
    
    // Actions
    setTokens,
    clearTokens,
    login,
    logout,
    refreshAccessToken,
    checkAuth
  }
})