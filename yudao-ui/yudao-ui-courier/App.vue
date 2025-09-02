<script>
import store from '@/utils/store.js';
import { isLoggedIn, getUserInfo } from '@/utils/auth.js';

export default {
	onLaunch: function() {
		console.log('App Launch');
		
		// 初始化认证状态
		this.initAuth();
		
		// 检查登录状态
		this.checkAuthStatus();
	},
	
	onShow: function() {
		console.log('App Show');
		
		// 每次显示时检查认证状态
		this.checkAuthStatus();
	},
	
	onHide: function() {
		console.log('App Hide');
	},
	
	methods: {
		// 初始化认证状态
		initAuth() {
			try {
				const authenticated = isLoggedIn();
				const userInfo = getUserInfo();
				
				store.setAuthStatus(authenticated);
				if (userInfo) {
					store.setUserInfo(userInfo);
				}
				
				console.log('认证状态初始化完成:', {
					authenticated,
					hasUserInfo: !!userInfo
				});
			} catch (error) {
				console.error('认证状态初始化失败:', error);
			}
		},
		
		// 检查认证状态
		checkAuthStatus() {
			try {
				const authenticated = isLoggedIn();
				const userInfo = getUserInfo();
				
				// 更新全局状态
				store.setAuthStatus(authenticated);
				if (userInfo) {
					store.setUserInfo(userInfo);
				}
				
				// 如果未认证且不在登录页，跳转到登录页
				if (!authenticated) {
					const pages = getCurrentPages();
					const currentPage = pages[pages.length - 1];
					
					if (currentPage && currentPage.route !== 'pages/profile/login') {
						console.log('用户未认证，跳转到登录页');
						uni.reLaunch({ url: '/pages/profile/login' });
					}
				}
			} catch (error) {
				console.error('认证状态检查失败:', error);
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