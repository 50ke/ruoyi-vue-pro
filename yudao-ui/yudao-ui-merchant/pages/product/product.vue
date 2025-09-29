<template>
	<view class="product-page">
		<!-- 顶部Header区域 -->
		<view class="header">
			<!-- 第一行：门店切换和搜索框 -->
			<view class="header-row-1">
				<!-- 门店切换 -->
				<view class="store-selector" @click="showStorePicker = true">
					<text class="store-name">{{ currentStore?.name || '选择门店' }}</text>
					<text class="arrow">▼</text>
				</view>

				<!-- 搜索框 -->
				<view class="search-box">
					<input v-model="searchKeyword" placeholder="请输出商品名称" class="search-input" @confirm="handleSearch" />
					<text class="search-icon">🔍</text>
				</view>
			</view>

			<!-- 第二行：一级分类 -->
			<scroll-view class="category-tabs" scroll-x="true" show-scrollbar="false">
				<view class="category-tab" v-for="category in primaryCategories" :key="category.id"
					:class="{ active: selectedPrimaryCategory?.id === category.id }"
					@click="selectPrimaryCategory(category)">
					<text>{{ category.name }}</text>
				</view>
			</scroll-view>
		</view>

		<!-- 内容区域 -->
		<view class="content">
			<!-- 左侧：二级分类 -->
			<scroll-view class="subcategory-sidebar" scroll-y="true">
				<view class="subcategory-item" v-for="subcategory in subCategories" :key="subcategory.id"
					:class="{ active: selectedSubCategory?.id === subcategory.id }"
					@click="selectSubCategory(subcategory)">
					<text>{{ subcategory.name }}</text>
				</view>
			</scroll-view>

			<!-- 右侧：商品列表 -->
			<scroll-view class="product-list" scroll-y="true" @scrolltolower="loadMore" refresher-enabled="true"
				@refresherrefresh="onRefresh" :refresher-triggered="refreshing">
				<view class="product-item" v-for="product in products" :key="product.id">
					<image class="product-image" :src="product.picUrl" mode="aspectFill" />
					<view class="product-info">
						<text class="product-name">{{ product.name }}</text>
						<view class="product-status">
							<text :class="['status-badge', product.status === 1 ? 'online' : 'offline']">
								{{ product.status === 1 ? '已上架' : '已下架' }}
							</text>
						</view>
						<view class="product-stats">
							<text class="sales">销量: {{ product.salesCount || 0 }}</text>
							<text class="stock">库存: {{ product.stock || 0 }}</text>
						</view>
						<view class="create-time">
							<text>上架时间: </text>
							<uni-dateformat :date="product.createTime" format="yyyy-MM-dd hh:mm:ss"></uni-dateformat>
						</view>
						<view class="product-actions">
							<button class="action-btn view-btn" @click="viewProduct(product)">查看</button>
							<button class="action-btn edit-btn" @click="editProduct(product)">编辑</button>
						</view>
					</view>
				</view>

				<!-- 加载更多提示 -->
				<view class="load-more" v-if="loading">
					<text>加载中...</text>
				</view>
				<view class="no-more" v-if="!hasMore && products.length > 0">
					<text>没有更多了</text>
				</view>
			</scroll-view>
		</view>

		<!-- 右下角悬浮添加按钮 -->
		<view class="floating-add-btn" @click="addProduct">
			<text class="add-icon">+</text>
		</view>

		<!-- 自定义门店选择弹窗 -->
		<view class="picker-mask" v-if="showStorePicker" @click="showStorePicker = false">
			<view class="picker-content" @click.stop>
				<view class="picker-header">
					<text>选择门店</text>
					<text class="close-btn" @click="showStorePicker = false">×</text>
				</view>
				<view class="store-list">
					<view class="store-option" v-for="store in stores" :key="store.id"
						:class="{ selected: currentStore?.id === store.id }" @click="selectStore(store)">
						<text>{{ store.name }}</text>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		productApi
	} from '@/api/product'
	import {
		userApi
	} from '@/api/user'

	export default {
		// 数据
		data() {
			return {
				stores: [], //门店列表
				currentStore: null, //选中门店
				primaryCategories: [], //一级分类
				subCategories: [], //子分类
				selectedPrimaryCategory: null, //选中一级分类
				selectedSubCategory: null, //选中二级分类
				products: [], //商品列表
				pageNo: 1, //第几页
				pageSize: 10, //每页数据量
				showStorePicker: false, //显示门店选择器
				searchKeyword: '', //商品名称
				refreshing: false, //
				loading: false, //
				hasMore: true, //
			}
		},
		computed: {
		},
		methods: {
			// 获取门店
			async loadStores() {
				try {
					const data = await userApi.getStores()
					if (data) {
						this.stores = data
						if (data.length > 0) {
							this.currentStore = data[0]
						}
					}
				} catch (error) {
					console.error('加载门店失败:', error)
					uni.showToast({
						title: '加载门店失败',
						icon: 'none'
					})
				}
			},
			// 加载一级分类
			async loadPrimaryCategories() {
				try {
					const data = await productApi.getProductCategory(0)
					this.primaryCategories = data
					if (data.length > 0) {
						this.selectPrimaryCategory(this.primaryCategories[0])
					}
				} catch (error) {
					console.error('获取一级分类失败:', error)
				}
			},
			async selectPrimaryCategory(category) {
				try {
					this.selectedPrimaryCategory = category
					const data = await productApi.getProductCategory(category.id)
					this.subCategories = data
					if (data.length > 0) {
						this.selectSubCategory(this.subCategories[0])
					}
				} catch (error) {
					console.error('加载二级分类失败:', error)
				}
			},
			async selectSubCategory(category) {
				try {
					this.selectedSubCategory = category
					this.pageNo = 1
					this.hasMore = true
					this.loadProducts()
				} catch (error) {
					console.error('选中二级分类失败:', error)
				}
			},
			async selectStore(store) {
				this.currentStore = store
				this.showStorePicker = false
				this.pageNo = 1
				this.hasMore = true
				this.loadProducts()
			},
			handleSearch() {
				this.pageNo = 1
				this.hasMore = true
				this.loadProducts()
			},
			loadMore() {
				if (this.hasMore && !this.loading) {
					this.pageNo++
					this.loadProducts()
				}
			},
			async onRefresh() {
				this.refreshing = true
				this.pageNo = 1
				this.hasMore = true
				await this.loadProducts()
				this.refreshing = false
			},
			async loadProducts(category) {
				if (this.loading) return
				this.loading = true
				try {
					const params = {
						pageNo: this.pageNo,
						pageSize: this.pageSize,
						tabType: 0,
						storeId: this.currentStore.id,
						name: this.searchKeyword,
						categoryId: this.selectedSubCategory?.id,
					}
					const data = await productApi.getProductPage(params)
					if (this.pageNo === 1) {
						this.products = data.list
					} else {
						this.products.push(...data.list)
					}
					this.hasMore = data.total === this.pageSize
				} catch (error) {
					console.error('加载商品失败:', error)
					uni.showToast({
						title: '加载商品失败',
						icon: 'none'
					})
				} finally {
					this.loading = false
				}
			},
			addProduct() {
				uni.navigateTo({
					url: '/pages/product/add'
				})
			},
			viewProduct(product) {
				uni.navigateTo({
					url: `/pages/product/detail?id=${product.id}`
				})
			},
			editProduct(product) {
				uni.navigateTo({
					url: `/pages/product/edit?id=${product.id}`
				})
			},
			formatTime(timestamp) {
				if (!timestamp) return ''
				const date = new Date(timestamp)
				return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
			},
			async initData() {
			    await this.loadStores()
			    await this.loadPrimaryCategories()
			},
		},
		onShow() {
			this.initData()
		}
	}
</script>

<style lang="scss" scoped>
	.product-page {
		height: 100vh;
		display: flex;
		flex-direction: column;
		background-color: #f5f5f5;
	}

	.header {
		background: white;
		border-bottom: 1rpx solid #eee;

		.header-row-1 {
			display: flex;
			align-items: center;
			padding: 20rpx;
			gap: 20rpx;

			.store-selector {
				display: flex;
				align-items: center;
				padding: 16rpx 24rpx;
				background: #f8f9fa;
				border-radius: 8rpx;
				min-width: 160rpx;

				.store-name {
					font-size: 28rpx;
					color: #333;
					margin-right: 8rpx;
				}

				.arrow {
					font-size: 20rpx;
					color: #999;
				}
			}

			.search-box {
				flex: 1;
				position: relative;

				.search-input {
					width: 100%;
					height: 72rpx;
					padding: 0 60rpx 0 24rpx;
					background: #f8f9fa;
					border-radius: 36rpx;
					font-size: 28rpx;
					border: none;
				}

				.search-icon {
					position: absolute;
					right: 24rpx;
					top: 50%;
					transform: translateY(-50%);
					font-size: 28rpx;
					color: #999;
				}
			}
		}

		.category-tabs {
			white-space: nowrap;
			padding: 0 20rpx 20rpx;

			.category-tab {
				display: inline-block;
				padding: 16rpx 32rpx;
				margin-right: 20rpx;
				background: #f8f9fa;
				border-radius: 8rpx;
				font-size: 28rpx;
				color: #666;

				&.active {
					background: #2979ff;
					color: white;
				}
			}
		}
	}

	.content {
		flex: 1;
		display: flex;

		.subcategory-sidebar {
			width: 200rpx;
			background: white;
			border-right: 1rpx solid #eee;

			.subcategory-item {
				padding: 32rpx 20rpx;
				text-align: center;
				font-size: 26rpx;
				color: #666;
				border-bottom: 1rpx solid #f5f5f5;

				&.active {
					background: #f0f7ff;
					color: #2979ff;
					border-right: 4rpx solid #2979ff;
				}
			}
		}

		.product-list {
			flex: 1;
			background: white;

			.product-item {
				display: flex;
				padding: 24rpx;
				border-bottom: 1rpx solid #f5f5f5;

				.product-image {
					width: 160rpx;
					height: 160rpx;
					border-radius: 8rpx;
					margin-right: 24rpx;
				}

				.product-info {
					flex: 1;

					.product-name {
						font-size: 30rpx;
						color: #333;
						font-weight: 500;
						display: block;
						margin-bottom: 12rpx;
						line-height: 1.4;
					}

					.product-status {
						margin-bottom: 12rpx;

						.status-badge {
							padding: 4rpx 12rpx;
							border-radius: 4rpx;
							font-size: 22rpx;

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

					.product-stats {
						display: flex;
						gap: 24rpx;
						margin-bottom: 12rpx;

						.sales,
						.stock {
							font-size: 24rpx;
							color: #666;
						}
					}

					.create-time {
						font-size: 22rpx;
						color: #999;
						display: block;
						margin-bottom: 16rpx;
					}

					.product-actions {
						display: flex;
						gap: 16rpx;

						.action-btn {
							padding: 12rpx 24rpx;
							border-radius: 6rpx;
							font-size: 24rpx;
							border: none;

							&.view-btn {
								background: #f0f7ff;
								color: #2979ff;
							}

							&.edit-btn {
								background: #2979ff;
								color: white;
							}
						}
					}
				}
			}

			.load-more,
			.no-more {
				text-align: center;
				padding: 40rpx;
				font-size: 26rpx;
				color: #999;
			}
		}
	}

	.floating-add-btn {
		position: fixed;
		right: 40rpx;
		bottom: 120rpx;
		width: 100rpx;
		height: 100rpx;
		background: #2979ff;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		box-shadow: 0 8rpx 24rpx rgba(41, 121, 255, 0.3);
		z-index: 100;

		.add-icon {
			color: white;
			font-size: 48rpx;
			font-weight: bold;
		}
	}

	.picker-mask {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(0, 0, 0, 0.5);
		z-index: 1000;
		display: flex;
		align-items: flex-end;

		.picker-content {
			width: 100%;
			background: white;
			border-radius: 24rpx 24rpx 0 0;
			max-height: 80vh;

			.picker-header {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 32rpx;
				border-bottom: 1rpx solid #eee;
				font-size: 32rpx;
				font-weight: 500;

				.close-btn {
					font-size: 48rpx;
					color: #999;
				}
			}

			.store-list {
				max-height: 60vh;
				overflow-y: auto;

				.store-option {
					padding: 32rpx;
					border-bottom: 1rpx solid #f5f5f5;
					font-size: 28rpx;

					&.selected {
						background: #f0f7ff;
						color: #2979ff;
					}
				}
			}
		}
	}
</style>