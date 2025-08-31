<template>
	<view class="container">
		<!-- 订单状态 -->
		<view class="status-section">
			<view class="status-icon" :class="getStatusClass(orderInfo.deliveryStatus)">
				{{ getStatusIcon(orderInfo.deliveryStatus) }}
			</view>
			<text class="status-text">{{ getStatusText(orderInfo.deliveryStatus) }}</text>
			<text class="status-desc">{{ getStatusDesc(orderInfo.deliveryStatus) }}</text>
		</view>

		<!-- 订单信息 -->
		<view class="order-info-section">
			<view class="section-title">订单信息</view>
			<view class="info-list">
				<view class="info-item">
					<text class="info-label">订单编号</text>
					<text class="info-value">{{ orderInfo.orderId }}</text>
				</view>
				<view class="info-item">
					<text class="info-label">配送订单号</text>
					<text class="info-value">{{ orderInfo.id }}</text>
				</view>
				<view class="info-item">
					<text class="info-label">创建时间</text>
					<text class="info-value">{{ formatTime(orderInfo.createTime) }}</text>
				</view>
				<view class="info-item" v-if="orderInfo.pickupTime">
					<text class="info-label">取货时间</text>
					<text class="info-value">{{ formatTime(orderInfo.pickupTime) }}</text>
				</view>
				<view class="info-item" v-if="orderInfo.deliveryTime">
					<text class="info-label">送达时间</text>
					<text class="info-value">{{ formatTime(orderInfo.deliveryTime) }}</text>
				</view>
			</view>
		</view>

		<!-- 配送信息 -->
		<view class="delivery-section">
			<view class="section-title">配送信息</view>
			<view class="delivery-info">
				<view class="delivery-item">
					<view class="delivery-icon pickup">📦</view>
					<view class="delivery-content">
						<text class="delivery-title">取货点</text>
						<text class="delivery-address">商户门店地址</text>
					</view>
				</view>
				<view class="delivery-line"></view>
				<view class="delivery-item">
					<view class="delivery-icon delivery">🏠</view>
					<view class="delivery-content">
						<text class="delivery-title">收货地址</text>
						<text class="delivery-address">用户收货地址</text>
					</view>
				</view>
			</view>
		</view>

		<!-- 商品信息 -->
		<view class="goods-section">
			<view class="section-title">商品信息</view>
			<view class="goods-list">
				<view class="goods-item" v-for="(goods, index) in goodsList" :key="index">
					<image class="goods-image" :src="goods.image" mode="aspectFill"></image>
					<view class="goods-info">
						<text class="goods-name">{{ goods.name }}</text>
						<text class="goods-spec">{{ goods.spec }}</text>
						<view class="goods-price">
							<text class="price">¥{{ goods.price }}</text>
							<text class="count">x{{ goods.count }}</text>
						</view>
					</view>
				</view>
			</view>
		</view>

		<!-- 操作按钮 -->
		<view class="action-section">
			<view v-if="orderInfo.deliveryStatus === 1" class="action-btn primary" @click="pickupOrder">
				开始取货
			</view>
			<view v-if="orderInfo.deliveryStatus === 2" class="action-btn primary" @click="deliverOrder">
				确认送达
			</view>
			<view v-if="orderInfo.deliveryStatus < 3" class="action-btn secondary" @click="cancelOrder">
				取消配送
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			orderId: null,
			orderInfo: {
				id: '',
				orderId: '',
				deliveryStatus: 1,
				createTime: '',
				pickupTime: '',
				deliveryTime: ''
			},
			goodsList: [
				{
					image: '/static/goods1.png',
					name: '商品名称1',
					spec: '规格：标准',
					price: '99.00',
					count: 2
				},
				{
					image: '/static/goods2.png',
					name: '商品名称2',
					spec: '规格：大号',
					price: '199.00',
					count: 1
				}
			]
		}
	},
	onLoad(options) {
		if (options.id) {
			this.orderId = options.id
			this.loadOrderDetail()
		}
	},
	methods: {
		// 加载订单详情
		async loadOrderDetail() {
			try {
				uni.showLoading({ title: '加载中...' })
				
				// TODO: 调用接口获取订单详情
				await new Promise(resolve => setTimeout(resolve, 1000))
				
				// 模拟数据
				this.orderInfo = {
					id: this.orderId,
					orderId: `ORDER${this.orderId}`,
					deliveryStatus: 1,
					createTime: new Date(Date.now() - 86400000 * 2),
					pickupTime: null,
					deliveryTime: null
				}
				
				uni.hideLoading()
			} catch (error) {
				uni.hideLoading()
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				})
			}
		},
		
		// 开始取货
		async pickupOrder() {
			try {
				uni.showModal({
					title: '确认取货',
					content: '确定要开始取货吗？',
					success: async (res) => {
						if (res.confirm) {
							uni.showLoading({ title: '处理中...' })
							
							// TODO: 调用接口开始取货
							await new Promise(resolve => setTimeout(resolve, 1000))
							
							// 更新状态
							this.orderInfo.deliveryStatus = 2
							this.orderInfo.pickupTime = new Date()
							
							uni.hideLoading()
							uni.showToast({
								title: '取货成功',
								icon: 'success'
							})
						}
					}
				})
			} catch (error) {
				uni.hideLoading()
				uni.showToast({
					title: '操作失败',
					icon: 'none'
				})
			}
		},
		
		// 确认送达
		async deliverOrder() {
			try {
				uni.showModal({
					title: '确认送达',
					content: '确定要确认送达吗？',
					success: async (res) => {
						if (res.confirm) {
							uni.showLoading({ title: '处理中...' })
							
							// TODO: 调用接口确认送达
							await new Promise(resolve => setTimeout(resolve, 1000))
							
							// 更新状态
							this.orderInfo.deliveryStatus = 3
							this.orderInfo.deliveryTime = new Date()
							
							uni.hideLoading()
							uni.showToast({
								title: '送达成功',
								icon: 'success'
							})
						}
					}
				})
			} catch (error) {
				uni.hideLoading()
				uni.showToast({
					title: '操作失败',
					icon: 'none'
				})
			}
		},
		
		// 取消配送
		async cancelOrder() {
			uni.showModal({
				title: '确认取消',
				content: '确定要取消这个配送订单吗？',
				success: async (res) => {
					if (res.confirm) {
						try {
							uni.showLoading({ title: '处理中...' })
							
							// TODO: 调用接口取消配送
							await new Promise(resolve => setTimeout(resolve, 1000))
							
							// 更新状态
							this.orderInfo.deliveryStatus = 4
							
							uni.hideLoading()
							uni.showToast({
								title: '取消成功',
								icon: 'success'
							})
						} catch (error) {
							uni.hideLoading()
							uni.showToast({
								title: '操作失败',
								icon: 'none'
							})
						}
					}
				}
			})
		},
		
		// 获取状态样式类
		getStatusClass(status) {
			const statusMap = {
				1: 'pending',
				2: 'delivering',
				3: 'completed',
				4: 'cancelled'
			}
			return statusMap[status] || 'pending'
		},
		
		// 获取状态图标
		getStatusIcon(status) {
			const statusMap = {
				1: '📦',
				2: '🚚',
				3: '✅',
				4: '❌'
			}
			return statusMap[status] || '📦'
		},
		
		// 获取状态文本
		getStatusText(status) {
			const statusMap = {
				1: '待配送',
				2: '配送中',
				3: '已送达',
				4: '已取消'
			}
			return statusMap[status] || '待配送'
		},
		
		// 获取状态描述
		getStatusDesc(status) {
			const statusMap = {
				1: '订单已分配，请及时取货',
				2: '正在配送中，请注意安全',
				3: '配送完成，感谢您的服务',
				4: '配送已取消'
			}
			return statusMap[status] || '订单已分配，请及时取货'
		},
		
		// 格式化时间
		formatTime(time) {
			if (!time) return ''
			const date = new Date(time)
			return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`
		}
	}
}
</script>

<style>
.container {
	background-color: #f5f5f5;
	min-height: 100vh;
	padding-bottom: 120rpx;
}

.status-section {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 60rpx 40rpx;
	text-align: center;
	color: white;
}

.status-icon {
	font-size: 80rpx;
	margin-bottom: 20rpx;
}

.status-text {
	display: block;
	font-size: 36rpx;
	font-weight: bold;
	margin-bottom: 20rpx;
}

.status-desc {
	font-size: 26rpx;
	opacity: 0.9;
}

.order-info-section,
.delivery-section,
.goods-section {
	background: white;
	margin: 20rpx;
	border-radius: 20rpx;
	padding: 30rpx;
	box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.1);
}

.section-title {
	font-size: 32rpx;
	font-weight: bold;
	color: #333;
	margin-bottom: 30rpx;
	padding-left: 20rpx;
	border-left: 6rpx solid #3cc51f;
}

.info-list {
	display: flex;
	flex-direction: column;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20rpx 0;
	border-bottom: 1rpx solid #f0f0f0;
}

.info-item:last-child {
	border-bottom: none;
}

.info-label {
	font-size: 28rpx;
	color: #666;
}

.info-value {
	font-size: 28rpx;
	color: #333;
	font-weight: bold;
}

.delivery-info {
	position: relative;
}

.delivery-item {
	display: flex;
	align-items: center;
	margin-bottom: 30rpx;
}

.delivery-item:last-child {
	margin-bottom: 0;
}

.delivery-icon {
	font-size: 40rpx;
	margin-right: 20rpx;
	width: 60rpx;
	text-align: center;
}

.delivery-content {
	flex: 1;
}

.delivery-title {
	display: block;
	font-size: 28rpx;
	color: #333;
	margin-bottom: 10rpx;
}

.delivery-address {
	font-size: 26rpx;
	color: #666;
}

.delivery-line {
	position: absolute;
	left: 30rpx;
	top: 60rpx;
	bottom: 60rpx;
	width: 2rpx;
	background: #ddd;
}

.goods-list {
	display: flex;
	flex-direction: column;
}

.goods-item {
	display: flex;
	padding: 20rpx 0;
	border-bottom: 1rpx solid #f0f0f0;
}

.goods-item:last-child {
	border-bottom: none;
}

.goods-image {
	width: 120rpx;
	height: 120rpx;
	border-radius: 10rpx;
	margin-right: 20rpx;
}

.goods-info {
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.goods-name {
	font-size: 28rpx;
	color: #333;
	margin-bottom: 10rpx;
}

.goods-spec {
	font-size: 24rpx;
	color: #999;
	margin-bottom: 10rpx;
}

.goods-price {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.price {
	font-size: 28rpx;
	color: #ff4757;
	font-weight: bold;
}

.count {
	font-size: 24rpx;
	color: #999;
}

.action-section {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	background: white;
	padding: 20rpx;
	box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.1);
	display: flex;
	gap: 20rpx;
}

.action-btn {
	flex: 1;
	height: 80rpx;
	border: none;
	border-radius: 40rpx;
	font-size: 28rpx;
	font-weight: bold;
}

.action-btn.primary {
	background: #3cc51f;
	color: white;
}

.action-btn.secondary {
	background: #f5f5f5;
	color: #666;
	border: 1rpx solid #ddd;
}
</style>
