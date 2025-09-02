<template>
  <view class="login-container">
    <view class="header-decoration"></view>
    <view class="form-box">
      <view class="title">配送员登录</view>
      
      <view class="btn-group">
        <button 
          class="submit-btn" 
          open-type="getPhoneNumber" 
          @getphonenumber="handleSubmit"
          :disabled="loading"
          :loading="loading"
        >
          {{ loading ? '登录中...' : '微信一键登录' }}
        </button>
      </view>
      
      <view class="input-group">
        <view class="privacy-box">
          <checkbox-group @change="handlePrivacyChange">
            <checkbox :checked="form.agreePrivacy" style="transform:scale(0.7)" />
          </checkbox-group>
          <text class="privacy-text">我已阅读并同意</text>
          <text class="privacy-link" @click="showPrivacyPolicy">《隐私政策》</text>
        </view>
      </view>
      
      <!-- 错误提示 -->
      <view v-if="errorMsg" class="error-tip">
        {{ errorMsg }}
      </view>
    </view>
  </view>
</template>

<script>
import { weixinLogin } from '@/api/login.js';
import { setToken, setUserInfo } from '@/utils/auth.js';

export default {
  data() {
    return {
      loading: false,
      errorMsg: '',
      form: {
        agreePrivacy: false
      }
    }
  },
  
  onLoad(options) {
    // 检查是否有重定向参数
    if (options.redirect) {
      this.redirectUrl = decodeURIComponent(options.redirect);
    }
  },
  
  methods: {
    handlePrivacyChange(e) {
      this.form.agreePrivacy = e.detail.value.length > 0;
      this.clearError();
    },
    
    showPrivacyPolicy() {
      uni.showModal({ 
        title: '隐私政策', 
        content: '我们承诺保护您的个人信息安全，不会向第三方泄露您的隐私信息。', 
        showCancel: false 
      });
    },
    
    clearError() {
      this.errorMsg = '';
    },
    
    async handleSubmit(e) {
      // 清除之前的错误信息
      this.clearError();
      
      // 验证授权
      if (e.detail.code == null) {
        this.errorMsg = '请允许授权手机号';
        return;
      }
      
      // 验证隐私政策
      if (!this.form.agreePrivacy) {
        this.errorMsg = '请同意隐私政策';
        return;
      }
      
      this.loading = true;
      
      try {
        // 获取微信登录code
        const loginResult = await this.getWeixinLoginCode();
        
        // 调用后端登录接口
        const loginResponse = await weixinLogin({ 
          loginCode: loginResult.code, 
          phoneCode: e.detail.code, 
          state: 'courier-login' 
        });
        
        if (loginResponse.code === 0 && loginResponse.data) {
          const { accessToken, refreshToken, expiresTime, user } = loginResponse.data;
          
          // 保存token和用户信息
          setToken(accessToken, refreshToken, expiresTime);
          if (user) {
            setUserInfo(user);
          }
          
          uni.showToast({ title: '登录成功', icon: 'success' });
          
          // 延迟跳转，让用户看到成功提示
          setTimeout(() => {
            if (this.redirectUrl) {
              // 跳转到重定向页面
              uni.redirectTo({ url: this.redirectUrl });
            } else {
              // 跳转到首页
              uni.switchTab({ url: '/pages/index/index' });
            }
          }, 1000);
          
        } else {
          this.errorMsg = loginResponse.msg || '登录失败，请重试';
        }
        
      } catch (error) {
        console.error('Login error:', error);
        this.errorMsg = '登录失败，请检查网络连接后重试';
      } finally {
        this.loading = false;
      }
    },
    
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
    }
  }
}
</script>

<style lang="scss" scoped>
.login-container {
  min-height: 100vh;
  background: #f5f6fa;
  position: relative;
  padding: 0 40rpx;
  display: flex;
  flex-direction: column;
}

.header-decoration {
  height: 420rpx;
  background: linear-gradient(135deg, #6B8DE3, #7C5CBF);
  margin: 0 -40rpx;
  position: relative;
  &::after {
    content: '';
    position: absolute;
    bottom: -60rpx;
    left: 0;
    right: 0;
    height: 120rpx;
    background: #f5f6fa;
    border-radius: 50% 50% 0 0;
    transform: scaleX(1.5);
  }
}

.form-box {
  margin-top: -180rpx;
  background: $bg-primary;
  border-radius: 30rpx;
  padding: 60rpx 60rpx;
  box-shadow: $shadow-medium;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.9);
  
  .title {
    font-size: 40rpx;
    font-weight: 600;
    text-align: center;
    margin-bottom: 80rpx;
    color: $text-primary;
    letter-spacing: 2rpx;
  }
}

.privacy-box {
  display: flex;
  align-items: center;
  margin-bottom: 30rpx;
  
  .privacy-text {
    font-size: 24rpx;
    color: #888;
    margin-left: 10rpx;
  }
  
  .privacy-link {
    font-size: 24rpx;
    color: $primary-blue;
    margin-left: 5rpx;
    text-decoration: underline;
  }
}

.btn-group {
  .submit-btn {
    width: 100%;
    height: 80rpx;
    border-radius: 35rpx;
    font-size: 30rpx;
    font-weight: 600;
    background: linear-gradient(90deg, #6B8DE3, #7C5CBF);
    color: #fff;
    margin-bottom: 20rpx;
    box-shadow: 0 4rpx 16rpx rgba(107, 141, 227, 0.12);
    letter-spacing: 2rpx;
    
    &:disabled {
      opacity: 0.6;
      background: #ccc;
    }
  }
}

.error-tip {
  background: #fff2f0;
  border: 1px solid #ffccc7;
  border-radius: 8rpx;
  padding: 20rpx;
  margin-top: 20rpx;
  color: #ff4d4f;
  font-size: 26rpx;
  text-align: center;
}
</style>