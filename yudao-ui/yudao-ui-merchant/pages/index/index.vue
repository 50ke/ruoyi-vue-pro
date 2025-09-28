<template>
  <view class="container">
    <view class="header">
      <text class="title">首页</text>
    </view>
    <view class="content">
      <text class="welcome">欢迎使用 UniApp</text>
      <view class="card">
        <text class="card-title">当前页面：首页</text>
        <text class="card-content">这是底部导航栏的第一个页面</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { onLoad } from '@dcloudio/uni-app'

onLoad(() => {
  console.log('首页加载完成')
})
</script>

<style scoped>
.container {
  padding: 20rpx;
  min-height: 100vh;
  background-color: #f5f5f5;
}

.header {
  text-align: center;
  padding: 30rpx 0;
}

.title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
}

.welcome {
  display: block;
  text-align: center;
  font-size: 32rpx;
  color: #666;
  margin: 40rpx 0;
}

.card {
  background: white;
  border-radius: 16rpx;
  padding: 30rpx;
  margin: 20rpx 0;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.1);
}

.card-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
  display: block;
  margin-bottom: 20rpx;
}

.card-content {
  font-size: 28rpx;
  color: #666;
  line-height: 1.6;
}
</style>