<template>
	<view class="add-product-page">
		<view>
			<uni-section title="商品信息" type="line" padding style="height: calc(100vh - 100px);">
				<uni-forms>
					<uni-forms-item label="商品名称" required>
						<uni-easyinput v-model="product.name" placeholder="请输入商品名称" />
					</uni-forms-item>
					<uni-forms-item label="商品分类" required>
						<uni-data-picker placeholder="请选择商品分类" popup-title="商品分类" v-model="product.categoryId" :localdata="categories" />
					</uni-forms-item>
					<uni-forms-item label="上架门店" required>
						<uni-data-select v-model="product.storeId" multiple wrap :localdata="stores" />
					</uni-forms-item>
					<uni-forms-item label="商品关键字" required>
						<uni-easyinput v-model="product.keyword" placeholder="请输入商品关键字" />
					</uni-forms-item>
					<uni-forms-item label="商品简介" required>
						<uni-easyinput type="textarea" v-model="product.introduction" placeholder="请输入商品简介" />
					</uni-forms-item>
					<uni-forms-item label="商品详情" required>
						<uni-easyinput type="textarea" v-model="product.description" placeholder="请输入商品详情" />
					</uni-forms-item>
					<uni-forms-item label="商品封面图" required>
						<uni-file-picker
							limit=1
							return-type=object
							file-mediatype="image"
							@select="onProductMainPicSelect"
							@delete="onProductMainPicDelete"/>
					</uni-forms-item>
					<uni-forms-item label="商品轮播图" required>
						<uni-file-picker
							limit=5
							file-mediatype="image"
							@select="onProductSlidePicListSelect"
							@delete="onProductSlidePicListDelete"/>
					</uni-forms-item>
					<uni-forms-item label="商品条码" required>
						<uni-easyinput v-model="product.barCode" placeholder="请输入商品条码" />
					</uni-forms-item>
					<uni-forms-item label="商品价格(分)" required>
						<uni-easyinput type="number" v-model="product.price" placeholder="请输入商品价格" />
					</uni-forms-item>
					<uni-forms-item label="商品库存" required>
						<uni-easyinput type="number" v-model="product.stock" placeholder="请输入商品库存" />
					</uni-forms-item>
				</uni-forms>
				<button type="primary" size="mini" @click="confirm">确定</button>
				<button type="primary" size="mini" @click="cancel">取消</button>
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
			}
		},
		methods: {
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
			},
			async onProductMainPicSelect(e){
				try{
					const url = await infraApi.uploadFile(e.tempFilePaths[0])
					this.product.picUrl = url;
				}catch(error){
					console.error('商品封面图上传失败:', error)
					uni.showToast({
						title: '商品封面图上传失败',
						icon: 'none'
					})
				}
			},
			async onProductMainPicDelete(e){
				this.product.picUrl = '';
			},
			async onProductSlidePicListSelect(e){
				for(const index in e.tempFilePaths){
					try {
						const url = await infraApi.uploadFile(e.tempFilePaths[index])
						this.product.sliderPicUrls.push(url);
					} catch (error) {
						console.error('商品轮播图上传失败:', error)
						uni.showToast({
							title: '商品轮播图上传失败',
							icon: 'none'
						})
					}
				}
			},
			async onProductSlidePicListDelete(e){
				this.product.sliderPicUrls.splice(e.index, 1)
			},
			confirm(){
				try{
					const params = {
						...this.product,
						sort: 1,
						skus:[{
								name: this.product.name,
								price: this.product.price,
								marketPrice: this.product.price,
								costPrice: this.product.price,
								barCode: this.product.barCode,
								picUrl: this.product.picUrl,
								stock: this.product.stock,
								weight: 1.0,
								volume: 1.0,
								properties: []
							}]
					}
					const res = productApi.createProduct(params);
					uni.showToast({
						title: '商品添加成功',
						icon: 'success'
					})
					setTimeout(() => {
						uni.navigateBack({delta: 1});
					}, 800)
				}catch (error) {
					console.error('商品添加失败:', error)
					uni.showToast({
						title: '商品添加失败',
						icon: 'none'
					})
				}
			},
			cancel(){
				uni.navigateBack({delta: 1});
			}
		},
		mounted() {
			this.loadCategories()
			this.loadStores()
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
</style>