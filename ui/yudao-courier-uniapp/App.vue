<script>
	export default {
		onLaunch: function() {
			console.warn('当前组件仅支持 uni_modules 目录结构 ，请升级 HBuilderX 到 3.1.0 版本以上！')
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
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