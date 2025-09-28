<template>
  <view class="profile-container">
    <!-- 用户信息头部 -->
    <view class="user-header" :style="headerStyle">
      <view class="user-info">
        <image class="avatar" :src="userAvatar" mode="aspectFill"></image>
        <view class="user-detail">
          <text class="username">{{ userName }}</text>
          <text class="user-id">ID: {{ userId }}</text>
        </view>
      </view>
    </view>

    <!-- 菜单列表 -->
    <view class="menu-section">
      <view class="menu-list">
        <view class="menu-item" v-for="item in menuItems" :key="item.id" @click="handleMenuClick(item)">
          <view class="menu-left">
            <text class="menu-icon">{{ item.icon }}</text>
            <text class="menu-title">{{ item.title }}</text>
          </view>
          <text class="menu-arrow">›</text>
        </view>
      </view>

      <!-- 退出登录按钮 -->
      <view class="logout-section">
        <button class="logout-btn" @click="handleLogout" :disabled="loggingOut">
          <text class="logout-text">{{ loggingOut ? '退出中...' : '退出登录' }}</text>
        </button>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, computed, onLoad } from 'vue'
import { useAuthStore } from '@/store/auth'

const authStore = useAuthStore()
const loggingOut = ref(false)

const menuItems = ref([
  { id: 1, title: '我的订单', icon: '📦', path: '/pages/order/order' },
  { id: 2, title: '账户设置', icon: '⚙️', path: '' },
  { id: 3, title: '帮助中心', icon: '❓', path: '' },
  { id: 4, title: '关于我们', icon: 'ℹ️', path: '' }
])

// 计算属性
const userAvatar = computed(() => {
  return authStore.getUserInfo?.avatar || '/static/images/default-avatar.png'
})

const userName = computed(() => {
  return authStore.getUserInfo?.name || '用户'
})

const userId = computed(() => {
  return authStore.getUserInfo?.userId || '--'
})

const headerStyle = computed(() => {
  return {
    background: 'linear-gradient(135deg, #007AFF 0%, #5856D6 100%)'
  }
})

onLoad(() => {
  console.log('个人中心页面加载')
})

const handleMenuClick = (item) => {
  if (item.path) {
    uni.navigateTo({
      url: item.path
    })
  } else {
    uni.showToast({
      title: `功能开发中`,
      icon: 'none'
    })
  }
}

const handleLogout = async () => {
  uni.showModal({
    title: '提示',
    content: '确定要退出登录吗？',
    success: async (res) => {
      if (res.confirm) {
        loggingOut.value = true
        
        try {
          await authStore.logout()
          
          uni.showToast({
            title: '已退出登录',
            icon: 'success'
          })
          
          // 跳转到登录页
          setTimeout(() => {
            uni.redirectTo({
              url: '/pages/login/login'
            })
          }, 1000)
          
        } catch (error) {
          console.error('退出登录失败:', error)
          uni.showToast({
            title: '退出登录失败',
            icon: 'none'
          })
        } finally {
          loggingOut.value = false
        }
      }
    }
  })
}
</script>

<style scoped>
.profile-container {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.user-header {
  padding: 80rpx 40rpx 60rpx;
  color: white;
}

.user-info {
  display: flex;
  align-items: center;
}

.avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  border: 4rpx solid rgba(255, 255, 255, 0.3);
  margin-right: 30rpx;
}

.user-detail {
  display: flex;
  flex-direction: column;
}

.username {
  font-size: 36rpx;
  font-weight: bold;
  margin-bottom: 10rpx;
}

.user-id {
  font-size: 28rpx;
  opacity: 0.9;
}

.menu-section {
  padding: 0 30rpx;
  margin-top: -40rpx;
}

.menu-list {
  background: white;
  border-radius: 16rpx;
  overflow: hidden;
  margin-bottom: 30rpx;
}

.menu-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 30rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-left {
  display: flex;
  align-items: center;
}

.menu-icon {
  font-size: 40rpx;
  margin-right: 30rpx;
}

.menu-title {
  font-size: 32rpx;
  color: #333;
}

.menu-arrow {
  font-size: 36rpx;
  color: #ccc;
}

.logout-section {
  padding: 30rpx 0;
}

.logout-btn {
  width: 100%;
  height: 88rpx;
  background: white;
  border-radius: 16rpx;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
}

.logout-btn[disabled] {
  opacity: 0.6;
}

.logout-text {
  font-size: 32rpx;
  color: #e64340;
  font-weight: 500;
}
</style>