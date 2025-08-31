<template>
	<view class="container">
		<!-- 顶部信息卡片 -->
		<view class="header-card">
			<view class="user-info">
				<image class="avatar" :src="userInfo.avatar || '/static/default-avatar.png'" mode="aspectFill"></image>
				<view class="user-details">
					<text class="nickname">{{ userInfo.nickname || '配送员' }}</text>
					<text class="status" :class="userInfo.workStatus === 1 ? 'online' : 'offline'">
						{{ userInfo.workStatus === 1 ? '在线' : '离线' }}
					</text>
				</view>
			</view>
			<view class="work-status-toggle">
				<switch :checked="userInfo.workStatus === 1" @change="toggleWorkStatus" color="#3cc51f" />
			</view>
		</view>

		<!-- 统计信息 -->
		<view class="stats-section">
			<view class="stat-item">
				<text class="stat-number">{{ stats.pending }}</text>
				<text class="stat-label">待配送</text>
			</view>
			<view class="stat-item">
				<text class="stat-number">{{ stats.delivering }}</text>
				<text class="stat-label">配送中</text>
			</view>
			<view class="stat-item">
				<text class="stat-number">{{ stats.completed }}</text>
				<text class="stat-label">已完成</text>
			</view>
		</view>

		<!-- 快捷操作 -->
		<view class="quick-actions">
			<view class="action-item" @click="goToOrders('pending')">
				<view class="action-icon pending">📦</view>
				<text class="action-text">待取货</text>
			</view>
			<view class="action-item" @click="goToOrders('delivering')">
				<view class="action-icon delivering">🚚</view>
				<text class="action-text">配送中</text>
			</view>
			<view class="action-item" @click="goToOrders('completed')">
				<view class="action-icon completed">✅</view>
				<text class="action-text">已完成</text>
			</view>
		</view>

		<!-- 最近订单 -->
		<view class="recent-orders">
			<view class="section-header">
				<text class="section-title">最近订单</text>
				<text class="more" @click="goToOrderList">查看更多</text>
			</view>
			<view class="order-list">
				<view v-for="order in recentOrders" :key="order.id" class="order-item" @click="goToOrderDetail(order.id)">
					<view class="order-info">
						<text class="order-id">订单号：{{ order.orderId }}</text>
						<text class="order-status" :class="getStatusClass(order.deliveryStatus)">
							{{ getStatusText(order.deliveryStatus) }}
						</text>
					</view>
					<view class="order-time">
						<text class="time">{{ formatTime(order.createTime) }}</text>
						<text class="arrow">></text>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			userInfo: {
				nickname: '张三',
				avatar: '',
				workStatus: 1
			},
			stats: {
				pending: 0,
				delivering: 0,
				completed: 0
			},
			recentOrders: []
		}
	},
	onLoad() {
		this.loadUserInfo()
		this.loadStats()
		this.loadRecentOrders()
	},
	methods: {
		// 加载用户信息
		loadUserInfo() {
			// TODO: 调用接口获取用户信息
		},
		
		// 加载统计数据
		loadStats() {
			// TODO: 调用接口获取统计数据
		},
		
		// 加载最近订单
		loadRecentOrders() {
			// TODO: 调用接口获取最近订单
		},
		
		// 切换工作状态
		toggleWorkStatus(e) {
			const newStatus = e.detail.value ? 1 : 2
			// TODO: 调用接口更新工作状态
			this.userInfo.workStatus = newStatus
		},
		
		// 跳转到订单列表
		goToOrders(status) {
			uni.navigateTo({
				url: `/pages/order/list?status=${status}`
			})
		},
		
		// 跳转到订单详情
		goToOrderDetail(id) {
			uni.navigateTo({
				url: `/pages/order/detail?id=${id}`
			})
		},
		
		// 跳转到订单列表
		goToOrderList() {
			uni.switchTab({
				url: '/pages/order/list'
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
		
		// 格式化时间
		formatTime(time) {
			if (!time) return ''
			const date = new Date(time)
			return `${date.getMonth() + 1}-${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
		}
	}
}
</script>

<style>
.container {
	padding: 20rpx;
	background-color: #f5f5f5;
	min-height: 100vh;
}

.header-card {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border-radius: 20rpx;
	padding: 40rpx;
	margin-bottom: 30rpx;
	display: flex;
	justify-content: space-between;
	align-items: center;
	color: white;
}

.user-info {
	display: flex;
	align-items: center;
}

.avatar {
	width: 120rpx;
	height: 120rpx;
	border-radius: 60rpx;
	margin-right: 30rpx;
	border: 4rpx solid rgba(255, 255, 255, 0.3);
}

.user-details {
	display: flex;
	flex-direction: column;
}

.nickname {
	font-size: 36rpx;
	font-weight: bold;
	margin-bottom: 10rpx;
}

.status {
	font-size: 24rpx;
	padding: 8rpx 20rpx;
	border-radius: 20rpx;
	background: rgba(255, 255, 255, 0.2);
}

.status.online {
	background: rgba(76, 175, 80, 0.8);
}

.status.offline {
	background: rgba(158, 158, 158, 0.8);
}

.work-status-toggle {
	transform: scale(0.8);
}

.stats-section {
	display: flex;
	justify-content: space-around;
	margin-bottom: 30rpx;
}

.stat-item {
	background: white;
	border-radius: 20rpx;
	padding: 30rpx;
	text-align: center;
	flex: 1;
	margin: 0 10rpx;
	box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.1);
}

.stat-number {
	display: block;
	font-size: 48rpx;
	font-weight: bold;
	color: #3cc51f;
	margin-bottom: 10rpx;
}

.stat-label {
	font-size: 24rpx;
	color: #666;
}

.quick-actions {
	display: flex;
	justify-content: space-around;
	margin-bottom: 30rpx;
}

.action-item {
	background: white;
	border-radius: 20rpx;
	padding: 30rpx;
	text-align: center;
	flex: 1;
	margin: 0 10rpx;
	box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.1);
}

.action-icon {
	font-size: 60rpx;
	margin-bottom: 20rpx;
}

.action-text {
	font-size: 26rpx;
	color: #333;
}

.recent-orders {
	background: white;
	border-radius: 20rpx;
	padding: 30rpx;
	box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.1);
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30rpx;
}

.section-title {
	font-size: 32rpx;
	font-weight: bold;
	color: #333;
}

.more {
	font-size: 26rpx;
	color: #3cc51f;
}

.order-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20rpx 0;
	border-bottom: 1rpx solid #f0f0f0;
}

.order-item:last-child {
	border-bottom: none;
}

.order-info {
	flex: 1;
}

.order-id {
	display: block;
	font-size: 28rpx;
	color: #333;
	margin-bottom: 10rpx;
}

.order-status {
	font-size: 24rpx;
	padding: 6rpx 16rpx;
	border-radius: 16rpx;
}

.order-status.pending {
	background: #fff3e0;
	color: #f57c00;
}

.order-status.delivering {
	background: #e3f2fd;
	color: #1976d2;
}

.order-status.completed {
	background: #e8f5e8;
	color: #388e3c;
}

.order-status.cancelled {
	background: #ffebee;
	color: #d32f2f;
}

.order-time {
	display: flex;
	align-items: center;
}

.time {
	font-size: 24rpx;
	color: #999;
	margin-right: 20rpx;
}

.arrow {
	font-size: 24rpx;
	color: #ccc;
}
</style>
