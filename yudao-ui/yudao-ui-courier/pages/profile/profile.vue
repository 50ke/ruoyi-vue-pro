<template>
	<view class="profile-container">
		<!-- 用户信息卡片 -->
		<view class="user-card">
			<view class="avatar-section">
				<image :src="userInfo.avatar" class="avatar" mode="aspectFill" />
				<view class="user-info">
					<text class="nickname">{{ userInfo.nickname || '未登录' }}</text>
					<text class="mobile">{{ userInfo.mobile }}</text>
				</view>
			</view>

			<!-- 工作状态切换 -->
			<view class="work-status">
				<text class="status-label">工作状态</text>
				<switch :checked="userInfo.workStatus === 2" @change="updateWorkStatus" color="#6B8DE3" />
				<text class="status-text">{{ userInfo.workStatus === 1 ? '离线' : '在线' }}</text>
			</view>
		</view>

		<!-- 功能菜单 -->
		<view class="menu-list">
			<view class="menu-item" @click="goToOrders">
				<view class="menu-left">
					<text class="menu-icon">📦</text>
					<text class="menu-text">我的订单</text>
				</view>
				<text class="menu-arrow">></text>
			</view>

			<view class="menu-item" @click="goToSettings">
				<view class="menu-left">
					<text class="menu-icon">⚙️</text>
					<text class="menu-text">设置</text>
				</view>
				<text class="menu-arrow">></text>
			</view>

			<view class="menu-item" @click="goToHelp">
				<view class="menu-left">
					<text class="menu-icon">❓</text>
					<text class="menu-text">帮助中心</text>
				</view>
				<text class="menu-arrow">></text>
			</view>

			<view class="menu-item" @click="goToAbout">
				<view class="menu-left">
					<text class="menu-icon">ℹ️</text>
					<text class="menu-text">关于我们</text>
				</view>
				<text class="menu-arrow">></text>
			</view>
		</view>

		<!-- 退出登录按钮 -->
		<view class="logout-section">
			<button class="logout-btn" @click="handleLogout">退出登录</button>
		</view>
	</view>
</template>

<script>
	import {
		useAuthStore
	} from '@/store/auth'
	import {
		userApi
	} from '@/api/user'

	export default {
		data() {
			return {
				userInfo: {
					id: 0,
					avatar: '/static/logo.png',
					nickname: null,
					mobile: '',
					workStatus: 1
				}
			}
		},
		methods: {
			// 获取用户信息
			async loadUserInfo() {
				try {
					const data = await userApi.getUserInfo()
					if (data) {
						this.userInfo = {
							...this.userInfo,
							...data
						}
					}
				} catch (error) {
					console.error('获取用户信息失败:', error)
				}
			},

			// 切换工作状态
			async updateWorkStatus(e) {
				try {
					const newWorkStatus = e.detail.value ? 2 : 1;
					const param = {
						workStatus: newWorkStatus
					};
					const result = await userApi.updateUserInfo(param);
					if (result) {
						// 更新本地状态
						this.userInfo.workStatus = newWorkStatus;
						uni.showToast({
							title: newWorkStatus === 1 ? '已下线' : '已上线',
							icon: 'success'
						});
					} else {
						uni.showToast({
							title: '修改工作状态失败',
							icon: 'none'
						})
					}
				} catch (error) {
					console.error('修改工作状态失败:', error)
					uni.showToast({
						title: '修改工作状态失败',
						icon: 'none'
					})
				}
			},

			// 退出登录
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
		},
		onShow() {
			// 每次显示时刷新用户信息
			this.loadUserInfo();
		},
	}
</script>

<style lang="scss" scoped>
	.profile-container {
		min-height: 100vh;
		background: #f5f6fa;
		padding: 20rpx;
	}

	.user-card {
		background: $bg-primary;
		border-radius: 20rpx;
		padding: 40rpx;
		margin-bottom: 30rpx;
		box-shadow: $shadow-light;

		.avatar-section {
			display: flex;
			align-items: center;
			margin-bottom: 40rpx;

			.avatar {
				width: 120rpx;
				height: 120rpx;
				border-radius: 60rpx;
				margin-right: 30rpx;
				border: 4rpx solid #e6eaf0;
			}

			.user-info {
				flex: 1;

				.nickname {
					display: block;
					font-size: 36rpx;
					font-weight: 600;
					color: $text-primary;
					margin-bottom: 10rpx;
				}

				.mobile {
					font-size: 28rpx;
					color: $text-secondary;
				}
			}
		}

		.work-status {
			display: flex;
			align-items: center;
			justify-content: space-between;

			.status-label {
				font-size: 30rpx;
				color: $text-primary;
			}

			.status-text {
				font-size: 28rpx;
				color: $text-secondary;
				margin-left: 20rpx;
			}
		}
	}

	.menu-list {
		background: $bg-primary;
		border-radius: 20rpx;
		margin-bottom: 30rpx;
		box-shadow: $shadow-light;

		.menu-item {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 30rpx 40rpx;
			border-bottom: 1rpx solid #f0f0f0;

			&:last-child {
				border-bottom: none;
			}

			.menu-left {
				display: flex;
				align-items: center;

				.menu-icon {
					font-size: 40rpx;
					margin-right: 20rpx;
				}

				.menu-text {
					font-size: 30rpx;
					color: $text-primary;
				}
			}

			.menu-arrow {
				font-size: 30rpx;
				color: #ccc;
			}
		}
	}

	.logout-section {
		padding: 40rpx 0;

		.logout-btn {
			width: 100%;
			height: 80rpx;
			border-radius: 40rpx;
			background: #ff4d4f;
			color: #fff;
			font-size: 30rpx;
			border: none;

			&:active {
				opacity: 0.8;
			}
		}
	}
</style>