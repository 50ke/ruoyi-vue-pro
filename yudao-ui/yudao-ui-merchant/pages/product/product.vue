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
				</view>
			</view>

			<!-- 第二行：一级分类 -->
			<scroll-view class="category-tabs" scroll-x="true" show-scrollbar="false">
				<view class="category-tab" v-for="category in primaryCategories" :key="category.id"
					:class="{ active: selectedPrimaryCategory?.id === category.id }"
					@click="selectPrimaryCategory(category)">
					<image class="category-icon" :src="category.picUrl" mode="aspectFill" />
					<text class="category-name">{{ category.name }}</text>
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
				<!-- 排序和筛选区域 -->
				<view class="sort-filter-area">
					<!-- 排序选项 -->
					<view class="sort-options">
						<view class="sort-option" :class="{ active: sortField === 'createTime' }"
							@click="setSortField('createTime')">
							<text>上架时间</text>
							<text class="sort-icon"
								:class="{ asc: sortAsc, desc: !sortAsc && sortField === 'createTime' }">
								{{ sortField === 'createTime' ? (sortAsc ? '↑' : '↓') : '' }}
							</text>
						</view>
						<view class="sort-option" :class="{ active: sortField === 'salesCount' }"
							@click="setSortField('salesCount')">
							<text>销量</text>
							<text class="sort-icon"
								:class="{ asc: sortAsc && sortField === 'salesCount', desc: !sortAsc && sortField === 'salesCount' }">
								{{ sortField === 'salesCount' ? (sortAsc ? '↑' : '↓') : '' }}
							</text>
						</view>
						<view class="sort-option" :class="{ active: sortField === 'stock' }"
							@click="setSortField('stock')">
							<text>库存</text>
							<text class="sort-icon"
								:class="{ asc: sortAsc && sortField === 'stock', desc: !sortAsc && sortField === 'stock' }">
								{{ sortField === 'stock' ? (sortAsc ? '↑' : '↓') : '' }}
							</text>
						</view>
					</view>

					<!-- 筛选按钮 -->
					<view class="filter-btn" @click="showFilterPanel = true">
						<text>筛选</text>
					</view>
				</view>

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

		<!-- 筛选面板 -->
		<view class="picker-mask" v-if="showFilterPanel" @click="showFilterPanel = false">
			<view class="picker-content" @click.stop>
				<view class="picker-header">
					<text>筛选</text>
					<text class="close-btn" @click="showFilterPanel = false">×</text>
				</view>
				<view class="filter-list">
					<view class="filter-section">
						<text class="section-title">商品状态</text>
						<view class="filter-options">
							<view class="filter-option" v-for="option in statusOptions" :key="option.value"
								:class="{ selected: tabType === option.value }" @click="setTabType(option.value)">
								<text>{{ option.label }}</text>
							</view>
						</view>
					</view>
				</view>
				<view class="filter-actions">
					<button class="action-btn reset-btn" @click="resetFilter">重置</button>
					<button class="action-btn confirm-btn" @click="completeFilter">确定</button>
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
				selectedSubCategory: null, // 选中二级分类
				products: [], //商品列表
				pageNo: 1, //第几页
				pageSize: 10, //每页数据量
				showStorePicker: false, //显示门店选择器
				searchKeyword: '', //商品名称
				refreshing: false,
				loading: false,
				hasMore: true,
				sortField: 'createTime', // 排序字段：createTime, salesCount, stock
				sortAsc: false, // 是否升序
				tabType: -1, // 状态筛选：-1全部, 0-出售中, 1-仓库中, 2-已售罄, 3-警戒库存, 4-回收站
				showFilterPanel: false, // 是否显示筛选面板
				statusOptions: [{
						value: -1,
						label: '全部'
					},
					{
						value: 0,
						label: '出售中'
					},
					{
						value: 1,
						label: '仓库中'
					},
					{
						value: 2,
						label: '已售罄'
					},
					{
						value: 3,
						label: '警戒库存'
					},
					{
						value: 4,
						label: '回收站'
					}
				]
			}
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
						tabType: this.tabType !== -1 ? this.tabType : 0,
						storeId: this.currentStore.id,
						name: this.searchKeyword,
						categoryId: this.selectedSubCategory?.id,
						sortFiled: this.sortField,
						sortAsc: this.sortAsc
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
			// 设置排序类型
			setSortField(field) {
				if (this.sortField === field) {
					// 如果点击的是当前排序类型，则切换排序顺序
					this.sortAsc = !this.sortAsc
				} else {
					// 否则设置新的排序类型，并默认降序
					this.sortField = field
					this.sortAsc = false
				}
				// 重新加载商品列表
				this.pageNo = 1
				this.hasMore = true
				this.loadProducts()
			},
			// 设置状态筛选
			setTabType(tabType) {
				this.tabType = tabType
			},
			// 清除筛选条件
			resetFilter() {
				this.tabType = -1
			},
			// 完成筛选
			completeFilter() {
				this.showFilterPanel = false
				// 重新加载商品列表
				this.pageNo = 1
				this.hasMore = true
				this.loadProducts()
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
				flex-direction: column; /* 改为两行布局 */
				align-items: stretch;
				padding: 20rpx;
				gap: 16rpx;

				.store-selector {
					width: 100%;
				display: flex;
				align-items: center;
				padding: 16rpx 24rpx;
				background: #f8f9fa;
				border-radius: 8rpx;
					min-width: 0;

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
					width: 100%;
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
			}
		}

		.category-tabs {
			white-space: nowrap;
			padding: 0 20rpx 20rpx;

			.category-tab {
				display: inline-block;
				padding: 8rpx 12rpx;
				margin-right: 12rpx;
				background: transparent;
				border-radius: 0;
				font-size: 24rpx;
				color: #666;
				text-align: center;
				width: auto; /* 自适应宽度，保证文字完整显示 */

				.category-icon {
					display: block;
					width: 100rpx;
					height: 100rpx;
					margin: 0 auto 8rpx;
					border-radius: 8rpx;
				}

				.category-name {
					display: inline-block;
					width: auto; /* 让内容决定宽度 */
					text-align: center;
					padding: 8rpx 10rpx;
					border-radius: 18rpx;
					white-space: nowrap; /* 禁止换行 */
					overflow: visible; /* 不裁切 */
					text-overflow: initial; /* 不省略 */
					line-height: 1.3;
				}

				&.active {
					color: #2979ff;
					.category-name {
						background: #2979ff;
						color: #fff;
					}
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
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;

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

			.sort-filter-area {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 0 24rpx;
				border-bottom: 1rpx solid #f5f5f5;

				.sort-options {
					display: flex;
					flex-wrap: nowrap;
					gap: 8rpx;

					.sort-option {
						display: flex;
						align-items: center;
						padding: 24rpx 32rpx;
						font-size: 28rpx;
						color: #666;
						white-space: nowrap;

						.sort-icon {
							font-size: 20rpx;
							margin-left: 8rpx;
							color: #999;

							&.asc,
							&.desc {
								color: #2979ff;
							}
						}

						&.active {
							color: #2979ff;
						}
					}
				}

				.filter-btn {
					padding: 24rpx 32rpx;
					font-size: 28rpx;
					color: #666;
					position: relative;
					white-space: nowrap;

					&::after {
						content: '';
						position: absolute;
						left: 0;
						top: 50%;
						transform: translateY(-50%);
						width: 1rpx;
						height: 40rpx;
						background: #f5f5f5;
					}
				}
			}

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
			display: flex;
			flex-direction: column;

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

			.store-list,
			.filter-list {
				flex: 1;
				overflow-y: auto;
				max-height: 260rpx;
				/* 限制高度为3个门店项的高度 */

				.store-option {
					padding: 32rpx;
					border-bottom: 1rpx solid #f5f5f5;
					font-size: 28rpx;

					&.selected {
						background: #f0f7ff;
						color: #2979ff;
					}
				}

				.filter-section {
					padding: 24rpx;

					.section-title {
						font-size: 28rpx;
						font-weight: 500;
						margin-bottom: 24rpx;
						display: block;
					}

					.filter-options {
						display: flex;
						flex-wrap: wrap;

						.filter-option {
							display: inline-block;
							margin: 0 16rpx 16rpx 0;
							padding: 12rpx 24rpx;
							border: 1rpx solid #eee;
							border-radius: 6rpx;
							background: white;
							border-bottom: none;

							&.selected {
								background: #2979ff;
								color: white;
								border-color: #2979ff;
							}
						}
					}
				}
			}

			.filter-actions {
				display: flex;
				padding: 24rpx;
				border-top: 1rpx solid #f5f5f5;

				.action-btn {
					flex: 1;
					padding: 20rpx;
					margin: 0 12rpx;
					border-radius: 6rpx;
					font-size: 28rpx;
					border: none;

					&.reset-btn {
						background: #f5f5f5;
						color: #666;
					}

					&.confirm-btn {
						background: #2979ff;
						color: white;
					}
				}
			}
		}
	}
</style>