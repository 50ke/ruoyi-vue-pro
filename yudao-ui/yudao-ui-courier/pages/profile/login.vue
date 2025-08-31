<template>
  <view class="login-container">
    <view class="header-decoration"></view>
    <view class="form-box">
		<view class="btn-group">
		  <button class="submit-btn" open-type="getPhoneNumber" @getphonenumber="handleSubmit">微信一键登录</button>
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
      
    </view>
  </view>
</template>

<script>
import { weixinLogin } from '@/api/login.js';
export default {
  data() {
    return {
      loginType: 'sms', // 'sms' or 'pwd'
      counting: false,
      counter: 60,
      form: {
        phone: '',
        code: '',
        username: '',
        password: '',
        agreePrivacy: false
      }
    }
  },
  methods: {
    handlePrivacyChange(e) {
      this.form.agreePrivacy = e.detail.value.length > 0
    },
    showPrivacyPolicy() {
      uni.showModal({ title: '隐私政策', content: '这里是隐私政策内容...', showCancel: false })
    },
	//获取手机号
	getPhoneNumber(e){	
		console.log(e);
	},
    async handleSubmit(e) {
		if(e.detail.code == null){
			uni.showToast({ title: '请允许授权手机号', icon: 'none' }); return;
		}
		if (!this.form.agreePrivacy) {
		  uni.showToast({ title: '请同意隐私政策', icon: 'none' }); return;
		}
		uni.login({
			provider: 'weixin', //使用微信登录
			success: function (loginRes) {
				const res = weixinLogin({ loginCode: loginRes.code, phoneCode: e.detail.code, state: '123' });
				if (res.code === 0) {
					uni.setStorageSync('token', res.data.accessToken);
					uni.setStorageSync('refreshToken', res.data.refreshToken);
					uni.showToast({ title: '登录成功', icon: 'success' });
					setTimeout(() => { uni.switchTab({ url: '/pages/index/index' }); }, 500);
				}
			},
			fail:function(err){
				uni.showToast({ title: '登录失败', icon: 'none' }); return;
			}
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
  .tab-group {
    display: flex;
    justify-content: center;
    margin-bottom: 40rpx;
    text {
      font-size: 32rpx;
      margin: 0 30rpx;
      color: #888;
      padding-bottom: 8rpx;
      border-bottom: 4rpx solid transparent;
      transition: all 0.2s;
      &.active {
        color: $primary-blue;
        border-bottom: 4rpx solid $primary-blue;
        font-weight: 600;
      }
    }
  }
}
.input-group .input-box {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.98);
  border-radius: 16rpx;
  margin-bottom: 32rpx;
  padding: 24rpx 40rpx;
  box-shadow: 0 2rpx 8rpx rgba(114, 130, 183, 0.06);
  border: 1px solid #e6eaf0;
  input {
    flex: 1;
    font-size: 32rpx;
    background: transparent;
    border: none;
    outline: none;
    color: $text-primary;
  }
  .code-btn {
    margin-left: 20rpx;
    color: $primary-blue;
    font-size: 28rpx;
    font-weight: 500;
    &.disabled {
      color: #ccc;
    }
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
  }
  .action-links {
    display: flex;
    justify-content: flex-end;
    .forget-pwd {
      color: $primary-blue;
      font-size: 26rpx;
      text-decoration: underline;
      margin-left: 20rpx;
      font-weight: 500;
    }
  }
}
</style>