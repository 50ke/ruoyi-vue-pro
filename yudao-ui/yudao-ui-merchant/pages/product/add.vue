<template>
	<view class="add-product-page">
		<view class="header">
			<text class="title">添加商品</text>
		</view>
		
		<view class="content">
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
				<text class="section-title">商品分类</text>
				<view class="form-item">
					<text class="label">一级分类</text>
					<picker 
						:value="primaryCategoryIndex" 
						:range="primaryCategories" 
						range-key="name"
						@change="onPrimaryCategoryChange"
					>
						<view class="picker">
							<text>{{ selectedPrimaryCategory?.name || '请选择一级分类' }}</text>
							<text class="arrow">▼</text>
						</view>
					</picker>
				</view>
				<view class="form-item">
					<text class="label">二级分类</text>
					<picker 
						:value="subCategoryIndex" 
						:range="subCategories" 
						range-key="name"
						@change="onSubCategoryChange"
					>
						<view class="picker">
							<text>{{ selectedSubCategory?.name || '请选择二级分类' }}</text>
							<text class="arrow">▼</text>
						</view>
					</picker>
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
				{{ submitting ? '提交中...' : '提交' }}
			</button>
		</view>
	</view>
</template>

<script>
import { ref, reactive, onMounted, computed } from 'vue'
import { useProductStore } from '@/store/product.js'

export default {
	name: 'AddProduct',
	setup() {
		const productStore = useProductStore()
		
		// 表单数据
		const formData = reactive({
			name: '',
			introduction: '',
			description: '',
			picUrl: '',
			sliderPicUrls: [],
			categoryId: null,
			storeId: [],
			price: null,
			stock: null,
			status: 1
		})
		
		// 分类数据
		const primaryCategories = ref([])
		const subCategories = ref([])
		const primaryCategoryIndex = ref(0)
		const subCategoryIndex = ref(0)
		
		// 状态
		const submitting = ref(false)
		
		// 计算属性
		const selectedPrimaryCategory = computed(() => {
			return primaryCategories.value[primaryCategoryIndex.value] || null
		})
		
		const selectedSubCategory = computed(() => {
			return subCategories.value[subCategoryIndex.value] || null
		})
		
		// 方法
		const loadPrimaryCategories = async () => {
			try {
				await productStore.fetchPrimaryCategories()
				primaryCategories.value = productStore.primaryCategories
			} catch (error) {
				console.error('加载一级分类失败:', error)
			}
		}
		
		const onPrimaryCategoryChange = async (e) => {
			primaryCategoryIndex.value = e.detail.value
			const category = primaryCategories.value[primaryCategoryIndex.value]
			if (category) {
				try {
					await productStore.fetchSubCategories(category.id)
					subCategories.value = productStore.subCategories
					subCategoryIndex.value = 0
				} catch (error) {
					console.error('加载二级分类失败:', error)
				}
			}
		}
		
		const onSubCategoryChange = (e) => {
			subCategoryIndex.value = e.detail.value
			const category = subCategories.value[subCategoryIndex.value]
			if (category) {
				formData.categoryId = category.id
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
			
			if (!formData.categoryId) {
				uni.showToast({ title: '请选择商品分类', icon: 'none' })
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
			
			if (formData.sliderPicUrls.length === 0) {
				uni.showToast({ title: '请上传商品图片', icon: 'none' })
				return
			}
			
			submitting.value = true
			
			try {
				// 这里应该上传图片到服务器，获取真实的图片URL
				// 暂时使用本地路径作为示例
				const productData = {
					...formData,
					storeId: [1] // 暂时使用固定门店ID
				}
				
				await productStore.createProduct(productData)
				
				uni.showToast({
					title: '商品添加成功',
					icon: 'success'
				})
				
				setTimeout(() => {
					uni.navigateBack()
				}, 1500)
				
			} catch (error) {
				console.error('添加商品失败:', error)
				uni.showToast({
					title: '添加商品失败',
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
		onMounted(async () => {
			await loadPrimaryCategories()
		})
		
		return {
			formData,
			primaryCategories,
			subCategories,
			primaryCategoryIndex,
			subCategoryIndex,
			selectedPrimaryCategory,
			selectedSubCategory,
			submitting,
			onPrimaryCategoryChange,
			onSubCategoryChange,
			chooseImage,
			removeImage,
			submitForm,
			goBack
		}
	}
}
</script>

<style lang="scss" scoped>
.add-product-page {
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
	
	.picker {
		display: flex;
		align-items: center;
		justify-content: space-between;
		height: 80rpx;
		padding: 0 24rpx;
		background: #f8f9fa;
		border-radius: 8rpx;
		font-size: 28rpx;
		color: #333;
		
		.arrow {
			font-size: 20rpx;
			color: #999;
		}
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
</style>
