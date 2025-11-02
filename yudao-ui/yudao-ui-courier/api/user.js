import { request } from '@/utils/request'

export const userApi = {
  // 获取用户信息
  getUserInfo() {
    return request({
      url: '/app-api/courier/user/get',
      method: 'GET'
    })
  },

  // 修改用户信息
  updateUserInfo(data) {
    return request({
      url: '/app-api/courier/user/update',
      method: 'POST',
      data
    })
  }
}
