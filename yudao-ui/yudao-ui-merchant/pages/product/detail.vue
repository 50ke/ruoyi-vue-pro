<template>
	<view class="detail-product-page">
		<view>
			<uni-section title="商品信息" type="line" padding style="height: calc(100vh - 100px);">
				<uni-forms>
					<uni-forms-item label="商品名称">
						<uni-easyinput disabled v-model="product.name" placeholder="请输入商品名称" />
					</uni-forms-item>
					<uni-forms-item label="商品分类">
						<uni-data-picker readonly popup-title="商品分类" v-model="product.categoryId" :localdata="categories" />
					</uni-forms-item>
					<uni-forms-item label="上架门店">
						<uni-data-select disabled v-model="product.storeId" multiple wrap :localdata="stores" />
					</uni-forms-item>
					<uni-forms-item label="商品关键字">
						<uni-easyinput disabled v-model="product.keyword"/>
					</uni-forms-item>
					<uni-forms-item label="商品简介">
						<uni-easyinput disabled type="textarea" v-model="product.introduction"/>
					</uni-forms-item>
					<uni-forms-item label="商品详情">
						<uni-easyinput disabled type="textarea" v-model="product.description"/>
					</uni-forms-item>
					<uni-forms-item label="商品封面图">
						<uni-file-picker
							readonly
							limit=1
							return-type=object
							v-model="picUrl"
							file-mediatype="image"/>
					</uni-forms-item>
					<uni-forms-item label="商品轮播图">
						<uni-file-picker
							readonly
							limit=5
							v-model="sliderPicUrls"
							file-mediatype="image"/>
					</uni-forms-item>
					<uni-forms-item label="商品条码">
						<uni-easyinput disabled v-model="product.barCode" placeholder="请输入商品条码" />
					</uni-forms-item>
					<uni-forms-item label="商品价格(分)">
						<uni-easyinput disabled type="number" v-model="product.price" placeholder="请输入商品价格" />
					</uni-forms-item>
					<uni-forms-item label="商品库存">
						<uni-easyinput disabled type="number" v-model="product.stock" placeholder="请输入商品库存" />
					</uni-forms-item>
				</uni-forms>
			</uni-section>
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
	import {
		infraApi
	} from '@/api/infra'
	export default {
		data() {
			return {
				product: {
					id: 0,				//商品ID
					name: '', 			//商品名称
					keyword: '', 		//关键字
					introduction: '', 	//简介
					description: '', 	//详情
					categoryId: 0, 		//分类
					storeId: [], 		//门店
					picUrl: {}, 		//封面图
					sliderPicUrls: [], 	//轮播图
					barCode: '',		//商品条码
					price: 0,			//价格
					stock: 0,			//库存
				},
				categories: [], //商品分类
				stores: [],		//门店列表
				picUrl: {},
				sliderPicUrls: []
			}
		},
		methods: {
			// 加载商品数据
			async loadProduct(id) {
				try {
					const data = await productApi.getProductDetail(id)
					this.product = {
						id: data.id,
						name: data.name,
						keyword: data.keyword,
						introduction: data.introduction,
						description: data.description,
						categoryId: data.categoryId,
						storeId: data.storeId,
						picUrl: data.picUrl,
						sliderPicUrls: data.sliderPicUrls,
						barCode: data.skus[0].barCode,
						price: data.skus[0].price,
						stock: data.skus[0].stock
					}
					this.picUrl = {
						name: data.picUrl,
						extname: data.picUrl,
						url: data.picUrl,
					}
					this.sliderPicUrls = data.sliderPicUrls.map(item => ({
						name: item,
						extname: item,
						url: item,
					}))
				} catch (error) {
					console.error('获取商品详情失败:', error)
				}
			},
			// 加载分类数据
			async loadCategories() {
				try {
					const data = await productApi.getProductCategoryTree()
					this.categories = data
				} catch (error) {
					console.error('获取分类失败:', error)
				}
			},
			// 加载门店数据
			async loadStores() {
				try {
					const data = await userApi.getStores()
					this.stores = data.map(item => ({
						value: item.id,
						text: item.name
					}))
				} catch (error) {
					console.error('获取门店失败:', error)
				}
			}
		},
		mounted(options) {
			this.loadCategories()
			this.loadStores()
		},
		onLoad: function (options) {
			this.loadProduct(options.id)
		}
	}
</script>

<style lang="scss" scoped>
	.detail-product-page {
		min-height: 100vh;
		background-color: #f5f5f5;
		display: flex;
		flex-direction: column;
	}
</style>