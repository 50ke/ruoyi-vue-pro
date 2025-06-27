<template>
  <view class="delivery-home-page">
    <!-- 搜索栏 -->
    <view class="search-section">
      <view class="search-container">
        <uni-icons type="search" size="16" color="#8c8c8c"></uni-icons>
        <input 
          type="text" 
          placeholder="搜索订单号或地址" 
          v-model="searchKeyword" 
          class="search-input"
        />
      </view>
    </view>

    <!-- 订单状态筛选 -->
    <view class="status-filter-section">
      <view 
        v-for="(statusItem, index) in orderStatusOptions" 
        :key="index"
        class="status-filter-item"
        :class="{ active: currentOrderStatus === statusItem.value }"
        @click="changeOrderStatus(statusItem.value)"
      >
        {{statusItem.label}}
      </view>
    </view>

    <!-- 订单列表 -->
    <scroll-view
      scroll-y
      style="height: 70vh"
      @scrolltolower="loadMoreOrders"
      refresher-enabled
      :refresher-triggered="isRefreshing"
      @refresherrefresh="refreshOrderList"
    >
      <view class="order-list-container">
        <view 
          class="order-item-card" 
          v-for="(orderItem, index) in filteredOrderList" 
          :key="index" 
          @click="navigateToOrderDetail(orderItem)"
        >
          <view class="order-header">
            <view class="order-number">订单号：{{ orderItem.orderNumber }}</view>
            <view class="order-status" :class="getStatusClass(orderItem.status)">
              {{ getStatusText(orderItem.status) }}
            </view>
          </view>
          
          <view class="order-content">
            <image class="product-image" :src="orderItem.productImage" mode="aspectFill" />
            <view class="order-info">
              <view class="delivery-address">配送地址：{{ orderItem.deliveryAddress }}</view>
              <view class="delivery-time">配送时间：{{ orderItem.expectedDeliveryTime }}</view>
              <view class="action-buttons">
                <view class="action-button phone-button" @click.stop="makePhoneCall(orderItem.customerPhone)">
                  <uni-icons type="phone-filled" size="18" color="#2979ff"></uni-icons>
                </view>
                <view class="action-button map-button" @click.stop="openLocationMap(orderItem)">
                  <uni-icons type="paperplane-filled" size="18" color="#52c41a"></uni-icons>
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>
      <uni-load-more :status="loadMoreStatus" />
    </scroll-view>
  </view>
</template>

<script>
import uniLoadMore from '@/uni_modules/uni-load-more/components/uni-load-more/uni-load-more.vue'
import uniIcons from '@/uni_modules/uni-icons/components/uni-icons/uni-icons.vue'

export default {
  components: {
    uniLoadMore,
    uniIcons
  },
  data() {
    return {
      searchKeyword: '',
      currentOrderStatus: 'pending',
      orderStatusOptions: [
        { label: '已超时', value: 'expired' },
        { label: '配送中', value: 'delivering' },
        { label: '待配送', value: 'pending' },
        { label: '已完成', value: 'completed' },
        { label: '全部', value: 'all' }
      ],
      orderList: [],
      currentPage: 1,
      pageSize: 10,
      loadMoreStatus: 'more', // more/loading/noMore
      isRefreshing: false,
      isAllLoaded: false
    }
  },
  computed: {
    filteredOrderList() {
      return this.orderList.filter(orderItem => {
        const statusMatch = this.currentOrderStatus === 'all' || orderItem.status === this.currentOrderStatus;
        const searchMatch = !this.searchKeyword || 
          (orderItem.orderNumber && orderItem.orderNumber.toLowerCase().includes(this.searchKeyword.toLowerCase())) ||
          (orderItem.deliveryAddress && orderItem.deliveryAddress.toLowerCase().includes(this.searchKeyword.toLowerCase()));
        return statusMatch && searchMatch;
      });
    }
  },
  onLoad() {
    this.refreshOrderList();
  },
  methods: {
    changeOrderStatus(status) {
      this.currentOrderStatus = status;
    },
    
    navigateToOrderDetail(orderItem) {
      uni.navigateTo({ url: `/pages/order/order-detail?id=${orderItem.id}` })
    },
    
    async refreshOrderList() {
      this.isRefreshing = true;
      this.currentPage = 1;
      this.isAllLoaded = false;
      await this.fetchOrderList(true);
      this.isRefreshing = false;
      uni.stopPullDownRefresh();
    },
    
    async loadMoreOrders() {
      if (this.loadMoreStatus === 'loading' || this.isAllLoaded) return;
      this.loadMoreStatus = 'loading';
      await this.fetchOrderList();
    },
    
    async fetchOrderList(isRefresh = false) {
      // 模拟异步请求，实际请替换为你的接口请求
      setTimeout(() => {
        let newOrderData = [];
        // 模拟数据
        for (let i = 0; i < this.pageSize; i++) {
          const orderId = (this.currentPage - 1) * this.pageSize + i + 1;
          newOrderData.push({
            id: orderId,
            orderNumber: 'AQ' + String(orderId).padStart(6, '0'),
            expectedDeliveryTime: '2025-01-26 09:00 - 12:00',
            status: ['expired', 'delivering', 'pending', 'completed'][orderId % 4],
            customerPhone: '16602720936',
            latitude: 30.59225,
            longitude: 114.367353,
            deliveryAddress: '当代国际花园未来域' + orderId + '栋',
            productImage: '/static/product-example.png'
          });
        }
        
        if (isRefresh) {
          this.orderList = newOrderData;
        } else {
          this.orderList = this.orderList.concat(newOrderData);
        }
        
        if (newOrderData.length < this.pageSize || this.currentPage >= 5) {
          this.loadMoreStatus = 'noMore';
          this.isAllLoaded = true;
        } else {
          this.currentPage++;
          this.loadMoreStatus = 'more';
        }
      }, 800);
    },
    
    openLocationMap(orderItem) {
      uni.openLocation({
        latitude: orderItem.latitude,
        longitude: orderItem.longitude,
        name: orderItem.deliveryAddress,
        address: orderItem.deliveryAddress,
        scale: 18
      });
    },
    
    makePhoneCall(phoneNumber) {
      if (!phoneNumber) {
        uni.showToast({ title: '无效的电话号码', icon: 'none' });
        return;
      }
      uni.makePhoneCall({
        phoneNumber: phoneNumber
      });
    },
    
    getStatusClass(status) {
      const statusClassMap = {
        'expired': 'status-expired',
        'delivering': 'status-delivering',
        'pending': 'status-pending',
        'completed': 'status-completed'
      };
      return statusClassMap[status] || '';
    },
    
    getStatusText(status) {
      const statusTextMap = {
        'expired': '已超时',
        'delivering': '配送中',
        'pending': '待配送',
        'completed': '已完成'
      };
      return statusTextMap[status] || '未知状态';
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.delivery-home-page {
  min-height: 100vh;
  background: $bg-page;
  padding: $spacing-md 0;
}

.search-section {
  padding: $spacing-md;
  background: $bg-primary;
  border-radius: $radius-medium;
  margin-bottom: $spacing-md;
  box-shadow: $shadow-light;
}

.search-container {
  display: flex;
  align-items: center;
  background: $bg-secondary;
  border-radius: $radius-xl;
  padding: $spacing-sm $spacing-md;
  border: 1rpx solid $border-secondary;
}

.search-input {
  flex: 1;
  margin-left: $spacing-sm;
  font-size: $font-size-md;
  color: $text-primary;
}

.status-filter-section {
  display: flex;
  background: $bg-primary;
  padding: $spacing-md;
  border-radius: $radius-medium;
  margin-bottom: $spacing-md;
  box-shadow: $shadow-light;
}

.status-filter-item {
  flex: 1;
  text-align: center;
  font-size: $font-size-md;
  color: $text-secondary;
  position: relative;
  padding: $spacing-sm 0;
  transition: all 0.3s ease;
  
  &.active {
    color: $primary-blue;
    font-weight: 600;
    
    &::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 40rpx;
      height: 4rpx;
      background: $primary-blue;
      border-radius: 2rpx;
    }
  }
}

.order-list-container {
  padding: $spacing-sm;
}

.order-item-card {
  background: $bg-primary;
  margin-bottom: $spacing-md;
  border-radius: $radius-medium;
  padding: $spacing-md;
  box-shadow: $shadow-light;
  transition: all 0.3s ease;
  
  &:active {
    transform: translateY(2rpx);
    box-shadow: $shadow-medium;
  }
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: $spacing-md;
  padding-bottom: $spacing-sm;
  border-bottom: 1rpx solid $border-light;
}

.order-number {
  font-size: $font-size-md;
  color: $text-primary;
  font-weight: 500;
}

.order-status {
  font-size: $font-size-sm;
  padding: 4rpx 12rpx;
  border-radius: $radius-small;
  font-weight: 500;
  
  &.status-expired {
    background: rgba($error-red, 0.1);
    color: $error-red;
  }
  
  &.status-delivering {
    background: rgba($status-delivering, 0.1);
    color: $status-delivering;
  }
  
  &.status-pending {
    background: rgba($status-pending, 0.1);
    color: $status-pending;
  }
  
  &.status-completed {
    background: rgba($status-completed, 0.1);
    color: $status-completed;
  }
}

.order-content {
  display: flex;
  align-items: flex-start;
}

.product-image {
  width: 120rpx;
  height: 120rpx;
  border-radius: $radius-small;
  margin-right: $spacing-md;
  background: $bg-secondary;
}

.order-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 120rpx;
}

.delivery-address {
  font-size: $font-size-md;
  color: $text-primary;
  margin-bottom: $spacing-xs;
  line-height: 1.4;
}

.delivery-time {
  font-size: $font-size-sm;
  color: $text-secondary;
  margin-bottom: $spacing-sm;
}

.action-buttons {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: $spacing-sm;
}

.action-button {
  width: 56rpx;
  height: 56rpx;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  
  &.phone-button {
    background: rgba($primary-blue, 0.1);
    
    &:active {
      background: rgba($primary-blue, 0.2);
      transform: scale(0.95);
    }
  }
  
  &.map-button {
    background: rgba($success-green, 0.1);
    
    &:active {
      background: rgba($success-green, 0.2);
      transform: scale(0.95);
    }
  }
}
</style> 