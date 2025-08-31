<template>
	<view class="container">
		<!-- 用户信息卡片 -->
		<view class="user-card">
			<view class="avatar-section">
				<image class="avatar" :src="userInfo.avatar || '/static/default-avatar.png'" mode="aspectFill" @click="chooseAvatar"></image>
				<text class="avatar-tip">点击更换头像</text>
			</view>
			<view class="user-details">
				<text class="nickname">{{ userInfo.nickname || '配送员' }}</text>
				<text class="mobile">{{ userInfo.mobile || '未绑定手机号' }}</text>
			</view>
		</view>

		<!-- 功能菜单 -->
		<view class="menu-list">
			<view class="menu-item" @click="editProfile">
				<view class="menu-left">
					<view class="menu-icon">👤</view>
					<text class="menu-text">编辑资料</text>
				</view>
				<text class="menu-arrow">></text>
			</view>
			
			<view class="menu-item" @click="toggleWorkStatus">
				<view class="menu-left">
					<view class="menu-icon">🔄</view>
					<text class="menu-text">工作状态</text>
				</view>
				<view class="menu-right">
					<text class="status-text" :class="userInfo.workStatus === 1 ? 'online' : 'offline'">
						{{ userInfo.workStatus === 1 ? '在线' : '离线' }}
					</text>
					<text class="menu-arrow">></text>
				</view>
			</view>
			
			<view class="menu-item" @click="goToSettings">
				<view class="menu-left">
					<view class="menu-icon">⚙️</view>
					<text class="menu-text">设置</text>
				</view>
				<text class="menu-arrow">></text>
			</view>
			
			<view class="menu-item" @click="goToHelp">
				<view class="menu-left">
					<view class="menu-icon">❓</view>
					<text class="menu-text">帮助中心</text>
				</view>
				<text class="menu-arrow">></text>
			</view>
			
			<view class="menu-item" @click="goToAbout">
				<view class="menu-left">
					<view class="menu-icon">ℹ️</view>
					<text class="menu-text">关于我们</text>
				</view>
				<text class="menu-arrow">></text>
			</view>
		</view>

		<!-- 退出登录 -->
		<view class="logout-section">
			<button class="logout-btn" @click="logout">退出登录</button>
		</view>

		<!-- 编辑资料弹窗 -->
		<uni-popup ref="editPopup" type="center">
			<view class="edit-popup">
				<view class="popup-header">
					<text class="popup-title">编辑资料</text>
					<text class="popup-close" @click="closeEditPopup">×</text>
				</view>
				<view class="popup-content">
					<view class="form-item">
						<text class="form-label">昵称</text>
						<input class="form-input" v-model="editForm.nickname" placeholder="请输入昵称" maxlength="50" />
					</view>
					<view class="form-item">
						<text class="form-label">手机号</text>
						<input class="form-input" v-model="editForm.mobile" placeholder="请输入手机号" maxlength="20" />
					</view>
				</view>
				<view class="popup-actions">
					<button class="popup-btn cancel" @click="closeEditPopup">取消</button>
					<button class="popup-btn confirm" @click="saveProfile">保存</button>
				</view>
			</view>
		</uni-popup>
	</view>
</template>

<script>
export default {
	data() {
		return {
			userInfo: {
				nickname: '张三',
				avatar: '',
				mobile: '156****1300',
				workStatus: 1
			},
			editForm: {
				nickname: '',
				mobile: ''
			}
		}
	},
	onLoad() {
		this.loadUserInfo()
	},
	methods: {
		// 加载用户信息
		loadUserInfo() {
			// TODO: 调用接口获取用户信息
		},
		
		// 选择头像
		chooseAvatar() {
			uni.chooseImage({
				count: 1,
				sizeType: ['compressed'],
				sourceType: ['album', 'camera'],
				success: (res) => {
					const tempFilePath = res.tempFilePaths[0]
					this.uploadAvatar(tempFilePath)
				}
			})
		},
		
		// 上传头像
		async uploadAvatar(filePath) {
			try {
				uni.showLoading({ title: '上传中...' })
				
				// TODO: 调用接口上传头像
				await new Promise(resolve => setTimeout(resolve, 2000))
				
				// 模拟上传成功
				this.userInfo.avatar = filePath
				
				uni.hideLoading()
				uni.showToast({
					title: '上传成功',
					icon: 'success'
				})
			} catch (error) {
				uni.hideLoading()
				uni.showToast({
					title: '上传失败',
					icon: 'none'
				})
			}
		},
		
		// 编辑资料
		editProfile() {
			this.editForm.nickname = this.userInfo.nickname
			this.editForm.mobile = this.userInfo.mobile
			this.$refs.editPopup.open()
		},
		
		// 关闭编辑弹窗
		closeEditPopup() {
			this.$refs.editPopup.close()
		},
		
		// 保存资料
		async saveProfile() {
			try {
				// 验证表单
				if (!this.editForm.nickname.trim()) {
					uni.showToast({
						title: '请输入昵称',
						icon: 'none'
					})
					return
				}
				
				if (this.editForm.mobile && !/^1[3-9]\d{9}$/.test(this.editForm.mobile)) {
					uni.showToast({
						title: '请输入正确的手机号',
						icon: 'none'
					})
					return
				}
				
				uni.showLoading({ title: '保存中...' })
				
				// TODO: 调用接口保存资料
				await new Promise(resolve => setTimeout(resolve, 1000))
				
				// 更新本地数据
				this.userInfo.nickname = this.editForm.nickname
				this.userInfo.mobile = this.editForm.mobile
				
				uni.hideLoading()
				uni.showToast({
					title: '保存成功',
					icon: 'success'
				})
				
				this.closeEditPopup()
			} catch (error) {
				uni.hideLoading()
				uni.showToast({
					title: '保存失败',
					icon: 'none'
				})
			}
		},
		
		// 切换工作状态
		toggleWorkStatus() {
			const newStatus = this.userInfo.workStatus === 1 ? 2 : 1
			const statusText = newStatus === 1 ? '在线' : '离线'
			
			uni.showModal({
				title: '切换状态',
				content: `确定要切换为${statusText}状态吗？`,
				success: async (res) => {
					if (res.confirm) {
						try {
							// TODO: 调用接口更新工作状态
							uni.showLoading({ title: '更新中...' })
							
							await new Promise(resolve => setTimeout(resolve, 1000))
							
							this.userInfo.workStatus = newStatus
							
							uni.hideLoading()
							uni.showToast({
								title: '状态更新成功',
								icon: 'success'
							})
						} catch (error) {
							uni.hideLoading()
							uni.showToast({
								title: '更新失败',
								icon: 'none'
							})
						}
					}
				}
			})
		},
		
		// 跳转到设置页面
		goToSettings() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		},
		
		// 跳转到帮助中心
		goToHelp() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		},
		
		// 跳转到关于我们
		goToAbout() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		},
		
		// 退出登录
		logout() {
			uni.showModal({
				title: '确认退出',
				content: '确定要退出登录吗？',
				success: (res) => {
					if (res.confirm) {
						// TODO: 调用接口退出登录
						uni.showToast({
							title: '已退出登录',
							icon: 'success'
						})
						
						// 跳转到登录页
						setTimeout(() => {
							uni.reLaunch({
								url: '/pages/login/login'
							})
						}, 1500)
					}
				}
			})
		}
	}
}
</script>

<style>
.container {
	background-color: #f5f5f5;
	min-height: 100vh;
	padding-bottom: 40rpx;
}

.user-card {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	margin: 20rpx;
	border-radius: 20rpx;
	padding: 40rpx;
	color: white;
	text-align: center;
}

.avatar-section {
	margin-bottom: 30rpx;
}

.avatar {
	width: 150rpx;
	height: 150rpx;
	border-radius: 75rpx;
	border: 6rpx solid rgba(255, 255, 255, 0.3);
	margin-bottom: 20rpx;
}

.avatar-tip {
	font-size: 24rpx;
	opacity: 0.8;
}

.user-details {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.nickname {
	font-size: 36rpx;
	font-weight: bold;
	margin-bottom: 10rpx;
}

.mobile {
	font-size: 26rpx;
	opacity: 0.9;
}

.menu-list {
	margin: 20rpx;
	background: white;
	border-radius: 20rpx;
	overflow: hidden;
}

.menu-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 30rpx;
	border-bottom: 1rpx solid #f0f0f0;
}

.menu-item:last-child {
	border-bottom: none;
}

.menu-left {
	display: flex;
	align-items: center;
}

.menu-icon {
	font-size: 40rpx;
	margin-right: 20rpx;
}

.menu-text {
	font-size: 28rpx;
	color: #333;
}

.menu-right {
	display: flex;
	align-items: center;
}

.status-text {
	font-size: 24rpx;
	margin-right: 20rpx;
	padding: 6rpx 16rpx;
	border-radius: 16rpx;
}

.status-text.online {
	background: #e8f5e8;
	color: #388e3c;
}

.status-text.offline {
	background: #ffebee;
	color: #d32f2f;
}

.menu-arrow {
	font-size: 24rpx;
	color: #ccc;
}

.logout-section {
	margin: 40rpx 20rpx;
}

.logout-btn {
	width: 100%;
	background: #ff4757;
	color: white;
	border: none;
	border-radius: 20rpx;
	padding: 30rpx;
	font-size: 28rpx;
}

.edit-popup {
	background: white;
	border-radius: 20rpx;
	width: 600rpx;
	overflow: hidden;
}

.popup-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 30rpx;
	border-bottom: 1rpx solid #f0f0f0;
}

.popup-title {
	font-size: 32rpx;
	font-weight: bold;
	color: #333;
}

.popup-close {
	font-size: 40rpx;
	color: #999;
	line-height: 1;
}

.popup-content {
	padding: 30rpx;
}

.form-item {
	margin-bottom: 30rpx;
}

.form-label {
	display: block;
	font-size: 28rpx;
	color: #333;
	margin-bottom: 20rpx;
}

.form-input {
	width: 100%;
	height: 80rpx;
	border: 1rpx solid #ddd;
	border-radius: 10rpx;
	padding: 0 20rpx;
	font-size: 28rpx;
	box-sizing: border-box;
}

.popup-actions {
	display: flex;
	border-top: 1rpx solid #f0f0f0;
}

.popup-btn {
	flex: 1;
	height: 100rpx;
	border: none;
	forder-radius: 0;
	font-size: 28rpx;
}

.popup-btn.cancel {
	background: #f5f5f5;
	color: #666;
}

.popup-btn.confirm {
	background: #3cc51f;
	color: white;
}
</style>
