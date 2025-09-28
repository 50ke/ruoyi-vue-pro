import { request } from '@/utils/request'

export const userApi = {
  // 获得基本信息
  getUserInfo() {
    return request({
      url: '/app-api/merchant/user/get',
      method: 'GET'
    })
  },

  // 获取门店信息
  getStores() {
    return request({
      url: '/app-api/merchant/user/get/store',
      method: 'GET'
    })
  },

  // 获取商户配送员信息
  getCouriers() {
    return request({
      url: '/app-api/merchant/user/get/courier',
      method: 'GET'
    })
  },

  // 获取门店配送员信息
  getStoreCouriers(storeId) {
    return request({
      url: `/app-api/merchant/user/get/courier/${storeId}`,
      method: 'GET'
    })
  },

  // 创建配送员
  createCourier(data) {
    return request({
      url: '/app-api/merchant/user/create/courier',
      method: 'POST',
      data
    })
  }
}
