<template>
  <view class="goods-list-container">
    <view class="section-header">
      <text class="section-title">商品清单</text>
      <text class="goods-count">共 {{ goodsList.length }} 件商品</text>
    </view>
    
    <view class="goods-items">
      <view 
        class="goods-item-card" 
        v-for="goodsItem in goodsList" 
        :key="goodsItem.id"
      >
        <image 
          :src="goodsItem.goodsImage" 
          class="goods-image" 
          mode="aspectFill" 
        />
        <view class="goods-details">
          <text class="goods-title">{{ goodsItem.goodsTitle }}</text>
          <text class="goods-specification">{{ goodsItem.goodsSpec }}</text>
          <view class="goods-quantity-wrapper">
            <text class="quantity-label">数量：</text>
            <text class="quantity-value">x{{ goodsItem.goodsQuantity }}</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'GoodsList',
  props: {
    goodsList: {
      type: Array,
      default: () => []
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.goods-list-container {
  background: $bg-primary;
  border-radius: $radius-large;
  padding: $spacing-lg;
  margin-bottom: $spacing-md;
  box-shadow: $shadow-light;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: $spacing-lg;
  padding-bottom: $spacing-sm;
  border-bottom: 1rpx solid $border-light;
  
  .section-title {
    font-size: $font-size-lg;
    font-weight: 600;
    color: $text-primary;
  }
  
  .goods-count {
    font-size: $font-size-sm;
    color: $text-tertiary;
    background: rgba($primary-blue, 0.1);
    padding: 4rpx 12rpx;
    border-radius: $radius-small;
  }
}

.goods-items {
  display: flex;
  flex-direction: column;
  gap: $spacing-md;
}

.goods-item-card {
  display: flex;
  background: $bg-secondary;
  border-radius: $radius-medium;
  padding: $spacing-md;
  transition: all 0.3s ease;
  
  &:active {
    transform: translateY(2rpx);
    box-shadow: $shadow-light;
  }
}

.goods-image {
  width: 120rpx;
  height: 120rpx;
  border-radius: $radius-small;
  margin-right: $spacing-md;
  background: $bg-primary;
  box-shadow: $shadow-light;
}

.goods-details {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 120rpx;
}

.goods-title {
  font-size: $font-size-md;
  font-weight: 600;
  margin-bottom: $spacing-xs;
  color: $text-primary;
  line-height: 1.4;
}

.goods-specification {
  font-size: $font-size-sm;
  color: $text-secondary;
  margin-bottom: $spacing-sm;
  line-height: 1.3;
}

.goods-quantity-wrapper {
  display: flex;
  align-items: center;
  
  .quantity-label {
    font-size: $font-size-sm;
    color: $text-tertiary;
  }
  
  .quantity-value {
    font-size: $font-size-md;
    color: $primary-blue;
    font-weight: 600;
  }
}
</style> 