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
	@import '@/uni.scss';

	/* #ifndef APP-NVUE */
	@import '@/static/customicons.css';

	// 设置整个项目的背景色 - 使用泉水蓝色主题
	page {
		background-color: $bg-page;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', 'Helvetica Neue', Helvetica, Arial, sans-serif;
	}

	/* #endif */

	// 全局通用样式
	.example-info {
		font-size: $font-size-md;
		color: $text-primary;
		padding: $spacing-sm;
	}

	// 全局按钮样式
	.btn-primary {
		background: $gradient-primary;
		color: $bg-primary;
		border: none;
		border-radius: $radius-large;
		box-shadow: $shadow-medium;
		transition: all 0.3s ease;

		&:active {
			transform: translateY(2rpx);
			box-shadow: $shadow-light;
		}
	}

	// 全局卡片样式
	.card {
		background: $bg-primary;
		border-radius: $radius-medium;
		box-shadow: $shadow-light;
		padding: $spacing-md;
		margin-bottom: $spacing-md;
	}

	// 全局文本样式
	.text-primary {
		color: $text-primary;
	}

	.text-secondary {
		color: $text-secondary;
	}

	.text-tertiary {
		color: $text-tertiary;
	}
</style>