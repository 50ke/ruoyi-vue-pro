<template>
	<view class="login-container">
		<view class="login-card">
			<view class="logo-section">
				<image class="app-logo" src="/static/logo.png" mode="aspectFit"></image>
				<text class="app-name">顺驿宝</text>
				<text class="app-slogan">取件顺带宝，生活更美好。</text>
			</view>

			<view class="login-form">
				<button class="login-btn wechat-btn" open-type="getPhoneNumber" @getphonenumber="handleWechatLogin" :loading="loading" :disabled="loading">
					<image class="btn-icon" src="/static/logo.png" mode="aspectFit"></image>
					<text class="btn-text">微信一键登录</text>
				</button>

				<view class="agreement">
					<label class="agree-row" @click="agreed = !agreed">
						<checkbox :checked="agreed" color="#07c160" />
						<text class="agree-text">我已阅读并同意</text>
						<text class="link" @click.stop="openAgreement('user-agreement')">《用户协议》</text>
						<text class="agree-text">和</text>
						<text class="link" @click.stop="openAgreement('privacy')">《隐私政策》</text>
					</label>
				</view>
			</view>

			<view class="footer safe-area-bottom">
				<text class="footer-text">版权所有 © 顺驿宝</text>
			</view>
		</view>
	</view>

</template>

<script>
	import {
		useAuthStore
	} from '@/store/auth'
	export default {
		name: 'LoginPage',
		data() {
			return {
				loading: false,
				agreed: true
			}
		},
		methods: {
			// 获取微信登录code
			getWeixinLoginCode() {
				return new Promise((resolve, reject) => {
					uni.login({
						provider: 'weixin',
						success: (loginRes) => {
							resolve(loginRes);
						},
						fail: (err) => {
							console.error('Weixin login failed:', err);
							reject(new Error('微信登录失败'));
						}
					});
				});
			},
			async handleWechatLogin(e) {
				if (this.loading || !this.agreed) return
				this.loading = true
				try {
					// 获取微信登录code
					const loginResult = await this.getWeixinLoginCode();
					const loginData = {
						loginCode: loginResult.code,
						phoneCode: e.detail.code,
						state: '9b2ffbc1-7425-4155-9894-9d5c08541d62'
					}
					const authStore = useAuthStore()
					await authStore.login(loginData)
					uni.showToast({
						title: '登录成功',
						icon: 'success'
					})
					setTimeout(() => {
						uni.switchTab({
							url: '/pages/index/index'
						})
					}, 800)
				} catch (error) {
					console.error('Weixin login failed:', error);
					uni.showToast({
						title: error.message || '登录失败',
						icon: 'none'
					})
				} finally {
					this.loading = false
				}
			},
			openAgreement(type) {
				const url = `/pages/profile/help?type=${type}`
				uni.navigateTo({
					url
				})
			}
		}
	}
</script>

<style scoped>
	.login-container {
		min-height: 100vh;
		background: #f7f8fa;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 40rpx;
	}

	.login-card {
		width: 100%;
		max-width: 640rpx;
		padding: 60rpx 40rpx;
		border-radius: 24rpx;
		background: #ffffff;
		box-shadow: 0 12rpx 32rpx rgba(0, 0, 0, 0.06);
		border: 2rpx solid #f0f0f0;
	}

	.logo-section {
		text-align: center;
		margin-bottom: 80rpx;
	}

	.app-logo {
		width: 120rpx;
		height: 120rpx;
		border-radius: 24rpx;
		margin-bottom: 30rpx;
	}

	.app-name {
		display: block;
		font-size: 48rpx;
		font-weight: bold;
		color: #222;
		margin-bottom: 16rpx;
	}

	.app-slogan {
		font-size: 28rpx;
		color: #666;
	}

	.login-form {
		margin-bottom: 40rpx;
	}

	.login-btn {
		width: 100%;
		height: 96rpx;
		border-radius: 48rpx;
		border: none;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 32rpx;
		font-weight: 500;
		transition: all 0.3s;
	}

	.wechat-btn {
		background: #07c160;
		color: white;
	}

	.wechat-btn:active {
		background: #06ae56;
		transform: scale(0.98);
	}

	.wechat-btn[disabled] {
		background: #cccccc;
		color: #666666;
	}

	.btn-icon {
		width: 40rpx;
		height: 40rpx;
		margin-right: 20rpx;
	}

	.btn-text {
		font-size: 32rpx;
	}

	.agreement {
		margin-top: 28rpx;
	}

	.agree-row {
		display: inline-flex;
		align-items: center;
		color: #666;
		font-size: 26rpx;
	}

	.agree-text {
		margin: 0 8rpx;
	}

	.link {
		color: #07c160;
	}

	.loading-section {
		text-align: center;
		margin-top: 40rpx;
	}

	.loading-text {
		font-size: 28rpx;
		color: #666;
	}

	.footer {
		text-align: center;
	}

	.footer-text {
		font-size: 24rpx;
		color: #999;
		line-height: 1.6;
	}

	.safe-area-bottom {
		padding-bottom: env(safe-area-inset-bottom);
	}
</style>