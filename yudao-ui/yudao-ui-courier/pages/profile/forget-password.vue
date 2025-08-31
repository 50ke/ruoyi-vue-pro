<template>
  <view class="forget-pwd-container">
    <view class="header-decoration"></view>
    <view class="form-box">
      <view class="title">重置密码</view>
      <view class="input-group">
        <view class="input-box">
          <input v-model="form.phone" maxlength="11" placeholder="请输入手机号" />
        </view>
        <view class="input-box code-box">
          <input v-model="form.code" maxlength="6" placeholder="请输入验证码" />
          <text class="code-btn" :class="{ disabled: counting }" @click="getVerifyCode">
            {{ counting ? `${counter}s后重试` : '获取验证码' }}
          </text>
        </view>
        <view class="input-box">
          <input v-model="form.password" type="password" placeholder="请输入新密码" />
        </view>
        <view class="input-box">
          <input v-model="form.confirmPassword" type="password" placeholder="请确认新密码" />
        </view>
      </view>
      <view class="btn-group">
        <button class="submit-btn" @click="handleSubmit">确认重置</button>
        <view class="back-btn" @click="goBack">返回登录</view>
      </view>
    </view>
  </view>
</template>

<script>
import { sendSmsCode, resetPassword } from '@/api/login.js';
export default {
  data() {
    return {
      counting: false,
      counter: 60,
      form: {
        phone: '',
        code: '',
        password: '',
        confirmPassword: ''
      }
    }
  },
  methods: {
    validatePhone(phone) {
      return /^1[3-9]\d{9}$/.test(phone)
    },
    getVerifyCode() {
      if (this.counting) return;
      if (!this.form.phone) {
        uni.showToast({ title: '请输入手机号', icon: 'none' }); return;
      }
      if (!this.validatePhone(this.form.phone)) {
        uni.showToast({ title: '手机号格式不正确', icon: 'none' }); return;
      }
      this.counting = true; this.counter = 60;
      const timer = setInterval(() => { this.counter--; if (this.counter <= 0) { clearInterval(timer); this.counting = false; } }, 1000);
      sendSmsCode({ mobile: this.form.phone, scene: 32 }).then(res => {
        if (res.code === 0) {
          uni.showToast({ title: '验证码已发送', icon: 'success' });
        }
      });
    },
    async handleSubmit() {
      if (!this.form.phone || !this.form.code || !this.form.password || !this.form.confirmPassword) {
        uni.showToast({ title: '请填写完整信息', icon: 'none' }); return;
      }
      if (!this.validatePhone(this.form.phone)) {
        uni.showToast({ title: '手机号格式不正确', icon: 'none' }); return;
      }
      if (this.form.password !== this.form.confirmPassword) {
        uni.showToast({ title: '两次密码不一致', icon: 'none' }); return;
      }
      const res = await resetPassword({
        mobile: this.form.phone,
        code: this.form.code,
        password: this.form.password,
        scene: 32
      });
      if (res.code === 0) {
        uni.showToast({
          title: '密码重置成功',
          icon: 'success',
          duration: 2000,
          success: () => {
            setTimeout(() => { this.goBack() }, 2000)
          }
        });
      }
    },
    goBack() {
      uni.navigateBack();
    }
  }
}
</script>

<style lang="scss" scoped>
.forget-pwd-container {
  min-height: 100vh;
  background: #f5f6fa;
  position: relative;
  padding: 0 40rpx;
  display: flex;
  flex-direction: column;
}
.header-decoration {
  height: 42vh;
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
  margin-top: -17vh;
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
  .back-btn {
    color: $primary-blue;
    font-size: 26rpx;
    text-decoration: underline;
    margin-left: 20rpx;
    text-align: right;
    margin-top: 20rpx;
    font-weight: 500;
  }
}
</style> 