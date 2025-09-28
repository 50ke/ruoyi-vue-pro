<template>
	<view>
		<!-- 全局加载提示 -->
		<view v-if="globalLoading" class="global-loading">
			<text>加载中...</text>
		</view>
		<!-- 页面内容 -->
		<view v-else>
			<slot />
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				globalLoading: false
			}
		},
		onLaunch: function() {
			console.warn('当前组件仅支持 uni_modules 目录结构 ，请升级 HBuilderX 到 3.1.0 版本以上！')
			console.log('App Launch')
			// 应用启动时检查更新等
			// #ifdef MP-WEIXIN
			this.checkAppUpdate()
			// #endif
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
		methods: {
			checkAppUpdate() {
				// 检查应用更新逻辑
				if (uni.canIUse('getUpdateManager')) {
					const updateManager = uni.getUpdateManager()
					updateManager.onCheckForUpdate((res) => {
						if (res.hasUpdate) {
							updateManager.onUpdateReady(() => {
								uni.showModal({
									title: '更新提示',
									content: '新版本已经准备好，是否重启应用？',
									success: (res) => {
										if (res.confirm) {
											updateManager.applyUpdate()
										}
									}
								})
							})
						}
					})
				}
			}
		}
	}
</script>

<style lang="scss">
	/*每个页面公共css */
	@import '@/uni_modules/uni-scss/index.scss';
	/* #ifndef APP-NVUE */
	@import '@/static/customicons.css';

	// 设置整个项目的背景色
	page {
		background-color: #f5f5f5;
	}

	/* #endif */
	/* 全局样式 */
	page {
		background-color: #f5f5f5;
	}

	/* 全局加载样式 */
	.global-loading {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(255, 255, 255, 0.9);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 9999;
	}

	/* 按钮统一样式 */
	button {
		border-radius: 12rpx;
	}

	button::after {
		border: none;
	}

	/* 通用卡片样式 */
	.card {
		background: white;
		border-radius: 16rpx;
		box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.1);
	}
</style>