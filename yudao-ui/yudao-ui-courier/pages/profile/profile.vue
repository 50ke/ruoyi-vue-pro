<template>
  <view class="profile-page">
    <!-- 用户信息卡片 -->
    <view class="user-profile-card">
      <view class="user-info-section">
        <image class="user-avatar" :src="userProfile.logo || '/static/logo.jpg'" mode="aspectFill" />
        <view class="user-details">
          <view class="user-name">{{ userProfile.name || '立即登录' }}</view>
          <view class="user-badge">
            <uni-icons type="vip" size="14" color="#FFD700"></uni-icons>
            <text>{{ authStatusText }}</text>
          </view>
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
    <!-- 个人信息陈列（卡片外） -->
    <view class="profile-info-list">
      <view class="profile-info-row">
        <text class="label">工号</text>
        <text class="value">{{ userProfile.code }}</text>
      </view>
      <view class="divider"></view>
      <view class="profile-info-row">
        <text class="label">用户名</text>
        <text class="value">{{ userProfile.username }}</text>
      </view>
      <view class="divider"></view>
      <view class="profile-info-row">
        <text class="label">手机号</text>
        <text class="value">{{ userProfile.mobile }}</text>
      </view>
    </view>
    <!-- 退出登录按钮 -->
    <view class="logout-section">
      <button class="logout-btn" @click="confirmLogout">退出登录</button>
    </view>
  </view>
</template>

<script>
import { getCourierProfile } from '@/api/courier.js';
import { checkLogin } from '@/utils/auth.js';
import { logout } from '@/api/login.js';

export default {
  name: 'ProfilePage',
  data() {
    return {
      userProfile: {
        logo: '/static/logo.jpg',
        name: '',
        code: '',
        username: '',
        mobile: '',
        status: null
      },
      deliveryStats: {
        deliveringCount: 2,
        completedCount: 156,
        totalEarnings: '¥2,580'
      },
      isAuthed: false
    }
  },
  computed: {
    authStatusText() {
      if (this.userProfile.status === 0) {
        return '已认证';
      } else if (this.userProfile.status != null) {
        return '未认证';
      } else {
        return '';
      }
    }
  },
  async onLoad() {
    if (!checkLogin()) return;
    await this.fetchProfile();
  },
  methods: {
    async fetchProfile() {
      try {
        const res = await getCourierProfile();
        if (res.code === 0 && res.data) {
          this.userProfile = res.data;
          this.isAuthed = res.data.status === 0;
        } else {
          this.isAuthed = false;
        }
      } catch (e) {
        this.isAuthed = false;
      }
    },
    confirmLogout() {
      uni.showModal({
        title: '确认退出',
        content: '确定要退出登录吗？',
        confirmText: '退出',
        confirmColor: '#ff4d4f',
        cancelText: '取消',
        success: async (res) => {
          if (res.confirm) {
            await this.handleLogout();
          }
        }
      });
    },
    async handleLogout() {
      try {
        await logout();
      } catch (e) {}
      uni.removeStorageSync('token');
      uni.removeStorageSync('refreshToken');
      uni.redirectTo({ url: '/pages/profile/login' });
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

.profile-info-list {
  margin-bottom: $spacing-lg;
  background: $bg-primary;
  border-radius: $radius-large;
  box-shadow: $shadow-light;
  padding: $spacing-lg $spacing-xl;
  .profile-info-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: $font-size-lg;
    color: $text-primary;
    padding: 18rpx 0;
    .label {
      color: $primary-blue;
      font-weight: 600;
      font-size: $font-size-md;
      margin-right: 12rpx;
      letter-spacing: 1rpx;
    }
    .value {
      color: $text-secondary;
      font-size: $font-size-md;
    }
  }
  .divider {
    height: 1rpx;
    background: $border-light;
    margin: 0 0;
    opacity: 0.5;
  }
}

.logout-section {
  margin-top: 60rpx;
  display: flex;
  justify-content: center;
}
.logout-btn {
  width: 80vw;
  height: 80rpx;
  background: linear-gradient(90deg, #ff4d4f, #ff7875);
  color: #fff;
  font-size: 32rpx;
  border: none;
  border-radius: 40rpx;
  font-weight: 600;
  margin: 0 auto;
}
</style>