<template>
  <view class="order-detail-page">
    <!-- 订单状态卡片 -->
    <view class="order-status-card">
      <view class="status-header">
        <uni-icons type="info" size="24" color="#fff"></uni-icons>
        <text class="status-title">{{ orderDetail.deliveryStatusText }}</text>
      </view>
      <view class="status-description">
        {{ getStatusDescription(orderDetail.deliveryStatus) }}
      </view>
    </view>
    
    <!-- 商品列表 -->
    <goods-list :goods-list="orderDetail.items" />
    
    <!-- 配送信息卡片 -->
    <delivery-card 
      :order="orderDetail"
      @make-phone-call="handlePhoneCall"
      @open-map="handleOpenMap"
    />
    
    <!-- 操作按钮 -->
    <action-buttons 
      :order-status="orderDetail.deliveryStatus"
      @confirm-delivered="handleDelivery"
    />
  </view>
</template>

<script>
import GoodsList from '@/components/goods-list.vue'
import DeliveryCard from '@/components/delivery-card.vue'
import ActionButtons from '@/components/action-buttons.vue'
import { getOrderDetail, updateOrderStatus } from '@/api/order.js';
import { checkLogin } from '@/utils/auth.js';

// 订单状态常量
const ORDER_STATUS = {
  WAIT_DELIVERY: 1,
  DELIVERING: 2,
  DELIVERED: 3,
  CANCELED: 4
}

const STATUS_TEXT_MAP = {
  [ORDER_STATUS.WAIT_DELIVERY]: '待配送',
  [ORDER_STATUS.DELIVERING]: '配送中',
  [ORDER_STATUS.DELIVERED]: '已送达',
  [ORDER_STATUS.CANCELED]: '已取消'
}

const STATUS_DESCRIPTION_MAP = {
  [ORDER_STATUS.WAIT_DELIVERY]: '请尽快安排配送，避免订单超时',
  [ORDER_STATUS.DELIVERING]: '请及时配送，注意安全',
  [ORDER_STATUS.DELIVERED]: '订单已送达',
  [ORDER_STATUS.CANCELED]: '订单已取消'
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
		id: '',
		no: '',
        deliveryStatus: ORDER_STATUS.WAIT_DELIVERY,
        deliveryStatusText: '',
		receiverName: '',
		receiverMobile: '',
		receiverDetailArea: '',
		receiverDetailAddress: '',
		latitude: 39.908823,
		longitude: 116.397470,
        items: [],
        remark: ''
      }
    }
  },
  
  onLoad(options) {
    if (!checkLogin()) return;
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
      try {
        const res = await getOrderDetail(orderId);
        if (res.code === 0 && res.data) {
          this.orderDetail = res.data;
		  this.orderDetail.deliveryStatusText = STATUS_TEXT_MAP[this.orderDetail.deliveryStatus] || '未知状态';
		  this.orderDetail.longitude = 116.397470;
		  this.orderDetail.latitude = 39.908823;
        } else {
          this.showToastMessage(res.msg || '获取订单详情失败');
        }
      } catch (e) {
        this.showToastMessage('获取订单详情失败');
      }
    },
    
    /**
     * 处理拨打电话
     */
    handlePhoneCall() {
      const { customerPhone } = this.orderDetail.receiverMobile
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
      if (!this.orderDetail.receiverDetailArea || !this.orderDetail.latitude || !this.orderDetail.longitude) {
        this.showToastMessage('地址信息不完整')
        return
      }
      
      this.openLocationMap(this.orderDetail.receiverDetailArea, this.orderDetail.receiverDetailAddress, this.orderDetail.latitude, this.orderDetail.longitude)
    },
    
    /**
     * 打开地图
     */
    openLocationMap(receiverDetailArea, receiverDetailAddress, latitude, longitude) {
      uni.openLocation({
        latitude,
        longitude,
        name: receiverDetailArea,
        address: receiverDetailAddress,
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
     * 处理配送
     */
    async handleDelivery() {
		let status = ORDER_STATUS.DELIVERED
		let confirmed = false
	  if(this.orderDetail.deliveryStatus === ORDER_STATUS.WAIT_DELIVERY){
		  confirmed = await this.showConfirmDialog('开始配送', '确定开始配送该订单？')
		  status =  ORDER_STATUS.DELIVERING
	  }else if(this.orderDetail.deliveryStatus === ORDER_STATUS.DELIVERING){
		  confirmed = await this.showConfirmDialog('确认送达', '确定已送达该订单？')
		  status =  ORDER_STATUS.DELIVERED
	  }else if(this.orderDetail.deliveryStatus === ORDER_STATUS.DELIVERED){
		  this.showToastMessage('订单已完成配送', 'success')
		  return
	  }else if(this.orderDetail.deliveryStatus === ORDER_STATUS.CANCELED){
		  this.showToastMessage('订单已取消', 'success')
		  return
	  }
      if (!confirmed) return
	  console.log('----------------' + status + '------------' + confirmed)
      try {
        await this.updateOrderDeliveryStatus(status)
        this.showToastMessage('操作成功', 'success')
      } catch (error) {
        this.showToastMessage('操作失败')
      }
    },
    
    /**
     * 确认送达API调用
     */
    async updateOrderDeliveryStatus(deliveryStatus) {
      try {
		const params = {
		  orderId: this.orderDetail.id,
		  deliveryStatus: deliveryStatus
		};
        const res = await updateOrderStatus(params);
        if (res.code === 0 && res.data) {
			this.orderDetail.deliveryStatus = deliveryStatus
			this.orderDetail.deliveryStatusText = STATUS_TEXT_MAP[deliveryStatus]
        } else {
          this.showToastMessage(res.msg || '获取订单详情失败');
        }
      } catch (e) {
        this.showToastMessage('获取订单详情失败');
      }
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