<template>
    <view class="login-container">
        <!-- 替换波浪为新的顶部装饰 -->
        <view class="header-decoration"></view>
        
        <!-- 登录表单 -->
        <view class="form-box">
            <view class="title">{{ isLogin ? '欢迎登录' : '账号注册' }}</view>
            
            <!-- 输入框区域 -->
            <view class="input-group">
                <view class="input-box">
                    <input type="number" v-model="form.phone" maxlength="11" placeholder="请输入手机号" />
                </view>
                <view class="input-box code-box">
                    <input type="number" v-model="form.code" maxlength="6" placeholder="请输入验证码" />
                    <text class="code-btn" 
                          :class="{ disabled: counting }" 
                          @click="getVerifyCode">
                        {{ counting ? `${counter}s后重试` : '获取验证码' }}
                    </text>
                </view>
                <view class="input-box" v-if="!isLogin">
                    <input type="text" v-model="form.username" placeholder="请输入用户名" />
                </view>
                <view class="input-box" v-if="!isLogin">
                    <input type="password" v-model="form.password" placeholder="请输入密码" />
                </view>
                <view class="input-box" v-if="!isLogin">
                    <input type="password" v-model="form.confirmPassword" placeholder="请确认密码" />
                </view>
                
                <!-- 隐私政策确认 -->
                <view class="privacy-box">
                    <checkbox-group @change="handlePrivacyChange">
                        <checkbox :checked="form.agreePrivacy" style="transform:scale(0.7)" />
                    </checkbox-group>
                    <text class="privacy-text">我已阅读并同意</text>
                    <text class="privacy-link" @click="showPrivacyPolicy">《隐私政策》</text>
                </view>
            </view>
            
            <!-- 按钮区域 -->
            <view class="btn-group">
                <button class="submit-btn" @click="handleSubmit">
                    {{ isLogin ? '登 录' : '注 册' }}
                </button>
                <view class="action-links">
                    <text class="forget-pwd" v-if="isLogin" @click="goToForgetPwd">忘记密码？</text>
                    <text class="switch-type" @click="switchLoginType">
                        {{ isLogin ? '没有账号？去注册' : '已有账号？去登录' }}
                    </text>
                </view>
            </view>
        </view>
    </view>
</template>

<script>
export default {
    name: 'loginA',
    data() {
        return {
            isLogin: true,
            counting: false,
            counter: 60,
            form: {
                phone: '',
                code: '',
                username: '',
                password: '',
                confirmPassword: '',
                agreePrivacy: false
            }
        }
    },
    methods: {
        switchLoginType() {
            this.isLogin = !this.isLogin
            // 重置验证码相关状态
            this.counting = false
            this.counter = 60
            // 重置表单数据
            this.form = {
                phone: this.form.phone, // 保留手机号
                code: '',
                username: '',
                password: '',
                confirmPassword: '',
                agreePrivacy: this.form.agreePrivacy // 保留隐私政策选择状态
            }
        },
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
            
            // 开始倒计时
            this.counting = true
            this.counter = 60
            const timer = setInterval(() => {
                this.counter--
                if (this.counter <= 0) {
                    clearInterval(timer)
                    this.counting = false
                }
            }, 1000)
            
            // 这里添加发送验证码的实际逻辑
            uni.showToast({
                title: '验证码已发送',
                icon: 'success'
            })
        },
        
        handlePrivacyChange(e) {
            this.form.agreePrivacy = e.detail.value.length > 0
        },
        
        showPrivacyPolicy() {
            // 显示隐私政策
            uni.showModal({
                title: '隐私政策',
                content: '这里是隐私政策内容...',
                showCancel: false
            })
        },
        
        handleSubmit() {
            if (!this.form.phone || !this.form.code) {
                uni.showToast({
                    title: '请填写完整信息',
                    icon: 'none'
                })
                return
            }
            
            // 添加隐私政策验证（移到最前面）
            if (!this.form.agreePrivacy) {
                uni.showToast({
                    title: '请同意隐私政策',
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
            
            if (!this.isLogin) {
                if (!this.form.username || !this.form.password || !this.form.confirmPassword) {
                    uni.showToast({
                        title: '请填写完整信息',
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
            }

            // 这里添加实际的登录/注册逻辑
            uni.showToast({
                title: this.isLogin ? '登录成功' : '注册成功',
                icon: 'success'
            })
        },
        goToForgetPwd() {
            uni.navigateTo({
                url: '/pages/profile/forget-password'
            })
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

// 删除旧的.wave-box相关样式，添加新的顶部装饰样式
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
    background: rgba(255, 255, 255, 0.95);
    border-radius: 30rpx;
    padding: 60rpx 60rpx;
    box-shadow: 0 10rpx 50rpx rgba(114, 130, 183, 0.15),
                0 0 20rpx rgba(114, 130, 183, 0.08);
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
        text-shadow: 2rpx 2rpx 4rpx rgba(0, 0, 0, 0.05);
    }
}

.input-group {
    margin: 0;
    
    .input-box {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 16rpx;
        margin-bottom: 40rpx;
        padding: 24rpx 40rpx;
        box-shadow: inset 0 2rpx 8rpx rgba(114, 130, 183, 0.08),
                    0 2rpx 4rpx rgba(255, 255, 255, 0.9);
        border: 1px solid rgba(114, 130, 183, 0.15);
        transition: all 0.3s ease;
        
        &:last-child {
            margin-bottom: 20rpx;
        }
        
        input {
            flex: 1;
            font-size: 28rpx;
            color: #4A5568;
            padding: 4rpx 0;
            
            &::placeholder {
                color: #A0AEC0;
            }
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
    padding: 0;
    
    .submit-btn {
        background: linear-gradient(135deg, #6B8DE3, #7C5CBF);
        color: #fff;
        border: none;
        border-radius: 50rpx;
        font-size: 30rpx;
        font-weight: 500;
        letter-spacing: 8rpx;
        box-shadow: 0 8rpx 20rpx rgba(107, 141, 227, 0.25);
        transition: all 0.3s ease;
        width: 85%;
        margin: 0 auto;
        
        &:active {
            transform: translateY(2rpx);
            box-shadow: 0 4rpx 10rpx rgba(107, 141, 227, 0.15);
            opacity: 0.95;
        }
    }
    
    .action-links {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 40rpx;
        
        .forget-pwd {
            font-size: 26rpx;
            color: #6B8DE3;
            padding: 20rpx;
            margin-right: 40rpx;
            
            &:active {
                opacity: 0.8;
            }
        }
        
        .switch-type {
            font-size: 26rpx;
            color: #6B8DE3;
            padding: 20rpx;
            
            &:active {
                opacity: 0.8;
            }
        }
    }
}

.privacy-box {
    display: flex;
    align-items: center;
    padding: 0 20rpx;
    margin-top: -20rpx;
    
    .privacy-text {
        font-size: 24rpx;
        color: #666;
        margin-left: -10rpx;
    }
    
    .privacy-link {
        font-size: 24rpx;
        color: #6B8DE3;
    }
}
</style>