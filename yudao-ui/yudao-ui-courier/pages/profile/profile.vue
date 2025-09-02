<template>
  <view class="profile-container">
    <!-- 用户信息卡片 -->
    <view class="user-card">
      <view class="avatar-section">
        <image 
          :src="userInfo.avatar || '/static/default-avatar.png'" 
          class="avatar"
          @click="changeAvatar"
        />
        <view class="user-info">
          <text class="nickname">{{ userInfo.nickname || '配送员' }}</text>
          <text class="mobile">{{ userInfo.mobile || '未绑定手机号' }}</text>
        </view>
      </view>
      
      <!-- 工作状态切换 -->
      <view class="work-status">
        <text class="status-label">工作状态</text>
        <switch 
          :checked="userInfo.workStatus === 1" 
          @change="toggleWorkStatus"
          color="#6B8DE3"
        />
        <text class="status-text">{{ userInfo.workStatus === 1 ? '在线' : '离线' }}</text>
      </view>
    </view>

    <!-- 功能菜单 -->
    <view class="menu-list">
      <view class="menu-item" @click="goToOrders">
        <view class="menu-left">
          <text class="menu-icon">📦</text>
          <text class="menu-text">我的订单</text>
        </view>
        <text class="menu-arrow">></text>
      </view>
      
      <view class="menu-item" @click="goToSettings">
        <view class="menu-left">
          <text class="menu-icon">⚙️</text>
          <text class="menu-text">设置</text>
        </view>
        <text class="menu-arrow">></text>
      </view>
      
      <view class="menu-item" @click="goToHelp">
        <view class="menu-left">
          <text class="menu-icon">❓</text>
          <text class="menu-text">帮助中心</text>
        </view>
        <text class="menu-arrow">></text>
      </view>
      
      <view class="menu-item" @click="goToAbout">
        <view class="menu-left">
          <text class="menu-icon">ℹ️</text>
          <text class="menu-text">关于我们</text>
        </view>
        <text class="menu-arrow">></text>
      </view>
    </view>

    <!-- 退出登录按钮 -->
    <view class="logout-section">
      <button class="logout-btn" @click="handleLogout">退出登录</button>
    </view>
  </view>
</template>

<script>
import { checkPageAuth, getCurrentUser, updateWorkStatus } from '@/utils/middleware.js';
import { getUserInfo, updateWorkStatus as updateWorkStatusApi, logout } from '@/api/login.js';
import store from '@/utils/store.js';

export default {
  data() {
    return {
      userInfo: {},
      loading: false
    }
  },
  
  async onLoad() {
    try {
      // 检查页面认证状态
      await checkPageAuth();
      
      // 获取用户信息
      await this.loadUserInfo();
    } catch (error) {
      console.error('页面加载失败:', error);
    }
  },
  
  onShow() {
    // 每次显示时刷新用户信息
    this.loadUserInfo();
  },
  
  methods: {
    // 加载用户信息
    async loadUserInfo() {
      try {
        this.loading = true;
        
        // 先从本地获取
        const localUserInfo = getCurrentUser();
        if (localUserInfo) {
          this.userInfo = localUserInfo;
        }
        
        // 从服务器获取最新信息
        const response = await getUserInfo();
        if (response.code === 0 && response.data) {
          this.userInfo = response.data;
          // 更新本地存储和全局状态
          store.setUserInfo(response.data);
        }
      } catch (error) {
        console.error('获取用户信息失败:', error);
        uni.showToast({ title: '获取用户信息失败', icon: 'none' });
      } finally {
        this.loading = false;
      }
    },
    
    // 切换工作状态
    async toggleWorkStatus(e) {
      try {
        const newStatus = e.detail.value ? 1 : 2;
        const response = await updateWorkStatusApi({ status: newStatus });
        
        if (response.code === 0) {
          // 更新本地状态
          this.userInfo.workStatus = newStatus;
          updateWorkStatus(newStatus);
          
          uni.showToast({ 
            title: newStatus === 1 ? '已切换为在线' : '已切换为离线', 
            icon: 'success' 
          });
        } else {
          uni.showToast({ title: response.msg || '状态更新失败', icon: 'none' });
        }
      } catch (error) {
        console.error('更新工作状态失败:', error);
        uni.showToast({ title: '状态更新失败', icon: 'none' });
      }
    },
    
    // 更换头像
    changeAvatar() {
      uni.chooseImage({
        count: 1,
        sizeType: ['compressed'],
        sourceType: ['album', 'camera'],
        success: async (res) => {
          try {
            const tempFilePath = res.tempFilePaths[0];
            // 这里可以上传图片到服务器，然后更新头像
            // const uploadResult = await uploadImage(tempFilePath);
            // await updateAvatar(uploadResult.url);
            
            uni.showToast({ title: '头像更新成功', icon: 'success' });
          } catch (error) {
            console.error('头像更新失败:', error);
            uni.showToast({ title: '头像更新失败', icon: 'none' });
          }
        }
      });
    },
    
    // 跳转到订单页面
    goToOrders() {
      uni.switchTab({ url: '/pages/order/order' });
    },
    
    // 跳转到设置页面
    goToSettings() {
      uni.navigateTo({ url: '/pages/profile/settings' });
    },
    
    // 跳转到帮助页面
    goToHelp() {
      uni.navigateTo({ url: '/pages/profile/help' });
    },
    
    // 跳转到关于页面
    goToAbout() {
      uni.navigateTo({ url: '/pages/profile/about' });
    },
    
    // 退出登录
    async handleLogout() {
      uni.showModal({
        title: '确认退出',
        content: '确定要退出登录吗？',
        success: async (res) => {
          if (res.confirm) {
            try {
              // 调用后端登出接口
              await logout();
              
              // 清除本地状态
              store.reset();
              
              uni.showToast({ title: '已退出登录', icon: 'success' });
              
              // 跳转到登录页
              setTimeout(() => {
                uni.reLaunch({ url: '/pages/profile/login' });
              }, 1000);
              
            } catch (error) {
              console.error('退出登录失败:', error);
              // 即使后端调用失败，也要清除本地状态
              store.reset();
              uni.reLaunch({ url: '/pages/profile/login' });
            }
          }
        }
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.profile-container {
  min-height: 100vh;
  background: #f5f6fa;
  padding: 20rpx;
}

.user-card {
  background: $bg-primary;
  border-radius: 20rpx;
  padding: 40rpx;
  margin-bottom: 30rpx;
  box-shadow: $shadow-light;
  
  .avatar-section {
    display: flex;
    align-items: center;
    margin-bottom: 40rpx;
    
    .avatar {
      width: 120rpx;
      height: 120rpx;
      border-radius: 60rpx;
      margin-right: 30rpx;
      border: 4rpx solid #e6eaf0;
    }
    
    .user-info {
      flex: 1;
      
      .nickname {
        display: block;
        font-size: 36rpx;
        font-weight: 600;
        color: $text-primary;
        margin-bottom: 10rpx;
      }
      
      .mobile {
        font-size: 28rpx;
        color: $text-secondary;
      }
    }
  }
  
  .work-status {
    display: flex;
    align-items: center;
    justify-content: space-between;
    
    .status-label {
      font-size: 30rpx;
      color: $text-primary;
    }
    
    .status-text {
      font-size: 28rpx;
      color: $text-secondary;
      margin-left: 20rpx;
    }
  }
}

.menu-list {
  background: $bg-primary;
  border-radius: 20rpx;
  margin-bottom: 30rpx;
  box-shadow: $shadow-light;
  
  .menu-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 30rpx 40rpx;
    border-bottom: 1rpx solid #f0f0f0;
    
    &:last-child {
      border-bottom: none;
    }
    
    .menu-left {
      display: flex;
      align-items: center;
      
      .menu-icon {
        font-size: 40rpx;
        margin-right: 20rpx;
      }
      
      .menu-text {
        font-size: 30rpx;
        color: $text-primary;
      }
    }
    
    .menu-arrow {
      font-size: 30rpx;
      color: #ccc;
    }
  }
}

.logout-section {
  padding: 40rpx 0;
  
  .logout-btn {
    width: 100%;
    height: 80rpx;
    border-radius: 40rpx;
    background: #ff4d4f;
    color: #fff;
    font-size: 30rpx;
    border: none;
    
    &:active {
      opacity: 0.8;
    }
  }
}
</style>