<template>
	<view class="delivery-home-page">
		<!-- 筛选区域 -->
		<view class="status-filter-section">
			<!-- 订单状态切换 -->
			<view v-for="(statusItem, index) in orderStatusOptions" :key="index" class="status-filter-item"
				:class="{ active: currentOrderStatus === statusItem.value }"
				@click="changeOrderStatus(statusItem.value)">
				{{statusItem.label}}
			</view>
			<!-- 更多筛选条件 -->
			<view class="status-filter-item" @click="showFilterPanel = true">
				<text>筛选</text>
			</view>
		</view>

		<!-- 订单列表区域 -->
		<scroll-view scroll-y style="height: 90vh" @scrolltolower="loadMoreOrders" refresher-enabled
			:refresher-triggered="isRefreshing" @refresherrefresh="onPullDownRefresh">
			<view class="order-list-container">
				<view class="order-item-card" v-for="(orderItem, index) in filteredOrderList" :key="index"
					@click="navigateToOrderDetail(orderItem)">
					<view class="order-header">
						<view class="order-number">订单号：{{ orderItem.no }}</view>
						<view class="order-status" :class="convertOrderStatusClass(orderItem.status)">
							{{ convertOrderStatusText(orderItem.status) }}
						</view>
					</view>

					<view class="order-content">
						<view class="order-info">
							<view class="delivery-address">配送地址：{{ orderItem.receiverDetailAddress }}</view>
							<view class="receiver-mobile">联系电话：{{ orderItem.receiverMobile }}</view>
							<view class="create-time">
								<text>下单时间：</text>
								<uni-dateformat :date="orderItem.payTime" format="yyyy-MM-dd hh:mm:ss" />
							</view>
							<view class="pay-time">
								<text>支付时间：</text>
								<uni-dateformat :date="orderItem.payTime" format="yyyy-MM-dd hh:mm:ss" />
							</view>
							<view class="action-buttons">
								<view class="action-button phone-button" @click.stop="updateRemark()">
									<uni-icons type="compose" size="18" color="#2979ff" />
								</view>
								<view class="action-button phone-button" @click.stop="delivery()">
									<uni-icons type="upload-filled" size="18" color="#2979ff" />
								</view>
								<view class="action-button phone-button" @click.stop="verifyCode()">
									<uni-icons type="scan" size="18" color="#2979ff" />
								</view>
								<view class="action-button phone-button" @click.stop="makePhoneCall()">
									<uni-icons type="phone-filled" size="18" color="#2979ff" />
								</view>
							</view>
						</view>
					</view>
				</view>
			</view>
			<uni-load-more :status="loadMoreStatus" />
		</scroll-view>

		<!-- 筛选面板 -->
		<view class="picker-mask" v-if="showFilterPanel" @click="showFilterPanel = false">
			<view class="picker-content" @click.stop>
				<view class="picker-header">
					<text>筛选</text>
					<text class="close-btn" @click="showFilterPanel = false">×</text>
				</view>
				<view class="filter-list">
					<view class="filter-section">
						<text class="section-title">门店</text>
						<uni-data-select class="filter-option" v-model="pickUpStoreIds" multiple wrap
							:localdata="stores" />
					</view>
					<view class="filter-section">
						<text class="section-title">订单号</text>
						<uni-easyinput class="filter-option" v-model="no" placeholder="请输入内容"></uni-easyinput>
					</view>
					<view class="filter-section">
						<text class="section-title">手机号</text>
						<uni-easyinput class="filter-option" v-model="userMobile" placeholder="请输入内容"></uni-easyinput>
					</view>
					<view class="filter-section">
						<text class="section-title">核销码</text>
						<uni-easyinput class="filter-option" v-model="pickUpVerifyCode"
							placeholder="请输入内容"></uni-easyinput>
					</view>
					<view class="filter-section">
						<text class="section-title">下单时间</text>
						<uni-datetime-picker class="filter-option" v-model="createTime" type="datetimerange"
							rangeSeparator="至" />
					</view>
				</view>
				<view class="filter-actions">
					<button class="action-btn reset-btn" @click="resetFilter">重置</button>
					<button class="action-btn confirm-btn" @click="completeFilter">确定</button>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		tradeApi
	} from '@/api/trade'
	import {
		userApi
	} from '@/api/user'
	export default {
		data() {
			return {
				currentOrderStatus: -1,
				no: null,
				userMobile: null,
				pickUpStoreIds: null,
				pickUpVerifyCode: null,
				createTime: null,
				orderStatusOptions: [{
						label: '全部',
						value: -1,
					},
					{
						label: '待支付',
						value: 0,
						class: 'status-unpaid'
					},
					{
						label: '待发货',
						value: 10,
						class: 'status-undelivered'
					},
					{
						label: '已发货',
						value: 20,
						class: 'status-delivered'
					},
					{
						label: '已完成',
						value: 30,
						class: 'status-completed'
					},
					{
						label: '已取消',
						value: 40,
						class: 'status-canceled'
					},
				],
				stores: [],
				orderList: [],
				pageNo: 1,
				pageSize: 10,
				loadMoreStatus: 'more', // more/loading/noMore
				isRefreshing: false,
				isAllLoaded: false,
				showFilterPanel: false, // 是否显示筛选面板
			}
		},
		onLoad() {
			this.refreshOrderList()
			this.loadStores()
		},
		computed: {
			filteredOrderList() {
				return this.orderList.filter(orderItem => {
					const statusMatch = this.currentOrderStatus === -1 || this.currentOrderStatus === orderItem
						.status;
					return statusMatch;
				});
			}
		},
		methods: {
			changeOrderStatus(status) {
				this.currentOrderStatus = status;
				this.refreshOrderList();
			},
			convertOrderStatusClass(status) {
				const item = this.orderStatusOptions.find(item => item.value === status)
				if (item) {
					return item.class
				}
			},
			convertOrderStatusText(status) {
				const item = this.orderStatusOptions.find(item => item.value === status)
				if (item) {
					return item.label
				}
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
			},
			navigateToOrderDetail(orderItem) {
				uni.navigateTo({
					url: `/pages/order/order-detail?id=${orderItem.id}`
				})
			},
			// 加载门店数据
			async loadStores() {
				try {
					const data = await userApi.getStores()
					this.stores = data.map(item => ({
						value: item.id,
						text: item.name
					}))
				} catch (error) {
					console.error('获取门店失败:', error)
				}
			},
			async refreshOrderList() {
				this.pageNo = 1;
				this.isAllLoaded = false;
				await this.fetchOrderList(true);
			},
			async onPullDownRefresh() {
				this.isRefreshing = true;
				await this.refreshOrderList();
				this.isRefreshing = false;
				uni.stopPullDownRefresh();
			},
			async loadMoreOrders() {
				if (this.loadMoreStatus === 'loading' || this.isAllLoaded) return;
				this.loadMoreStatus = 'loading';
				await this.fetchOrderList();
			},
			// 清除筛选条件
			resetFilter() {
				this.no = null
				this.userMobile = null
				this.pickUpStoreIds = null
				this.pickUpVerifyCode = null
				this.createTime = null
			},
			// 完成筛选
			completeFilter() {
				this.showFilterPanel = false
				// 重新加载商品列表
				this.refreshOrderList();
			},
			async fetchOrderList(isRefresh = false) {
				try {
					const params = {
						pageNo: this.pageNo,
						pageSize: this.pageSize,
						no: this.no,
						userMobile: this.userMobile,
						pickUpStoreIds: this.pickUpStoreIds != null ? this.pickUpStoreIds.join(',') : null,
						pickUpVerifyCode: this.pickUpVerifyCode,
						createTime: this.createTime != null ? this.createTime.join(',') : null,
						status: this.currentOrderStatus != -1 ? this.currentOrderStatus : null,
					};
					console.log(params)
					const data = await tradeApi.getTradeOrderPage(params);
					const newOrderData = (data && data.list) || [];
					if (isRefresh) {
						this.orderList = newOrderData;
					} else {
						this.orderList = this.orderList.concat(newOrderData);
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
			}
		}
	}
</script>

<style lang="scss" scoped>
	.delivery-home-page {
		min-height: 100vh;
		background: #f8f9fa;
		padding: 24rpx 0;
	}

	.search-section {
		padding: 24rpx;
		background: #ffffff;
		border-radius: 16rpx;
		margin-bottom: 24rpx;
		box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.06);
	}

	.search-container {
		display: flex;
		align-items: center;
		background: #fafafa;
		border-radius: 32rpx;
		padding: 16rpx 24rpx;
		border: 1rpx solid #f0f0f0;
	}

	.search-input {
		flex: 1;
		margin-left: 16rpx;
		font-size: 28rpx;
		color: #262626;
	}

	.status-filter-section {
		display: flex;
		background: #ffffff;
		padding: 24rpx;
		border-radius: 16rpx;
		margin-bottom: 24rpx;
		box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.06);
	}

	.status-filter-item {
		flex: 1;
		text-align: center;
		font-size: 28rpx;
		color: #595959;
		position: relative;
		padding: 16rpx 0;
		transition: all 0.3s ease;

		&.active {
			color: #2979ff;
			font-weight: 600;

			&::after {
				content: '';
				position: absolute;
				bottom: 0;
				left: 50%;
				transform: translateX(-50%);
				width: 40rpx;
				height: 4rpx;
				background: #2979ff;
				border-radius: 2rpx;
			}
		}
	}

	.order-list-container {
		padding: 16rpx;
	}

	.order-item-card {
		background: #ffffff;
		margin-bottom: 24rpx;
		border-radius: 16rpx;
		padding: 24rpx;
		box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.06);
		transition: all 0.3s ease;

		&:active {
			transform: translateY(2rpx);
			box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.08);
		}
	}

	.order-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 24rpx;
		padding-bottom: 16rpx;
		border-bottom: 1rpx solid #f5f5f5;
	}

	.order-number {
		font-size: 28rpx;
		color: #262626;
		font-weight: 500;
	}

	.order-status {
		font-size: 24rpx;
		padding: 4rpx 12rpx;
		border-radius: 8rpx;
		font-weight: 500;

		&.status-unpaid {
			background: rgba(#ff4d4f, 0.1);
			color: #ff4d4f;
		}

		&.status-undelivered {
			background: rgba(#2979ff, 0.1);
			color: #2979ff;
		}

		&.status-delivered {
			background: rgba(#fa8c16, 0.1);
			color: #fa8c16;
		}

		&.status-completed {
			background: rgba(#52c41a, 0.1);
			color: #52c41a;
		}

		&.status-canceled {
			background: rgba(#bfbfbf, 0.1);
			color: #bfbfbf;
		}
	}

	.order-content {
		display: flex;
		align-items: flex-start;
	}

	.product-image {
		width: 120rpx;
		height: 120rpx;
		border-radius: 8rpx;
		margin-right: 24rpx;
		background: #fafafa;
	}

	.order-info {
		flex: 1;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		min-height: 120rpx;
	}

	.delivery-address {
		font-size: 28rpx;
		color: #262626;
		margin-bottom: 8rpx;
		line-height: 1.4;
	}

	.receiver-mobile {
		font-size: 24rpx;
		color: #595959;
		margin-bottom: 16rpx;
	}

	.pay-time {
		font-size: 24rpx;
		color: #595959;
		margin-bottom: 16rpx;
	}

	.create-time {
		font-size: 24rpx;
		color: #595959;
		margin-bottom: 16rpx;
	}

	.action-buttons {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		gap: 16rpx;
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
			background: rgba(#2979ff, 0.1);

			&:active {
				background: rgba(#2979ff, 0.2);
				transform: scale(0.95);
			}
		}

		&.map-button {
			background: rgba(#52c41a, 0.1);

			&:active {
				background: rgba(#52c41a, 0.2);
				transform: scale(0.95);
			}
		}
	}

	.picker-mask {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(0, 0, 0, 0.5);
		z-index: 1000;
		display: flex;
		align-items: flex-end;

		.picker-content {
			width: 100%;
			background: white;
			border-radius: 24rpx 24rpx 0 0;
			max-height: 80vh;
			display: flex;
			flex-direction: column;

			.picker-header {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 24rpx;
				border-bottom: 1rpx solid #eee;
				font-size: 32rpx;
				font-weight: 500;

				.close-btn {
					font-size: 48rpx;
					color: #999;
				}
			}

			.store-list,
			.filter-list {
				flex: 1;
				overflow-y: auto;
				max-height: 400rpx;
				/* 限制高度为3个门店项的高度 */

				.store-option {
					padding: 32rpx;
					border-bottom: 1rpx solid #f5f5f5;
					font-size: 28rpx;

					&.selected {
						background: #f0f7ff;
						color: #2979ff;
					}
				}

				.filter-section {
					padding: 12rpx;

					.section-title {
						font-size: 24rpx;
						font-weight: 500;
						margin-bottom: 12rpx;
						display: block;
					}

					.filter-options {
						display: flex;
						flex-wrap: wrap;

						.filter-option {
							display: inline-block;
							margin: 0 16rpx 16rpx 0;
							padding: 12rpx 24rpx;
							border: 1rpx solid #eee;
							border-radius: 6rpx;
							background: white;
							border-bottom: none;

							&.selected {
								background: #2979ff;
								color: white;
								border-color: #2979ff;
							}
						}
					}
				}
			}

			.filter-actions {
				display: flex;
				padding: 24rpx;
				border-top: 1rpx solid #f5f5f5;

				.action-btn {
					flex: 1;
					padding: 20rpx;
					margin: 0 12rpx;
					border-radius: 6rpx;
					font-size: 28rpx;
					border: none;

					&.reset-btn {
						background: #f5f5f5;
						color: #666;
					}

					&.confirm-btn {
						background: #2979ff;
						color: white;
					}
				}
			}
		}
	}
</style>