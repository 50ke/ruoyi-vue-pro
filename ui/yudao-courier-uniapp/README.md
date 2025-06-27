# 安泉到家 - 配送员客户端小程序

## 项目简介

安泉到家是一个专注于矿泉水配送的在线商城系统，这是配送员端的小程序客户端。项目采用泉水蓝色配色方案，体现清甜泉水的品牌特色。

## 优化内容

### 1. 泉水蓝色配色方案

项目采用了统一的泉水蓝色配色方案，主要包含：

- **主蓝色** `#2979ff` - 清澈的泉水色
- **次要蓝色** `#94bcff` - 浅泉水色  
- **浅蓝色** `#d4e4ff` - 淡泉水色

### 2. 变量命名优化

优化了所有代码中的变量名称，使其更加可读和规范：

#### 页面组件
- `coupon-page` → `delivery-home-page`
- `searchText` → `searchKeyword`
- `currentStatus` → `currentOrderStatus`
- `goodsList` → `orderList`
- `page` → `currentPage`

#### 数据属性
- `orderNo` → `orderNumber`
- `address` → `deliveryAddress`
- `phone` → `customerPhone`
- `pic` → `productImage`
- `remark` → `customerRemark`

#### 方法名称
- `changeStatus` → `changeOrderStatus`
- `handleGoodsClick` → `navigateToOrderDetail`
- `onRefresh` → `refreshOrderList`
- `loadMore` → `loadMoreOrders`
- `loadList` → `fetchOrderList`

### 3. 企业级应用外观优化

#### 全局样式系统
- 统一的颜色变量管理
- 标准化的间距系统
- 一致的圆角和阴影效果
- 现代化的字体层级

#### 组件优化
- **订单卡片**：清晰的信息层级，状态标签，操作按钮
- **搜索栏**：圆角设计，图标配合
- **状态筛选**：活跃状态指示，平滑过渡
- **用户信息卡片**：渐变背景，统计数据展示
- **快捷功能**：网格布局，图标统一

#### 交互体验
- 按钮点击反馈
- 卡片悬停效果
- 平滑的动画过渡
- 清晰的状态指示

## 技术栈

- **框架**：uni-app
- **样式**：SCSS
- **组件库**：uni-ui
- **图标**：uni-icons

## 项目结构

```
mall-uniapp-courier/
├── App.vue                 # 应用入口
├── uni.scss               # 全局样式变量
├── pages.json             # 页面配置
├── pages/                 # 页面目录
│   ├── index/            # 首页
│   ├── profile/          # 个人中心
│   └── order/            # 订单详情
├── components/           # 组件目录
│   ├── delivery-card.vue # 配送信息卡片
│   ├── goods-list.vue    # 商品列表
│   └── action-buttons.vue # 操作按钮
└── static/              # 静态资源
```

## 主要功能

1. **订单管理**：查看、筛选、搜索订单
2. **配送操作**：确认送达、拨打电话、导航
3. **个人中心**：用户信息、统计数据、快捷功能
4. **订单详情**：商品信息、配送信息、操作按钮

## 设计理念

- **泉水蓝色主题**：体现品牌特色，营造清新舒适的视觉体验
- **企业级设计**：专业的界面设计，提升用户信任度
- **高效操作**：简化的操作流程，提升配送效率
- **响应式交互**：流畅的动画效果，良好的用户体验

## 开发说明

1. 使用HBuilderX打开项目
2. 确保uni-app环境配置正确
3. 运行到微信开发者工具或手机预览
4. 根据实际需求修改API接口

## 版本信息

- **当前版本**：v2.0.0
- **更新日期**：2024年1月
- **主要更新**：泉水蓝色主题、变量命名优化、企业级UI设计