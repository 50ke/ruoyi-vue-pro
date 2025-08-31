<template>
	<view class="container">
		<!-- 顶部背景 -->
		<view class="header-bg">
			<view class="logo-section">
				<image class="logo" src="/static/logo.png" mode="aspectFit"></image>
				<text class="app-name">配送员小程序</text>
				<text class="app-desc">专业配送服务，让生活更便捷</text>
			</view>
		</view>

		<!-- 登录表单 -->
		<view class="login-form">
			<view class="form-title">
				<text class="title-text">微信一键登录</text>
				<text class="title-desc">使用微信账号快速登录配送员系统</text>
			</view>

			<view class="form-content">
				<view class="agreement-section">
					<checkbox-group @change="onAgreementChange">
						<label class="agreement-item">
							<checkbox value="agree" :checked="agreed" color="#3cc51f" />
							<text class="agreement-text">
								我已阅读并同意
								<text class="link-text" @click="showAgreement">《用户协议》</text>
								和
								<text class="link-text" @click="showPrivacy">《隐私政策》</text>
							</text>
						</label>
					</checkbox-group>
				</view>

				<button 
					class="login-btn" 
					:class="{ disabled: !agreed }"
					:disabled="!agreed"
					@click="handleLogin"
				>
					<image class="wechat-icon" src="/static/wechat.png" mode="aspectFit"></image>
					<text class="btn-text">微信一键登录</text>
				</button>

				<view class="other-options">
					<text class="option-text">其他登录方式</text>
					<view class="option-buttons">
						<button class="option-btn" @click="phoneLogin">
							<text class="option-icon">📱</text>
							<text class="option-label">手机号登录</text>
						</button>
					</view>
				</view>
			</view>
		</view>

		<!-- 底部信息 -->
		<view class="footer-info">
			<text class="footer-text">登录即表示同意相关服务条款</text>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			agreed: false,
			loading: false
		}
	},
	methods: {
		// 协议勾选变化
		onAgreementChange(e) {
			this.agreed = e.detail.value.includes('agree')
		},
		
		// 显示用户协议
		showAgreement() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		},
		
		// 显示隐私政策
		showPrivacy() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		},
		
		// 微信登录
		async handleLogin() {
			if (!this.agreed) {
				uni.showToast({
					title: '请先同意用户协议和隐私政策',
					icon: 'none'
				})
				return
			}
			
			if (this.loading) return
			
			this.loading = true
			
			try {
				// 1. 获取微信登录 code
				const loginResult = await this.wxLogin()
				
				// 2. 调用后端登录接口
				const loginData = await this.courierLogin(loginResult.code)
				
				// 3. 保存登录信息
				this.saveLoginInfo(loginData)
				
				// 4. 跳转到首页
				uni.showToast({
					title: '登录成功',
					icon: 'success'
				})
				
				setTimeout(() => {
					uni.switchTab({
						url: '/pages/index/index'
					})
				}, 1500)
				
			} catch (error) {
				console.error('登录失败:', error)
				uni.showToast({
					title: error.message || '登录失败',
					icon: 'none'
				})
			} finally {
				this.loading = false
			}
		},
		
		// 微信登录
		wxLogin() {
			return new Promise((resolve, reject) => {
				uni.login({
					provider: 'weixin',
					success: (res) => {
						if (res.code) {
							resolve(res)
						} else {
							reject(new Error('获取微信登录码失败'))
						}
					},
					fail: (err) => {
						reject(new Error('微信登录失败'))
					}
				})
			})
		},
		
		// 配送员登录
		async courierLogin(code) {
			// TODO: 调用后端登录接口
			// const response = await uni.request({
			//     url: '/courier/auth/login',
			//     method: 'POST',
			//     data: { code }
			// })
			
			// 模拟登录成功
			await new Promise(resolve => setTimeout(resolve, 1000))
			
			return {
				token: 'mock_token_' + Date.now(),
				courierInfo: {
					id: 1,
					nickname: '张三',
					avatar: '',
					mobile: '156****1300',
					status: 1,
					merchantId: 1,
					workStatus: 1
				}
			}
		},
		
		// 保存登录信息
		saveLoginInfo(loginData) {
			// 保存 token
			uni.setStorageSync('courier_token', loginData.token)
			
			// 保存用户信息
			uni.setStorageSync('courier_user_info', loginData.courierInfo)
			
			// 设置全局请求头
			// TODO: 设置请求拦截器，自动添加 token
		},
		
		// 手机号登录
		phoneLogin() {
			uni.showToast({
				title: '功能开发中',
				icon: 'none'
			})
		}
	}
}
</script>

<style>
.container {
	min-height: 100vh;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.header-bg {
	padding: 100rpx 40rpx 60rpx;
	text-align: center;
}

.logo-section {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.logo {
	width: 120rpx;
	height: 120rpx;
	margin-bottom: 30rpx;
}

.app-name {
	font-size: 48rpx;
	font-weight: bold;
	color: white;
	margin-bottom: 20rpx;
}

.app-desc {
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.8);
}

.login-form {
	background: white;
	border-radius: 40rpx 40rpx 0 0;
	padding: 60rpx 40rpx;
	flex: 1;
}

.form-title {
	text-align: center;
	margin-bottom: 60rpx;
}

.title-text {
	display: block;
	font-size: 36rpx;
	font-weight: bold;
	color: #333;
	margin-bottom: 20rpx;
}

.title-desc {
	font-size: 26rpx;
	color: #666;
}

.form-content {
	margin-bottom: 40rpx;
}

.agreement-section {
	margin-bottom: 40rpx;
}

.agreement-item {
	display: flex;
	align-items: flex-start;
}

.agreement-text {
	font-size: 24rpx;
	color: #666;
	line-height: 1.5;
	margin-left: 20rpx;
}

.link-text {
	color: #3cc51f;
}

.login-btn {
	width: 100%;
	height: 100rpx;
	background: #3cc51f;
	border: none;
	border-radius: 50rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 40rpx;
	transition: all 0.3s;
}

.login-btn.disabled {
	background: #ccc;
}

.wechat-icon {
	width: 40rpx;
	height: 40rpx;
	margin-right: 20rpx;
}

.btn-text {
	font-size: 32rpx;
	color: white;
	font-weight: bold;
}

.other-options {
	text-align: center;
}

.option-text {
	display: block;
	font-size: 24rpx;
	color: #999;
	margin-bottom: 30rpx;
}

.option-buttons {
	display: flex;
	justify-content: center;
}

.option-btn {
	background: none;
	border: 1rpx solid #ddd;
	border-radius: 20rpx;
	padding: 20rpx 30rpx;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.option-icon {
	font-size: 32rpx;
	margin-bottom: 10rpx;
}

.option-label {
	font-size: 24rpx;
	color: #666;
}

.footer-info {
	text-align: center;
	padding: 40rpx;
}

.footer-text {
	font-size: 24rpx;
	color: rgba(255, 255, 255, 0.6);
}
</style>
