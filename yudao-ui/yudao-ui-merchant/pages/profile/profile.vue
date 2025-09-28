<template>
	<view class="mine-page">
		<!-- 顶部用户信息卡片 -->
		<view class="user-card">
			<view class="user-header">
				<image class="avatar" :src="userInfo.avatar" mode="aspectFill" />
				<view class="user-info">
					<text class="nickname">{{ userInfo.nickname || '未登录' }}</text>
				</view>
			</view>
			<view class="stat-row">
				<view class="stat-item">
					<text class="value">{{ userInfo.wallet }}</text>
					<text class="label">钱包(元)</text>
				</view>
				<view class="stat-item">
					<text class="value">{{ userInfo.storeCount }}</text>
					<text class="label">门店</text>
				</view>
				<view class="stat-item">
					<text class="value">{{ userInfo.courierCount }}</text>
					<text class="label">配送员</text>
				</view>
			</view>
		</view>

		<!-- 快捷功能区 -->
		<view class="quick-actions">
			<view class="action-item" v-for="(item, index) in quickServices" :key="index"
				@click="navigateTo(item.path)">
				<view class="action-icon" :class="item.class">
					<uni-icons :type="item.icon" size="24" color="#fff"></uni-icons>
				</view>
				<text class="action-name">{{ item.name }}</text>
			</view>
		</view>

		<!-- 服务菜单列表 -->
		<view class="service-list">
			<view class="service-item" v-for="(item, index) in systemServices" :key="index"
				@click="navigateTo(item.path)">
				<view class="left">
					<view class="service-icon" :class="item.class">
						<uni-icons :type="item.icon" size="20" color="#fff"></uni-icons>
					</view>
					<text class="service-name">{{ item.name }}</text>
				</view>
				<view class="right">
					<text v-if="item.desc" class="desc">{{ item.desc }}</text>
					<uni-icons type="right" size="14" color="#999"></uni-icons>
				</view>
			</view>
		</view>
	</view>

	<!-- 退出登录按钮 -->
	<view class="logout-wrapper">
		<button class="logout-btn" type="warn" @click="handleLogout">退出登录</button>
	</view>
</template>

<script>
	import {
		useAuthStore
	} from '@/store/auth'
	export default {
		data() {
			return {
				userInfo: {
					avatar: '/static/logo.png',
					nickname: null,
					userId: 0,
					wallet: 888.88,
					storeCount: 2,
					courierCount: 3
				},
				quickServices: [{
						name: '门店管理',
						icon: 'shop',
						path: '/pages/profile/store',
						class: 'bg-red'
					},
					{
						name: '配送管理',
						icon: 'staff',
						path: '/pages/profile/courier',
						class: 'bg-blue'
					}
				],
				systemServices: [{
						name: '客服中心',
						icon: 'headphones',
						path: '/pages/profile/service',
						class: 'bg-orange',
						desc: '在线客服'
					},
					{
						name: '帮助中心',
						icon: 'help',
						path: '/pages/profile/help',
						class: 'bg-cyan'
					},
					{
						name: '意见反馈',
						icon: 'chat',
						path: '/pages/profile/feedback',
						class: 'bg-pink'
					},
					{
						name: '设置',
						icon: 'gear',
						path: '/pages/profile/settings',
						class: 'bg-gray'
					}
				]
			}
		},
		methods: {
			navigateTo(path) {
				uni.navigateTo({
					url: path
				})
			},
			async handleLogout() {
				try {
					const ok = await new Promise((resolve) => {
						uni.showModal({
							title: '提示',
							content: '确定要退出登录吗？',
							confirmText: '退出',
							cancelText: '取消',
							success: (res) => resolve(res.confirm)
						})
					})
					if (!ok) return
					const authStore = useAuthStore()
					await authStore.logout()
					uni.reLaunch({
						url: '/pages/login/login'
					})
				} catch (e) {
					uni.showToast({
						title: e.message || '退出失败',
						icon: 'none'
					})
				}
			}
		}
	}
</script>

<style lang="scss" scoped>
	.mine-page {
		min-height: 100vh;
		background: #f5f6fa;
		padding: 30rpx;
	}

	.user-card {
		background: #fff;
		border-radius: 24rpx;
		padding: 40rpx;
		margin-bottom: 30rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);

		.user-header {
			display: flex;
			align-items: center;
			margin-bottom: 40rpx;

			.avatar {
				width: 120rpx;
				height: 120rpx;
				border-radius: 60rpx;
				margin-right: 30rpx;
			}

			.user-info {
				flex: 1;

				.nickname {
					font-size: 36rpx;
					font-weight: 600;
					color: #333;
					margin-bottom: 12rpx;
					display: block;
				}

				.vip-tag {
					background: linear-gradient(90deg, #FFD700 0%, #FFA500 100%);
					color: #fff;
					font-size: 24rpx;
					padding: 4rpx 16rpx;
					border-radius: 20rpx;
					display: inline-block;
				}
			}

			.qr-code {
				width: 72rpx;
				height: 72rpx;
				border-radius: 36rpx;
				background: #f5f6fa;
				display: flex;
				align-items: center;
				justify-content: center;
			}
		}

		.stat-row {
			display: flex;
			padding-top: 30rpx;
			border-top: 2rpx solid #f5f6fa;

			.stat-item {
				flex: 1;
				text-align: center;

				.value {
					font-size: 40rpx;
					font-weight: 600;
					color: #333;
					margin-bottom: 8rpx;
					display: block;
				}

				.label {
					font-size: 24rpx;
					color: #999;
				}
			}
		}
	}

	.quick-actions {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 30rpx;
		margin-bottom: 30rpx;

		.action-item {
			background: #fff;
			border-radius: 24rpx;
			padding: 30rpx 20rpx;
			text-align: center;
			box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);

			.action-icon {
				width: 80rpx;
				height: 80rpx;
				border-radius: 40rpx;
				margin: 0 auto 16rpx;
				display: flex;
				align-items: center;
				justify-content: center;
			}

			.action-name {
				font-size: 26rpx;
				color: #666;
			}
		}
	}

	.service-list {
		background: #fff;
		border-radius: 24rpx;
		padding: 10rpx 30rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);

		.service-item {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 30rpx 0;
			border-bottom: 2rpx solid #f5f6fa;

			&:last-child {
				border-bottom: none;
			}

			.left {
				display: flex;
				align-items: center;

				.service-icon {
					width: 64rpx;
					height: 64rpx;
					border-radius: 32rpx;
					margin-right: 24rpx;
					display: flex;
					align-items: center;
					justify-content: center;
				}

				.service-name {
					font-size: 28rpx;
					color: #333;
				}
			}

			.right {
				display: flex;
				align-items: center;

				.desc {
					font-size: 24rpx;
					color: #999;
					margin-right: 16rpx;
				}
			}
		}
	}

	// 背景色
	.bg-red {
		background: #ff4d4f;
	}

	.bg-blue {
		background: #1890ff;
	}

	.bg-green {
		background: #52c41a;
	}

	.bg-purple {
		background: #722ed1;
	}

	.bg-orange {
		background: #fa8c16;
	}

	.bg-cyan {
		background: #13c2c2;
	}

	.bg-pink {
		background: #eb2f96;
	}

	.bg-gray {
		background: #666666;
	}
</style>