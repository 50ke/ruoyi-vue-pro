<template>
  <view class="delivery-info-card">
    <!-- 配送状态 -->
    <view class="delivery-status-section">
      <text class="status-text">{{ order.statusText }}</text>
    </view>
    
    <view class="delivery-content-section">
      <!-- 收货人信息 -->
      <view class="delivery-item" @click="$emit('make-phone-call')">
        <view class="item-icon">
          <uni-icons type="person" size="20" color="#2979ff"></uni-icons>
        </view>
        <view class="item-content">
          <text class="item-label">收货人</text>
          <text class="item-value">{{ order.deliveryInfo.customerName }} {{ order.deliveryInfo.customerPhone }}</text>
        </view>
        <view class="item-action">
          <uni-icons type="phone" size="16" color="#2979ff"></uni-icons>
        </view>
      </view>
      
      <!-- 收货地址 -->
      <view class="delivery-item" @click="$emit('open-map')">
        <view class="item-icon">
          <uni-icons type="location" size="20" color="#52c41a"></uni-icons>
        </view>
        <view class="item-content">
          <text class="item-label">收货地址</text>
          <text class="item-value">{{ order.deliveryInfo.deliveryAddress }}</text>
        </view>
        <view class="item-action">
          <uni-icons type="paperplane" size="16" color="#52c41a"></uni-icons>
        </view>
      </view>
      
      <!-- 期望配送时间 -->
      <view class="delivery-item">
        <view class="item-icon">
          <uni-icons type="calendar" size="20" color="#fa8c16"></uni-icons>
        </view>
        <view class="item-content">
          <text class="item-label">期望配送时间</text>
          <text class="item-value">{{ order.deliveryInfo.expectedDeliveryTime }}</text>
        </view>
      </view>
      
      <!-- 订单编号 -->
      <view class="delivery-item">
        <view class="item-icon">
          <uni-icons type="paperplane" size="20" color="#8c8c8c"></uni-icons>
        </view>
        <view class="item-content">
          <text class="item-label">订单编号</text>
          <text class="item-value">{{ order.orderNumber }}</text>
        </view>
      </view>
      
      <!-- 订单备注 -->
      <view class="delivery-item" v-if="order.customerRemark">
        <view class="item-icon">
          <uni-icons type="chat" size="20" color="#1890ff"></uni-icons>
        </view>
        <view class="item-content">
          <text class="item-label">订单备注</text>
          <text class="item-value">{{ order.customerRemark }}</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'DeliveryCard',
  props: {
    order: {
      type: Object,
      required: true
    }
  },
  emits: ['make-phone-call', 'open-map']
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.delivery-info-card {
  background: $bg-primary;
  border-radius: $radius-large;
  padding: $spacing-lg;
  margin-bottom: $spacing-md;
  box-shadow: $shadow-light;
}

.delivery-status-section {
  background: $gradient-primary;
  color: $bg-primary;
  padding: $spacing-md $spacing-lg;
  border-radius: $radius-medium;
  margin-bottom: $spacing-lg;
  text-align: center;
  box-shadow: $shadow-medium;
}

.status-text {
  font-size: $font-size-lg;
  font-weight: 600;
  text-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.2);
}

.delivery-content-section {
  display: flex;
  flex-direction: column;
}

.delivery-item {
  display: flex;
  align-items: flex-start;
  padding: $spacing-md 0;
  border-bottom: 1rpx solid $border-light;
  position: relative;
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
}

.item-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: $spacing-md;
  width: 40rpx;
  height: 40rpx;
  flex-shrink: 0;
}

.item-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.item-label {
  font-size: $font-size-sm;
  color: $text-tertiary;
  margin-bottom: $spacing-xs;
  font-weight: 500;
}

.item-value {
  font-size: $font-size-md;
  color: $text-primary;
  line-height: 1.4;
  font-weight: 500;
}

.item-action {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: $spacing-md;
  width: 40rpx;
  height: 40rpx;
  flex-shrink: 0;
}
</style> 