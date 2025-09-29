<template>
	<view class="edit-product-page">
		<view class="header">
			<text class="title">编辑商品</text>
		</view>
		
		<view class="content" v-if="product">
			<view class="form-section">
				<text class="section-title">基本信息</text>
				<view class="form-item">
					<text class="label">商品名称</text>
					<input 
						v-model="formData.name" 
						placeholder="请输入商品名称"
						class="input"
					/>
				</view>
				<view class="form-item">
					<text class="label">商品简介</text>
					<textarea 
						v-model="formData.introduction" 
						placeholder="请输入商品简介"
						class="textarea"
					/>
				</view>
				<view class="form-item">
					<text class="label">商品详情</text>
					<textarea 
						v-model="formData.description" 
						placeholder="请输入商品详情"
						class="textarea"
					/>
				</view>
			</view>
			
			<view class="form-section">
				<text class="section-title">商品图片</text>
				<view class="image-upload">
					<view class="upload-item" v-for="(image, index) in formData.sliderPicUrls" :key="index">
						<image :src="image" class="uploaded-image" />
						<view class="delete-btn" @click="removeImage(index)">×</view>
					</view>
					<view class="upload-btn" @click="chooseImage" v-if="formData.sliderPicUrls.length < 5">
						<text class="upload-icon">+</text>
						<text class="upload-text">添加图片</text>
					</view>
				</view>
			</view>
			
			<view class="form-section">
				<text class="section-title">价格库存</text>
				<view class="form-item">
					<text class="label">商品价格（分）</text>
					<input 
						v-model.number="formData.price" 
						placeholder="请输入价格"
						type="number"
						class="input"
					/>
				</view>
				<view class="form-item">
					<text class="label">库存数量</text>
					<input 
						v-model.number="formData.stock" 
						placeholder="请输入库存"
						type="number"
						class="input"
					/>
				</view>
			</view>
		</view>
		
		<view class="footer">
			<button class="btn cancel-btn" @click="goBack">取消</button>
			<button class="btn submit-btn" @click="submitForm" :disabled="submitting">
				{{ submitting ? '保存中...' : '保存' }}
			</button>
		</view>
		
		<view class="loading" v-if="loading">
			<text>加载中...</text>
		</view>
	</view>
</template>

<script>
import { ref, reactive, onMounted } from 'vue'
import { useProductStore } from '@/store/product.js'

export default {
	name: 'EditProduct',
	setup() {
		const productStore = useProductStore()
		
		// 响应式数据
		const product = ref(null)
		const loading = ref(false)
		const submitting = ref(false)
		
		// 表单数据
		const formData = reactive({
			id: null,
			name: '',
			introduction: '',
			description: '',
			picUrl: '',
			sliderPicUrls: [],
			price: null,
			stock: null
		})
		
		// 方法
		const loadProductDetail = async () => {
			const pages = getCurrentPages()
			const currentPage = pages[pages.length - 1]
			const productId = currentPage.options.id
			
			if (!productId) {
				uni.showToast({ title: '商品ID不存在', icon: 'none' })
				return
			}
			
			loading.value = true
			try {
				const data = await productStore.fetchProductDetail(productId)
				product.value = data
				
				// 填充表单数据
				formData.id = data.id
				formData.name = data.name || ''
				formData.introduction = data.introduction || ''
				formData.description = data.description || ''
				formData.picUrl = data.picUrl || ''
				formData.sliderPicUrls = data.sliderPicUrls || []
				formData.price = data.price || null
				formData.stock = data.stock || null
			} catch (error) {
				console.error('加载商品详情失败:', error)
				uni.showToast({ title: '加载商品详情失败', icon: 'none' })
			} finally {
				loading.value = false
			}
		}
		
		const chooseImage = () => {
			uni.chooseImage({
				count: 5 - formData.sliderPicUrls.length,
				sizeType: ['compressed'],
				sourceType: ['album', 'camera'],
				success: (res) => {
					const tempFilePaths = res.tempFilePaths
					formData.sliderPicUrls.push(...tempFilePaths)
					if (formData.sliderPicUrls.length > 0 && !formData.picUrl) {
						formData.picUrl = formData.sliderPicUrls[0]
					}
				}
			})
		}
		
		const removeImage = (index) => {
			formData.sliderPicUrls.splice(index, 1)
			if (formData.sliderPicUrls.length > 0 && formData.picUrl === formData.sliderPicUrls[index]) {
				formData.picUrl = formData.sliderPicUrls[0]
			}
		}
		
		const submitForm = async () => {
			// 表单验证
			if (!formData.name.trim()) {
				uni.showToast({ title: '请输入商品名称', icon: 'none' })
				return
			}
			
			if (!formData.introduction.trim()) {
				uni.showToast({ title: '请输入商品简介', icon: 'none' })
				return
			}
			
			if (!formData.description.trim()) {
				uni.showToast({ title: '请输入商品详情', icon: 'none' })
				return
			}
			
			if (!formData.price || formData.price <= 0) {
				uni.showToast({ title: '请输入正确的价格', icon: 'none' })
				return
			}
			
			if (!formData.stock || formData.stock < 0) {
				uni.showToast({ title: '请输入正确的库存', icon: 'none' })
				return
			}
			
			submitting.value = true
			
			try {
				await productStore.updateProduct(formData)
				
				uni.showToast({
					title: '商品更新成功',
					icon: 'success'
				})
				
				setTimeout(() => {
					uni.navigateBack()
				}, 1500)
				
			} catch (error) {
				console.error('更新商品失败:', error)
				uni.showToast({
					title: '更新商品失败',
					icon: 'none'
				})
			} finally {
				submitting.value = false
			}
		}
		
		const goBack = () => {
			uni.navigateBack()
		}
		
		// 生命周期
		onMounted(() => {
			loadProductDetail()
		})
		
		return {
			product,
			loading,
			submitting,
			formData,
			chooseImage,
			removeImage,
			submitForm,
			goBack
		}
	}
}
</script>

<style lang="scss" scoped>
.edit-product-page {
	min-height: 100vh;
	background-color: #f5f5f5;
	display: flex;
	flex-direction: column;
}

.header {
	background: white;
	padding: 32rpx;
	border-bottom: 1rpx solid #eee;
	
	.title {
		font-size: 36rpx;
		font-weight: 500;
		color: #333;
	}
}

.content {
	flex: 1;
	padding: 32rpx;
}

.form-section {
	background: white;
	border-radius: 16rpx;
	padding: 32rpx;
	margin-bottom: 32rpx;
	
	.section-title {
		font-size: 32rpx;
		font-weight: 500;
		color: #333;
		margin-bottom: 32rpx;
		display: block;
	}
}

.form-item {
	margin-bottom: 32rpx;
	
	.label {
		font-size: 28rpx;
		color: #333;
		margin-bottom: 16rpx;
		display: block;
	}
	
	.input {
		width: 100%;
		height: 80rpx;
		padding: 0 24rpx;
		background: #f8f9fa;
		border-radius: 8rpx;
		font-size: 28rpx;
		border: none;
	}
	
	.textarea {
		width: 100%;
		min-height: 120rpx;
		padding: 24rpx;
		background: #f8f9fa;
		border-radius: 8rpx;
		font-size: 28rpx;
		border: none;
	}
}

.image-upload {
	display: flex;
	flex-wrap: wrap;
	gap: 20rpx;
	
	.upload-item {
		position: relative;
		width: 160rpx;
		height: 160rpx;
		
		.uploaded-image {
			width: 100%;
			height: 100%;
			border-radius: 8rpx;
		}
		
		.delete-btn {
			position: absolute;
			top: -10rpx;
			right: -10rpx;
			width: 40rpx;
			height: 40rpx;
			background: #ff4757;
			color: white;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
			font-size: 24rpx;
		}
	}
	
	.upload-btn {
		width: 160rpx;
		height: 160rpx;
		border: 2rpx dashed #ddd;
		border-radius: 8rpx;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		
		.upload-icon {
			font-size: 48rpx;
			color: #999;
			margin-bottom: 8rpx;
		}
		
		.upload-text {
			font-size: 24rpx;
			color: #999;
		}
	}
}

.footer {
	background: white;
	padding: 32rpx;
	border-top: 1rpx solid #eee;
	display: flex;
	gap: 24rpx;
	
	.btn {
		flex: 1;
		height: 88rpx;
		border-radius: 12rpx;
		font-size: 32rpx;
		border: none;
		
		&.cancel-btn {
			background: #f8f9fa;
			color: #666;
		}
		
		&.submit-btn {
			background: #2979ff;
			color: white;
			
			&:disabled {
				background: #ccc;
			}
		}
	}
}

.loading {
	text-align: center;
	padding: 80rpx;
	font-size: 28rpx;
	color: #999;
}
</style>
