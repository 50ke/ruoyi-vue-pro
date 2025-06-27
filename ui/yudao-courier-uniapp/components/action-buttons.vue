<template>
  <view class="action-buttons-container">
    <button 
      v-if="orderStatus === 'delivering'" 
      type="primary" 
      class="confirm-delivery-button"
      @click="$emit('confirm-delivered')"
    >
      <uni-icons type="checkmarkempty" size="18" color="#fff"></uni-icons>
      <text class="button-text">确认送达</text>
    </button>
    
    <button 
      v-else-if="orderStatus === 'delivered'" 
      type="default" 
      class="delivery-completed-button"
      disabled
    >
      <uni-icons type="checkmarkempty" size="18" color="#52c41a"></uni-icons>
      <text class="button-text">已送达</text>
    </button>
    
    <button 
      v-else-if="orderStatus === 'completed'" 
      type="default" 
      class="order-completed-button"
      disabled
    >
      <uni-icons type="checkmarkempty" size="18" color="#52c41a"></uni-icons>
      <text class="button-text">订单完成</text>
    </button>
  </view>
</template>

<script>
export default {
  name: 'ActionButtons',
  props: {
    orderStatus: {
      type: String,
      default: ''
    }
  },
  emits: ['confirm-delivered']
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.action-buttons-container {
  display: flex;
  justify-content: center;
  gap: $spacing-md;
  margin-top: $spacing-lg;
  padding: 0 $spacing-md;
}

.confirm-delivery-button {
  width: 100%;
  height: 88rpx;
  border-radius: $radius-xl;
  font-size: $font-size-lg;
  font-weight: 600;
  background: $gradient-primary;
  border: none;
  color: $bg-primary;
  box-shadow: $shadow-medium;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: $spacing-xs;
  transition: all 0.3s ease;
  
  &:active {
    transform: translateY(2rpx);
    box-shadow: $shadow-light;
  }
  
  .button-text {
    font-weight: 600;
  }
}

.delivery-completed-button {
  width: 100%;
  height: 88rpx;
  border-radius: $radius-xl;
  font-size: $font-size-lg;
  font-weight: 600;
  background: rgba($success-green, 0.1);
  border: 2rpx solid $success-green;
  color: $success-green;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: $spacing-xs;
  
  .button-text {
    font-weight: 600;
  }
}

.order-completed-button {
  width: 100%;
  height: 88rpx;
  border-radius: $radius-xl;
  font-size: $font-size-lg;
  font-weight: 600;
  background: rgba($success-green, 0.1);
  border: 2rpx solid $success-green;
  color: $success-green;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: $spacing-xs;
  
  .button-text {
    font-weight: 600;
  }
}
</style> 