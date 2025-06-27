<template>
  <view class="profile-page">
    <!-- 用户信息卡片 -->
    <view class="user-profile-card">
      <view class="user-info-section">
        <image class="user-avatar" :src="userProfile.avatar" mode="aspectFill" />
        <view class="user-details">
          <view class="user-name">{{ userProfile.nickname || '立即登录' }}</view>
          <view class="user-badge">
            <uni-icons type="vip" size="14" color="#FFD700"></uni-icons>
            <text>五星配送员</text>
          </view>
        </view>
        <view class="settings-button">
          <uni-icons type="gear" size="20" color="#fff"></uni-icons>
        </view>
      </view>
      
      <!-- 配送统计数据 -->
      <view class="delivery-stats-section">
        <view class="stat-item">
          <view class="stat-number">{{ deliveryStats.deliveringCount }}</view>
          <view class="stat-label">配送中</view>
        </view>
        <view class="stat-item">
          <view class="stat-number">{{ deliveryStats.completedCount }}</view>
          <view class="stat-label">已完成</view>
        </view>
        <view class="stat-item">
          <view class="stat-number">{{ deliveryStats.totalEarnings }}</view>
          <view class="stat-label">总收入</view>
        </view>
      </view>
    </view>

    <!-- 快捷功能区域 -->
    <view class="quick-actions-section">
      <view class="section-title">快捷功能</view>
      <view class="action-grid">
        <view 
          class="action-item" 
          v-for="(actionItem, index) in quickActions" 
          :key="index"
          @click="navigateToPage(actionItem.path)"
        >
          <view class="action-icon-wrapper">
            <uni-icons :type="actionItem.icon" size="24" color="#2979ff"></uni-icons>
          </view>
          <text class="action-label">{{ actionItem.name }}</text>
        </view>
      </view>
    </view>

    <!-- 系统设置区域 -->
    <view class="settings-section">
      <view class="section-title">系统设置</view>
      <view class="settings-list">
        <view 
          class="setting-item" 
          v-for="(settingItem, index) in systemSettings" 
          :key="index"
          @click="navigateToPage(settingItem.path)"
        >
          <view class="setting-left">
            <uni-icons :type="settingItem.icon" size="20" color="#8c8c8c"></uni-icons>
            <text class="setting-label">{{ settingItem.name }}</text>
          </view>
          <uni-icons type="right" size="16" color="#bfbfbf"></uni-icons>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'ProfilePage',
  data() {
    return {
      userProfile: {
        avatar: '/static/logo.jpg',
        nickname: '小安',
        phone: '15555555555'
      },
      deliveryStats: {
        deliveringCount: 2,
        completedCount: 156,
        totalEarnings: '¥2,580'
      },
      quickActions: [
        { name: '今日任务', icon: 'calendar', path: '/pages/task/today' },
        { name: '路线规划', icon: 'location', path: '/pages/route/planning' },
        { name: '收入统计', icon: 'wallet', path: '/pages/earnings/statistics' },
        { name: '客户管理', icon: 'person', path: '/pages/customer/list' }
      ],
      systemSettings: [
        { name: '账户设置', icon: 'gear', path: '/pages/settings/account' },
        { name: '消息通知', icon: 'notification', path: '/pages/settings/notification' },
        { name: '隐私设置', icon: 'locked', path: '/pages/settings/privacy' },
        { name: '帮助中心', icon: 'help', path: '/pages/help/center' },
        { name: '关于我们', icon: 'info', path: '/pages/about/us' }
      ]
    }
  },
  onShow() {
    this.loadUserProfile()
  },
  methods: {
    loadUserProfile() {
      // 获取用户信息
      const userInfo = uni.getStorageSync('userInfo')
      if (userInfo) {
        this.userProfile = JSON.parse(userInfo)
      }
    },
    
    navigateToPage(path) {
      uni.navigateTo({
        url: path
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.profile-page {
  min-height: 100vh;
  background-color: $bg-page;
  padding: $spacing-md;
}

.user-profile-card {
  background: $gradient-primary;
  border-radius: $radius-xl;
  padding: $spacing-xl;
  color: $bg-primary;
  margin-bottom: $spacing-lg;
  box-shadow: $shadow-medium;
  
  .user-info-section {
    display: flex;
    align-items: center;
    margin-bottom: $spacing-xl;
    
    .user-avatar {
      width: 130rpx;
      height: 130rpx;
      border-radius: 50%;
      border: 4rpx solid rgba(255,255,255,0.3);
      box-shadow: $shadow-light;
    }
    
    .user-details {
      flex: 1;
      margin-left: $spacing-lg;
      
      .user-name {
        font-size: $font-size-xxl;
        font-weight: 600;
        margin-bottom: $spacing-sm;
        text-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);
      }
      
      .user-badge {
        display: flex;
        align-items: center;
        background: rgba(255,255,255,0.2);
        padding: 4rpx $spacing-sm;
        border-radius: $radius-xl;
        width: fit-content;
        
        text {
          font-size: $font-size-sm;
          margin-left: $spacing-xs;
          font-weight: 500;
        }
      }
    }
    
    .settings-button {
      width: 60rpx;
      height: 60rpx;
      border-radius: 50%;
      background: rgba(255,255,255,0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.3s ease;
      
      &:active {
        background: rgba(255,255,255,0.3);
        transform: scale(0.95);
      }
    }
  }
  
  .delivery-stats-section {
    display: flex;
    justify-content: space-around;
    
    .stat-item {
      text-align: center;
      
      .stat-number {
        font-size: $font-size-xxl;
        font-weight: 600;
        margin-bottom: $spacing-xs;
        text-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);
      }
      
      .stat-label {
        font-size: $font-size-sm;
        opacity: 0.9;
        font-weight: 500;
      }
    }
  }
}

.quick-actions-section {
  background: $bg-primary;
  border-radius: $radius-large;
  padding: $spacing-lg;
  margin-bottom: $spacing-lg;
  box-shadow: $shadow-light;
  
  .section-title {
    font-size: $font-size-lg;
    font-weight: 600;
    color: $text-primary;
    margin-bottom: $spacing-lg;
  }
  
  .action-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: $spacing-lg;
    
    .action-item {
      text-align: center;
      transition: all 0.3s ease;
      
      &:active {
        transform: scale(0.95);
      }
      
      .action-icon-wrapper {
        width: 80rpx;
        height: 80rpx;
        margin: 0 auto $spacing-sm;
        background: rgba($primary-blue, 0.1);
        border-radius: $radius-large;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        
        &:active {
          background: rgba($primary-blue, 0.2);
        }
      }
      
      .action-label {
        font-size: $font-size-sm;
        color: $text-primary;
        font-weight: 500;
      }
    }
  }
}

.settings-section {
  background: $bg-primary;
  border-radius: $radius-large;
  padding: $spacing-lg;
  box-shadow: $shadow-light;
  
  .section-title {
    font-size: $font-size-lg;
    font-weight: 600;
    color: $text-primary;
    margin-bottom: $spacing-lg;
  }
  
  .settings-list {
    .setting-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: $spacing-md 0;
      border-bottom: 1rpx solid $border-light;
      transition: all 0.3s ease;
      
      &:last-child {
        border-bottom: none;
      }
      
      &:active {
        background-color: $bg-secondary;
        border-radius: $radius-small;
        padding-left: $spacing-sm;
        padding-right: $spacing-sm;
      }
      
      .setting-left {
        display: flex;
        align-items: center;
        
        .setting-label {
          font-size: $font-size-md;
          color: $text-primary;
          margin-left: $spacing-md;
          font-weight: 500;
        }
      }
    }
  }
}
</style>