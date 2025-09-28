import {
	useAuthStore
} from '@/store/auth'

const BASE_URL = 'http://127.0.0.1:48080'

// 请求队列，用于处理 token 刷新时的请求重试
const requestQueue = []

export const request = (options) => {
	return new Promise(async (resolve, reject) => {

		const authStore = useAuthStore()
		// 合并配置
		const config = {
			...options,
			url: `${BASE_URL}${options.url}`,
			method: options.method || 'GET',
			data: options.data || {},
			params: options.params || {},
			header: {
				'Content-Type': 'application/json',
				'user-type': 4,
				'tenant-id': 1,
				...options.headers
			}
		}

		// 添加认证 token
		if (authStore.accessToken) {
			config.header.Authorization = `Bearer ${authStore.accessToken}`
		}

		const doRequest = () => {
			uni.request({
				...config,
				success: (response) => {
					if(response.statusCode != 200){
						reject(new Error(`服务繁忙,请稍后再试~`))
					}
					switch (response.data.code) {
						case 0:
							resolve(response.data.data)
							break;
						case 401:
							// Token 过期，尝试刷新
							handleTokenExpired(config, resolve, reject)
							break;
						default:
							reject(new Error(`服务繁忙,请稍后再试~`))
							break;
					}
				},
				fail: (error) => {
					reject(new Error(`服务器开小差啦,请稍后再试~`))
				}
			})
		}

		// Token 过期处理
		const handleTokenExpired = async (originalConfig, resolve, reject) => {
			// 将原始请求加入队列
			requestQueue.push({
				config: originalConfig,
				resolve,
				reject
			})

			// 如果当前没有在刷新 token，则开始刷新
			if (!authStore.isRefreshing) {
				try {
					await authStore.refreshAccessToken()
					// 刷新成功，重试所有队列中的请求
					retryQueuedRequests()
				} catch (error) {
					// 刷新失败，清空队列并跳转到登录页
					failQueuedRequests(error)
					navigateToLogin()
				}
			}
		}

		doRequest()
	})
}

// 重试队列中的请求
const retryQueuedRequests = () => {
	while (requestQueue.length) {
		const {
			config,
			resolve,
			reject
		} = requestQueue.shift()
		request(config).then(resolve).catch(reject)
	}
}

// 处理队列中请求的失败
const failQueuedRequests = (error) => {
	while (requestQueue.length) {
		const {
			reject
		} = requestQueue.shift()
		reject(error)
	}
}

// 跳转到登录页
const navigateToLogin = () => {
	const currentPage = getCurrentPages().pop()
	if (currentPage && currentPage.route !== 'pages/login/login') {
		uni.redirectTo({
			url: '/pages/login/login'
		})
	}
}