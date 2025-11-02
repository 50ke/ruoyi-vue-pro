<template>
	<view class="delivery-home-page">
		<!-- 搜索栏 -->
<!-- 		<view class="search-section">
			<view class="search-container">
				<uni-icons type="search" size="16" color="#8c8c8c"></uni-icons>
				<input type="text" placeholder="搜索订单号或地址" v-model="searchKeyword" class="search-input" />
			</view>
		</view> -->

		<!-- 订单状态筛选 -->
		<view class="status-filter-section">
			<view v-for="(statusItem, index) in deliveryStatusOptions" :key="index" class="status-filter-item"
				:class="{ active: currentDeliveryStatus === statusItem.value }"
				@click="changeDeliveryStatus(statusItem.value)">
				{{statusItem.label}}
			</view>
		</view>

		<!-- 订单列表 -->
		<scroll-view scroll-y style="height: 70vh" @scrolltolower="loadMoreOrders" refresher-enabled
			:refresher-triggered="isRefreshing" @refresherrefresh="onPullDownRefresh">
			<view class="order-list-container">
				<view class="order-item-card" v-for="(orderItem, index) in filteredDeliveryOrderList" :key="index"
					@click="navigateToDeliveryOrderDetail(orderItem)">
					<view class="order-header">
						<view class="order-number">订单号：{{ orderItem.no }}</view>
						<view class="order-status" :class="convertDeliveryStatusClass(orderItem.deliveryStatus)">
							{{ convertDeliveryStatusText(orderItem.deliveryStatus) }}
						</view>
					</view>

					<view class="order-content">
						<image class="product-image" :src="orderItem.pic" mode="aspectFill" />
						<view class="order-info">
							<view class="delivery-address">配送地址：{{ orderItem.receiverDetailArea }}
								{{ orderItem.receiverDetailAddress }}
							</view>
							<view class="receiver-mobile">联系电话：{{ orderItem.receiverMobile }}</view>
							<view class="action-buttons">
								<view class="action-button phone-button"
									@click.stop="makePhoneCall(orderItem.receiverMobile)">
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
	import {
		orderApi
	} from '@/api/order'
	import {
		userApi
	} from '@/api/user'

	export default {
		data() {
			return {
				currentDeliveryStatus: 2,
				deliveryStatusOptions: [{
						label: '待配送',
						value: 1,
						class: 'status-pending'
					},
					{
						label: '配送中',
						value: 2,
						class: 'status-delivering'
					},
					{
						label: '已送达',
						value: 3,
						class: 'status-completed'
					},
					{
						label: '已取消',
						value: 4,
						class: 'status-expired'
					},
					{
						label: '全部',
						value: -1
					}
				],
				deliveryOrderList: [],
				pageNo: 1,
				pageSize: 10,
				loadMoreStatus: 'more', // more/loading/noMore
				isRefreshing: false,
				isAllLoaded: false,
			}
		},
		computed: {
			filteredDeliveryOrderList() {
				return this.deliveryOrderList.filter(orderItem => {
					const statusMatch = this.currentDeliveryStatus === -1 || orderItem.deliveryStatus === this
						.currentDeliveryStatus;
					return statusMatch;
				});
			}
		},
		methods: {
			changeDeliveryStatus(deliveryStatus) {
				this.currentDeliveryStatus = deliveryStatus;
				this.refreshDeliveryOrderList();
			},
			convertDeliveryStatusClass(status) {
				const item = this.deliveryStatusOptions.find(item => item.value === status)
				if (item) {
					return item.class
				}
			},
			convertDeliveryStatusText(status) {
				const item = this.deliveryStatusOptions.find(item => item.value === status)
				if (item) {
					return item.label
				}
			},
			navigateToDeliveryOrderDetail(orderItem) {
				uni.navigateTo({
					url: `/pages/order/order-detail?id=${orderItem.id}`
				})
			},

			async refreshDeliveryOrderList() {
				this.pageNo = 1;
				this.isAllLoaded = false;
				await this.fetchhDeliveryOrderList(true);
			},

			async onPullDownRefresh() {
				this.isRefreshing = true;
				await this.refreshDeliveryOrderList();
				this.isRefreshing = false;
				uni.stopPullDownRefresh();
			},
			async loadMoreOrders() {
				if (this.loadMoreStatus === 'loading' || this.isAllLoaded) return;
				this.loadMoreStatus = 'loading';
				await this.fetchhDeliveryOrderList();
			},

			async fetchhDeliveryOrderList(isRefresh = false) {
				try {
					const params = {
						pageNo: this.pageNo,
						pageSize: this.pageSize,
						deliveryStatus: this.currentDeliveryStatus != -1 ? this.currentDeliveryStatus : null,
					};
					const data = await orderApi.getCourierOrderPage(params);
					const newOrderData = (data && data.list) || [];
					if (isRefresh) {
						this.deliveryOrderList = newOrderData;
					} else {
						this.deliveryOrderList = this.deliveryOrderList.concat(newOrderData);
					}
					if (newOrderData.length < this.pageSize) {
						this.loadMoreStatus = 'noMore';
						this.isAllLoaded = true;
					} else {
						this.pageNo++;
						this.loadMoreStatus = 'more';
					}
				} catch (e) {
					this.loadMoreStatus = 'noMore';
					this.isAllLoaded = true;
				}
			},

			openLocationMap(orderItem) {
				uni.openLocation({
					latitude: 30.472641,
					longitude: 114.423926,
					name: orderItem.receiverDetailArea,
					address: orderItem.receiverDetailAddress,
					scale: 18
				});
			},

			makePhoneCall(phoneNumber) {
				if (!phoneNumber) {
					uni.showToast({
						title: '无效的电话号码',
						icon: 'none'
					});
					return;
				}
				uni.makePhoneCall({
					phoneNumber: phoneNumber
				});
			}
		},
		onShow() {
			this.refreshDeliveryOrderList();
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

	.receiver-mobile {
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