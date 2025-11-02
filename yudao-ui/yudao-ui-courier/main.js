// #ifndef VUE3
import Vue from 'vue'
import App from './App'

Vue.config.productionTip = false

App.mpType = 'app'

const app = new Vue({
	...App
})
app.$mount()
// #endif

// #ifdef VUE3
import {
	createSSRApp
} from 'vue'
import App from './App.vue'
import * as Pinia from 'pinia'
import { useAuthStore } from '@/store/auth'

export function createApp() {
	const app = createSSRApp(App)
	app.use(Pinia.createPinia())
	// 检查登录状态
	const authStore = useAuthStore()
	authStore.checkLoginOnLaunch()
	return {
		app,
		Pinia
	}
}
// #endif