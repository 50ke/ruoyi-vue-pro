# 配送员模块

## 功能概述

配送员模块主要实现配送员相关的功能，包括：

1. **配送员用户管理**：配送员的增删改查、状态管理
2. **配送员认证登录**：用户名密码登录、短信验证码登录、忘记密码等
3. **配送员工作状态管理**：休息中、空闲、配送中等状态切换

## 数据库表

### courier_user 配送员用户表

| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | bigint | 配送员ID（主键） |
| username | varchar(45) | 用户名 |
| password | varchar(100) | 加密后的密码 |
| nickname | varchar(45) | 配送员昵称 |
| avatar | varchar(255) | 配送员头像URL |
| mobile | varchar(45) | 手机号码 |
| score | decimal(3,1) | 评分（1-5分，保留一位小数） |
| status | int | 账号状态 (枚举 CommonStatusEnum) |
| work_status | int | 工作状态（0-休息中，1-空闲，2-配送中） |
| login_ip | varchar(45) | 最后登录IP |
| login_date | datetime | 最后登录时间 |
| create_time | datetime | 创建时间 |
| update_time | datetime | 最后更新时间 |
| creator | varchar(255) | 创建者 |
| updater | varchar(255) | 更新者 |
| deleted | tinyint(1) | 是否删除 |
| tenant_id | bigint | 租户编号 |

## 主要接口

### APP端接口

#### 认证相关
- `POST /courier/auth/login` - 用户名密码登录
- `POST /courier/auth/logout` - 登出系统
- `POST /courier/auth/refresh-token` - 刷新令牌
- `POST /courier/auth/sms-login` - 短信验证码登录
- `POST /courier/auth/send-sms-code` - 发送短信验证码
- `POST /courier/auth/validate-sms-code` - 校验短信验证码
- `POST /courier/auth/reset-password` - 重置密码

#### 用户相关
- `GET /courier/user/get` - 获得配送员用户详情
- `PUT /courier/user/update-work-status` - 更新配送员工作状态

### 管理后台接口

#### 用户管理
- `GET /courier/user/get` - 获得配送员用户
- `GET /courier/user/page` - 获得配送员用户分页
- `PUT /courier/user/update` - 更新配送员用户
- `DELETE /courier/user/delete` - 删除配送员用户
- `PUT /courier/user/update-work-status` - 更新配送员工作状态

## 工作状态说明

- `0` - 休息中：配送员暂时不接单
- `1` - 空闲：配送员可以接单
- `2` - 配送中：配送员正在配送订单

## 使用示例

### 1. 配送员登录
```bash
curl -X POST "http://localhost:48080/courier/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "courier001",
    "password": "123456"
  }'
```

### 2. 更新工作状态
```bash
curl -X PUT "http://localhost:48080/courier/user/update-work-status?workStatus=1" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## 注意事项

1. 配送员模块需要依赖系统模块的短信服务
2. 配送员登录使用独立的用户类型 `LoginUser.TYPE_COURIER`
3. 配送员密码使用 BCrypt 加密存储
4. 配送员评分默认为 5.0 分
5. 配送员工作状态默认为休息中（0） 