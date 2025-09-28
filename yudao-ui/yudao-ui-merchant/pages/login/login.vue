<template>
  <view class="login-container">
    <view class="login-card">
      <!-- 应用 Logo -->
      <view class="logo-section">
        <image class="app-logo" src="/static/logo.png" mode="aspectFit"></image>
        <text class="app-name">商户应用</text>
        <text class="app-slogan">专业商户管理平台</text>
      </view>

      <!-- 登录表单 -->
      <view class="login-form">
        <!-- 微信一键登录按钮 -->
        <button 
          class="login-btn wechat-btn" 
          @click="handleWechatLogin"
          :disabled="loading"
        >
          <image class="btn-icon" src="/static/wechat-icon.png" mode="aspectFit"></image>
          <text class="btn-text">微信一键登录</text>
        </button>

        <!-- 加载状态 -->
        <view v-if="loading" class="loading-section">
          <text class="loading-text">登录中...</text>
        </view>
      </view>

      <!-- 底部信息 -->
      <view class="footer">
        <text class="footer-text">登录即代表同意《用户协议》和《隐私政策》</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '@/store/auth'
import { onLoad } from '@dcloudio/uni-app'

const authStore = useAuthStore()
const loading = ref(false)

onLoad((options) => {
  // 检查是否有回调参数
  if (options.code) {
    handleLoginCallback(options)
  }
})

const handleWechatLogin = async () => {
  if (loading.value) return

  loading.value = true

  try {
    // 这里模拟微信登录流程
    // 实际开发中需要调用微信小程序的登录API
    const loginData = {
      loginCode: '模拟登录code',
      phoneCode: '模拟手机code',
      state: '9b2ffbc1-7425-4155-9894-9d5c08541d62'
    }

    await authStore.login(loginData)
    
    uni.showToast({
      title: '登录成功',
      icon: 'success'
    })

    // 登录成功后跳转回原页面或首页
    setTimeout(() => {
      uni.switchTab({
        url: '/pages/index/index'
      })
    }, 1500)

  } catch (error) {
    console.error('登录失败:', error)
    uni.showToast({
      title: error.message || '登录失败',
      icon: 'none'
    })
  } finally {
    loading.value = false
  }
}

const handleLoginCallback = (options) => {
  // 处理微信登录回调
  console.log('登录回调参数:', options)
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40rpx;
}

.login-card {
  background: white;
  border-radius: 24rpx;
  padding: 60rpx 40rpx;
  width: 100%;
  max-width: 600rpx;
  box-shadow: 0 20rpx 60rpx rgba(0, 0, 0, 0.1);
}

.logo-section {
  text-align: center;
  margin-bottom: 80rpx;
}

.app-logo {
  width: 120rpx;
  height: 120rpx;
  border-radius: 24rpx;
  margin-bottom: 30rpx;
}

.app-name {
  display: block;
  font-size: 48rpx;
  font-weight: bold;
  color: #333;
  margin-bottom: 16rpx;
}

.app-slogan {
  font-size: 28rpx;
  color: #666;
}

.login-form {
  margin-bottom: 60rpx;
}

.login-btn {
  width: 100%;
  height: 96rpx;
  border-radius: 48rpx;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32rpx;
  font-weight: 500;
  transition: all 0.3s;
}

.wechat-btn {
  background: #07c160;
  color: white;
}

.wechat-btn:active {
  background: #06ae56;
  transform: scale(0.98);
}

.wechat-btn[disabled] {
  background: #cccccc;
  color: #666666;
}

.btn-icon {
  width: 40rpx;
  height: 40rpx;
  margin-right: 20rpx;
}

.btn-text {
  font-size: 32rpx;
}

.loading-section {
  text-align: center;
  margin-top: 40rpx;
}

.loading-text {
  font-size: 28rpx;
  color: #666;
}

.footer {
  text-align: center;
}

.footer-text {
  font-size: 24rpx;
  color: #999;
  line-height: 1.6;
}
</style>