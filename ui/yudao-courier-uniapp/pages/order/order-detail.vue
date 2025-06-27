<template>
  <view class="order-detail-page">
    <!-- 订单状态卡片 -->
    <view class="order-status-card">
      <view class="status-header">
        <uni-icons type="info" size="24" color="#fff"></uni-icons>
        <text class="status-title">{{ orderDetail.statusText }}</text>
      </view>
      <view class="status-description">
        {{ getStatusDescription(orderDetail.status) }}
      </view>
    </view>
    
    <!-- 商品列表 -->
    <goods-list :goods-list="orderDetail.goodsList" />
    
    <!-- 配送信息卡片 -->
    <delivery-card 
      :order="orderDetail"
      @make-phone-call="handlePhoneCall"
      @open-map="handleOpenMap"
    />
    
    <!-- 操作按钮 -->
    <action-buttons 
      :order-status="orderDetail.status"
      @confirm-delivered="handleConfirmDelivered"
    />
  </view>
</template>

<script>
import GoodsList from '@/components/goods-list.vue'
import DeliveryCard from '@/components/delivery-card.vue'
import ActionButtons from '@/components/action-buttons.vue'

// 订单状态常量
const ORDER_STATUS = {
  DELIVERING: 'delivering',
  DELIVERED: 'delivered',
  COMPLETED: 'completed'
}

const STATUS_TEXT_MAP = {
  [ORDER_STATUS.DELIVERING]: '正在配送',
  [ORDER_STATUS.DELIVERED]: '已送达',
  [ORDER_STATUS.COMPLETED]: '已完成'
}

const STATUS_DESCRIPTION_MAP = {
  [ORDER_STATUS.DELIVERING]: '请及时配送，注意安全',
  [ORDER_STATUS.DELIVERED]: '等待客户确认收货',
  [ORDER_STATUS.COMPLETED]: '订单已完成'
}

export default {
  name: 'OrderDetailPage',
  components: {
    GoodsList,
    DeliveryCard,
    ActionButtons
  },
  data() {
    return {
      orderDetail: {
        status: '',
        statusText: '',
        goodsList: [],
        deliveryInfo: {
          customerName: '',
          customerPhone: '',
          deliveryAddress: '',
          expectedDeliveryTime: '',
          latitude: 39.908823,
          longitude: 116.397470
        },
        orderNumber: '',
        customerRemark: ''
      }
    }
  },
  
  onLoad(options) {
    this.initializeOrderDetail(options.id)
  },
  
  methods: {
    /**
     * 初始化订单详情
     */
    async initializeOrderDetail(orderId) {
      if (!orderId) {
        this.showToastMessage('订单ID不能为空')
        return
      }
      
      try {
        await this.fetchOrderDetailData(orderId)
      } catch (error) {
        console.error('获取订单详情失败:', error)
        this.showToastMessage('获取订单详情失败')
      }
    },
    
    /**
     * 获取订单详情数据
     */
    async fetchOrderDetailData(orderId) {
      // 模拟数据
      this.orderDetail = {
        status: ORDER_STATUS.DELIVERING,
        statusText: STATUS_TEXT_MAP[ORDER_STATUS.DELIVERING],
        goodsList: [
          {
            id: 1,
            goodsImage: '/static/product-example.png',
            goodsTitle: '安泉矿泉水',
            goodsSpec: '规格：500ml x 12瓶',
            goodsQuantity: 2
          },
          {
            id: 2,
            goodsImage: '/static/product-example.png',
            goodsTitle: '安泉纯净水',
            goodsSpec: '规格：1L x 6瓶',
            goodsQuantity: 1
          }
        ],
        deliveryInfo: {
          customerName: '李四',
          customerPhone: '139****8888',
          latitude: 30.59225,
          longitude: 114.367353,
          deliveryAddress: '上海市浦东新区测试路200号',
          expectedDeliveryTime: '2024-01-26 15:00'
        },
        orderNumber: 'AQ202401260002',
        customerRemark: '请轻拿轻放，谢谢！'
      }
    },
    
    /**
     * 处理拨打电话
     */
    handlePhoneCall() {
      const { customerPhone } = this.orderDetail.deliveryInfo
      if (!customerPhone) {
        this.showToastMessage('电话号码不存在')
        return
      }
      
      this.makePhoneCall(customerPhone)
    },
    
    /**
     * 拨打电话
     */
    makePhoneCall(phoneNumber) {
      uni.makePhoneCall({
        phoneNumber,
        success: () => {
          console.log('拨打电话成功')
        },
        fail: (error) => {
          console.error('拨打电话失败:', error)
          this.showToastMessage('拨打电话失败')
        }
      })
    },
    
    /**
     * 处理打开地图
     */
    handleOpenMap() {
      const { deliveryAddress: address, latitude, longitude } = this.orderDetail.deliveryInfo
      
      if (!address || !latitude || !longitude) {
        this.showToastMessage('地址信息不完整')
        return
      }
      
      this.openLocationMap({ address, latitude, longitude })
    },
    
    /**
     * 打开地图
     */
    openLocationMap({ address, latitude, longitude }) {
      uni.openLocation({
        latitude,
        longitude,
        name: address,
        address,
        success: () => {
          console.log('打开地图成功')
        },
        fail: (error) => {
          console.error('打开地图失败:', error)
          this.showToastMessage('打开地图失败')
        }
      })
    },
    
    /**
     * 处理确认送达
     */
    async handleConfirmDelivered() {
      const confirmed = await this.showConfirmDialog('确认送达', '确定已送达该订单？')
      if (!confirmed) return
      
      try {
        await this.confirmOrderDelivered()
        this.updateOrderStatus(ORDER_STATUS.DELIVERED)
        this.showToastMessage('送达成功', 'success')
      } catch (error) {
        console.error('确认送达失败:', error)
        this.showToastMessage('送达失败')
      }
    },
    
    /**
     * 确认送达API调用
     */
    async confirmOrderDelivered() {
      // 模拟API调用
      return new Promise((resolve) => {
        setTimeout(resolve, 500)
      })
    },
    
    /**
     * 更新订单状态
     */
    updateOrderStatus(status) {
      this.orderDetail.status = status
      this.orderDetail.statusText = STATUS_TEXT_MAP[status]
    },
    
    /**
     * 获取状态描述
     */
    getStatusDescription(status) {
      return STATUS_DESCRIPTION_MAP[status] || '未知状态'
    },
    
    /**
     * 显示确认对话框
     */
    showConfirmDialog(title, content) {
      return new Promise((resolve) => {
        uni.showModal({
          title,
          content,
          success: (res) => resolve(res.confirm)
        })
      })
    },
    
    /**
     * 显示提示信息
     */
    showToastMessage(title, icon = 'none') {
      uni.showToast({ title, icon })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/uni.scss';

.order-detail-page {
  padding: $spacing-md;
  background: $bg-page;
  min-height: 100vh;
}

.order-status-card {
  background: $gradient-primary;
  border-radius: $radius-large;
  padding: $spacing-lg;
  margin-bottom: $spacing-md;
  color: $bg-primary;
  box-shadow: $shadow-medium;
  
  .status-header {
    display: flex;
    align-items: center;
    margin-bottom: $spacing-sm;
    
    .status-title {
      font-size: $font-size-xl;
      font-weight: 600;
      margin-left: $spacing-sm;
      text-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);
    }
  }
  
  .status-description {
    font-size: $font-size-md;
    opacity: 0.9;
    line-height: 1.4;
  }
}
</style> 