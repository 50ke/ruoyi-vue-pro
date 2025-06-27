<template>
    <view class="forget-pwd-container">
        <view class="header-decoration"></view>
        
        <view class="form-box">
            <view class="title">重置密码</view>
            
            <view class="input-group">
                <view class="input-box">
                    <text class="iconfont icon-phone"></text>
                    <input v-model="form.phone" maxlength="11" placeholder="请输入手机号" />
                </view>
                
                <view class="input-box code-box">
                    <input v-model="form.code" maxlength="6" placeholder="请输入验证码" />
                    <text class="code-btn" 
                          :class="{ disabled: counting }" 
                          @click="getVerifyCode">
                        {{ counting ? `${counter}s后重试` : '获取验证码' }}
                    </text>
                </view>
                
                <view class="input-box">
                    <input v-model="form.password" placeholder="请输入新密码" />
                </view>
                
                <view class="input-box">
                    <input v-model="form.confirmPassword" placeholder="请确认新密码" />
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
            if (this.counting) return
            
            if (!this.form.phone) {
                uni.showToast({
                    title: '请输入手机号',
                    icon: 'none'
                })
                return
            }
            
            if (!this.validatePhone(this.form.phone)) {
                uni.showToast({
                    title: '手机号格式不正确',
                    icon: 'none'
                })
                return
            }
            
            this.counting = true
            this.counter = 60
            const timer = setInterval(() => {
                this.counter--
                if (this.counter <= 0) {
                    clearInterval(timer)
                    this.counting = false
                }
            }, 1000)
            
            uni.showToast({
                title: '验证码已发送',
                icon: 'success'
            })
        },
        
        handleSubmit() {
            if (!this.form.phone || !this.form.code || !this.form.password || !this.form.confirmPassword) {
                uni.showToast({
                    title: '请填写完整信息',
                    icon: 'none'
                })
                return
            }
            
            if (!this.validatePhone(this.form.phone)) {
                uni.showToast({
                    title: '手机号格式不正确',
                    icon: 'none'
                })
                return
            }
            
            if (this.form.password !== this.form.confirmPassword) {
                uni.showToast({
                    title: '两次密码不一致',
                    icon: 'none'
                })
                return
            }
            
            // 这里添加重置密码的实际逻辑
            uni.showToast({
                title: '密码重置成功',
                icon: 'success',
                duration: 2000,
                success: () => {
                    setTimeout(() => {
                        this.goBack()
                    }, 2000)
                }
            })
        },
        
        goBack() {
            uni.navigateBack()
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
    background: rgba(255, 255, 255, 0.95);
    border-radius: 30rpx;
    padding: 60rpx 60rpx;
    box-shadow: 0 10rpx 50rpx rgba(114, 130, 183, 0.15);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.9);
    
    .title {
        font-size: 40rpx;
        font-weight: 600;
        text-align: center;
        margin-bottom: 80rpx;
        background: linear-gradient(135deg, #6B8DE3, #7C5CBF);
        -webkit-background-clip: text;
        color: transparent;
    }
}

.input-group {
    .input-box {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 16rpx;
        margin-bottom: 40rpx;
        padding: 24rpx 40rpx;
        box-shadow: inset 0 2rpx 8rpx rgba(114, 130, 183, 0.08);
        border: 1px solid rgba(114, 130, 183, 0.15);
        
        input {
            flex: 1;
            font-size: 28rpx;
            color: #4A5568;
        }
    }
    
    .code-box {
        position: relative;
        
        .code-btn {
            position: absolute;
            right: 40rpx;
            color: #6B8DE3;
            font-size: 26rpx;
            padding: 10rpx 0 10rpx 30rpx;
            border-left: 1px solid rgba(114, 130, 183, 0.2);
            
            &.disabled {
                color: #A0AEC0;
            }
        }
    }
}

.btn-group {
    margin-top: 50rpx;
    
    .submit-btn {
        background: linear-gradient(135deg, #6B8DE3, #7C5CBF);
        color: #fff;
        border: none;
        border-radius: 50rpx;
        font-size: 30rpx;
        font-weight: 500;
        letter-spacing: 8rpx;
        box-shadow: 0 8rpx 20rpx rgba(107, 141, 227, 0.25);
        width: 85%;
        margin: 0 auto;
    }
    
    .back-btn {
        text-align: center;
        margin-top: 40rpx;
        padding: 20rpx;
        font-size: 26rpx;
        color: #6B8DE3;
    }
}
</style> 