import { request } from '@/utils/request'

export const productApi = {
  // 获得商品分页
  getProductPage(data) {
    return request({
      url: '/app-api/merchant/product/page',
      method: 'GET',
      data
    })
  },

  // 获得商品详情
  getProductDetail(spuId) {
    return request({
      url: `/app-api/merchant/product/get-detail/${spuId}`,
      method: 'GET'
    })
  },

  // 创建商品
  createProduct(data) {
    return request({
      url: '/app-api/merchant/product/create',
      method: 'POST',
      data
    })
  },

  // 更新商品
  updateProduct(data) {
    return request({
      url: '/app-api/merchant/product/update',
      method: 'PUT',
      data
    })
  },

  // 下架商品
  disableProduct(id) {
    return request({
      url: `/app-api/merchant/product/disable/${id}`,
      method: 'PUT'
    })
  },
  
  // 更新商品
  getProductCategory(parentId) {
    return request({
      url: `/app-api/merchant/product/category/${parentId}`,
      method: 'GET'
    })
  }
}
