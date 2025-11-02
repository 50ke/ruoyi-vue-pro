import { request } from '@/utils/request'

export const authApi = {
  // 微信小程序一键登录
  weixinMiniAppLogin(data) {
    return request({
      url: '/app-api/courier/auth/weixin-mini-app-login',
      method: 'POST',
      data
    })
  },

  // 刷新令牌
  refreshToken(refreshToken) {
    return request({
      url: `/app-api/courier/auth/refresh-token?refreshToken=${refreshToken}`,
      method: 'POST'
    })
  },

  // 登出
  logout() {
    return request({
      url: '/app-api/courier/auth/logout',
      method: 'POST'
    })
  }
}