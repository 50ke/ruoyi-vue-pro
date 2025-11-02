<template>
	<view class="order-detail-page">
		<!-- 订单状态卡片 -->
		<view class="order-status-card">
			<view class="status-header">
				<uni-icons type="info" size="24" color="#fff"></uni-icons>
				<text class="status-title">{{ convertDeliveryStatusText(deliveryOrderDetail.deliveryStatus) }}</text>
			</view>
			<view class="status-description">
				{{ convertDeliveryStatusDescription(deliveryOrderDetail.deliveryStatus) }}
			</view>
		</view>

		<!-- 商品列表 -->
		<goods-list :goods-list="deliveryOrderDetail.items" />

		<!-- 配送信息卡片 -->
		<delivery-card :order="deliveryOrderDetail" @make-phone-call="handlePhoneCall" @open-map="handleOpenMap" />

		<!-- 操作按钮 -->
		<action-buttons :order-status="deliveryOrderDetail.deliveryStatus" @confirm-delivered="handleDelivery" />
	</view>
</template>

<script>
	import GoodsList from '@/components/goods-list.vue'
	import DeliveryCard from '@/components/delivery-card.vue'
	import ActionButtons from '@/components/action-buttons.vue'
	import {
		orderApi
	} from '@/api/order'
	import {
		userApi
	} from '@/api/user'

	export default {
		components: {
			GoodsList,
			DeliveryCard,
			ActionButtons
		},
		data() {
			return {
				deliveryStatusOptions: [{
						label: '待配送',
						value: 1,
						class: 'status-pending',
						description: '请尽快安排配送，避免订单超时'
					},
					{
						label: '配送中',
						value: 2,
						class: 'status-delivering',
						description: '请及时配送，注意安全'
					},
					{
						label: '已送达',
						value: 3,
						class: 'status-completed',
						description: '订单已送达'
					},
					{
						label: '已取消',
						value: 4,
						class: 'status-expired',
						description: '订单已取消'
					}
				],
				deliveryOrderDetail: {
					id: 0,
					no: '',
					receiverName: '',
					receiverMobile: '',
					receiverDetailArea: '',
					receiverDetailAddress: '',
					deliveryStatus: 1,
					createTime: '',
					pickupTime: '',
					deliveryTime: '',
					latitude: 39.908823,
					longitude: 116.397470,
					orderItems: [],
					userRemark: ''
				}
			}
		},

		methods: {
			convertDeliveryStatusClass(deliveryStatus) {
				const item = this.deliveryStatusOptions.find(item => item.value === status)
				if (item) {
					return item.class
				}
			},
			convertDeliveryStatusText(deliveryStatus) {
				const item = this.deliveryStatusOptions.find(item => item.value === status)
				if (item) {
					return item.label
				}
			},
			convertDeliveryStatusDescription(deliveryStatus) {
				const item = this.deliveryStatusOptions.find(item => item.value === status)
				if (item) {
					return item.description
				}
			},

			/**
			 * 初始化订单详情
			 */
			async refreshDeliveryOrderDetail(orderId) {
				if (!orderId) {
					uni.showToast({
						title: '配送订单不存在',
						icon: 'none'
					});
					return
				}

				try {
					await this.fetchDeliveryOrderDetail(orderId)
				} catch (error) {
					console.error('获取配送订单详情失败:', error)
					uni.showToast({
						title: '获取配送订单详情失败',
						icon: 'none'
					});
				}
			},

			/**
			 * 获取订单详情数据
			 */
			async fetchDeliveryOrderDetail(orderId) {
				try {
					const data = await orderApi.getCourierOrderDetail(orderId);
					if (data) {
						this.deliveryOrderDetail = data;
						this.deliveryOrderDetail.longitude = 116.397470;
						this.deliveryOrderDetail.latitude = 39.908823;
					} else {
						uni.showToast({
							title: '获取配送订单详情失败',
							icon: 'none'
						});
					}
				} catch (e) {
					console.error('获取配送订单详情失败:', error)
					uni.showToast({
						title: '获取配送订单详情失败',
						icon: 'none'
					});
				}
			},

			/**
			 * 处理拨打电话
			 */
			handlePhoneCall() {
				if (!this.deliveryOrderDetail.receiverMobile) {
					uni.showToast({
						title: '无效的电话号码',
						icon: 'none'
					});
					return;
				}
				uni.makePhoneCall({
					phoneNumber: this.deliveryOrderDetail.receiverMobile
				});
			},

			/**
			 * 处理打开地图
			 */
			handleOpenMap() {
				uni.openLocation({
					latitude: this.deliveryOrderDetail.latitude,
					longitude: this.deliveryOrderDetail.longitude,
					name: this.deliveryOrderDetail.receiverDetailArea,
					address: this.deliveryOrderDetail.receiverDetailArea,
					scale: 18
				});
			},

			/**
			 * 处理配送
			 */
			async handleDelivery() {
				let status = ORDER_STATUS.DELIVERED
				let confirmed = false
				if (this.orderDetail.deliveryStatus === ORDER_STATUS.WAIT_DELIVERY) {
					confirmed = await this.showConfirmDialog('开始配送', '确定开始配送该订单？')
					status = ORDER_STATUS.DELIVERING
				} else if (this.orderDetail.deliveryStatus === ORDER_STATUS.DELIVERING) {
					confirmed = await this.showConfirmDialog('确认送达', '确定已送达该订单？')
					status = ORDER_STATUS.DELIVERED
				} else if (this.orderDetail.deliveryStatus === ORDER_STATUS.DELIVERED) {
					this.showToastMessage('订单已完成配送', 'success')
					return
				} else if (this.orderDetail.deliveryStatus === ORDER_STATUS.CANCELED) {
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
		},
		onShow(options) {
			this.refreshDeliveryOrderDetail(options.id)
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