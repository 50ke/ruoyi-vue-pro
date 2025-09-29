<template>
	<view class="product-detail-page">
		<view class="product-info" v-if="product">
			<image class="product-image" :src="product.picUrl" mode="aspectFill" />
			<view class="product-content">
				<text class="product-name">{{ product.name }}</text>
				<view class="product-status">
					<text :class="['status-badge', product.status === 1 ? 'online' : 'offline']">
						{{ product.status === 1 ? '已上架' : '已下架' }}
					</text>
				</view>
				<text class="product-intro">{{ product.introduction }}</text>
				<view class="product-stats">
					<view class="stat-item">
						<text class="stat-label">销量</text>
						<text class="stat-value">{{ product.salesCount || 0 }}</text>
					</view>
					<view class="stat-item">
						<text class="stat-label">库存</text>
						<text class="stat-value">{{ product.stock || 0 }}</text>
					</view>
					<view class="stat-item">
						<text class="stat-label">价格</text>
						<text class="stat-value">¥{{ (product.price || 0) / 100 }}</text>
					</view>
				</view>
				<text class="create-time">创建时间: {{ formatTime(product.createTime) }}</text>
			</view>
		</view>
		
		<view class="actions">
			<button class="action-btn edit-btn" @click="editProduct">编辑商品</button>
			<button class="action-btn disable-btn" @click="disableProduct" v-if="product?.status === 1">
				下架商品
			</button>
		</view>
		
		<view class="loading" v-if="loading">
			<text>加载中...</text>
		</view>
	</view>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useProductStore } from '@/store/product.js'

export default {
	name: 'ProductDetail',
	setup() {
		const productStore = useProductStore()
		
		const product = ref(null)
		const loading = ref(false)
		
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
			} catch (error) {
				console.error('加载商品详情失败:', error)
				uni.showToast({ title: '加载商品详情失败', icon: 'none' })
			} finally {
				loading.value = false
			}
		}
		
		const editProduct = () => {
			uni.navigateTo({
				url: `/pages/product/edit?id=${product.value.id}`
			})
		}
		
		const disableProduct = async () => {
			uni.showModal({
				title: '确认下架',
				content: '确定要下架这个商品吗？',
				success: async (res) => {
					if (res.confirm) {
						try {
							await productStore.disableProduct(product.value.id)
							uni.showToast({ title: '下架成功', icon: 'success' })
							product.value.status = 0
						} catch (error) {
							console.error('下架商品失败:', error)
							uni.showToast({ title: '下架失败', icon: 'none' })
						}
					}
				}
			})
		}
		
		const formatTime = (time) => {
			if (!time) return ''
			const date = new Date(time)
			return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`
		}
		
		onMounted(() => {
			loadProductDetail()
		})
		
		return {
			product,
			loading,
			editProduct,
			disableProduct,
			formatTime
		}
	}
}
</script>

<style lang="scss" scoped>
.product-detail-page {
	min-height: 100vh;
	background-color: #f5f5f5;
}

.product-info {
	background: white;
	margin: 32rpx;
	border-radius: 16rpx;
	overflow: hidden;
	
	.product-image {
		width: 100%;
		height: 400rpx;
	}
	
	.product-content {
		padding: 32rpx;
		
		.product-name {
			font-size: 36rpx;
			font-weight: 500;
			color: #333;
			margin-bottom: 16rpx;
			display: block;
			line-height: 1.4;
		}
		
		.product-status {
			margin-bottom: 16rpx;
			
			.status-badge {
				padding: 8rpx 16rpx;
				border-radius: 8rpx;
				font-size: 24rpx;
				
				&.online {
					background: #e8f5e8;
					color: #52c41a;
				}
				
				&.offline {
					background: #fff2e8;
					color: #fa8c16;
				}
			}
		}
		
		.product-intro {
			font-size: 28rpx;
			color: #666;
			line-height: 1.5;
			margin-bottom: 24rpx;
			display: block;
		}
		
		.product-stats {
			display: flex;
			gap: 48rpx;
			margin-bottom: 24rpx;
			
			.stat-item {
				display: flex;
				flex-direction: column;
				align-items: center;
				
				.stat-label {
					font-size: 24rpx;
					color: #999;
					margin-bottom: 8rpx;
				}
				
				.stat-value {
					font-size: 32rpx;
					font-weight: 500;
					color: #333;
				}
			}
		}
		
		.create-time {
			font-size: 24rpx;
			color: #999;
		}
	}
}

.actions {
	padding: 32rpx;
	display: flex;
	gap: 24rpx;
	
	.action-btn {
		flex: 1;
		height: 88rpx;
		border-radius: 12rpx;
		font-size: 32rpx;
		border: none;
		
		&.edit-btn {
			background: #2979ff;
			color: white;
		}
		
		&.disable-btn {
			background: #ff4757;
			color: white;
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
