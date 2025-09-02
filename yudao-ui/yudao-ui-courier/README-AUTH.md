# 配送员客户端认证流程使用说明

## 概述

本文档介绍了配送员客户端的认证流程实现，基于博客方法二进行重构，提供了完整的认证、权限控制和状态管理功能。

## 核心功能

### 1. 认证管理 (`utils/auth.js`)

- **Token管理**: 自动管理access token和refresh token
- **过期检查**: 提前5分钟自动刷新token
- **用户信息**: 管理用户基本信息和认证状态
- **自动登出**: token失效时自动跳转登录页

### 2. 请求拦截器 (`utils/request.js`)

- **自动认证**: 自动为请求添加Authorization头
- **Token刷新**: 401错误时自动刷新token并重试请求
- **请求队列**: 防止重复刷新token
- **错误处理**: 统一的网络错误和业务错误处理

### 3. 状态管理 (`utils/store.js`)

- **全局状态**: 管理认证状态、用户信息、加载状态等
- **权限检查**: 提供权限和角色检查方法
- **状态同步**: 本地存储与全局状态同步

### 4. 路由守卫 (`utils/router.js`)

- **页面认证**: 自动检查页面是否需要登录
- **权限控制**: 页面级别的权限和角色控制
- **重定向**: 未认证时自动跳转登录页

### 5. 认证中间件 (`utils/middleware.js`)

- **方法装饰器**: 为方法添加认证、权限、角色检查
- **页面检查**: 页面级别的认证状态检查
- **用户状态**: 用户在线状态和工作状态管理

## 使用方法

### 1. 页面认证检查

```javascript
import { checkPageAuth } from '@/utils/middleware.js';

export default {
  async onLoad() {
    try {
      // 检查页面认证状态
      await checkPageAuth();
      // 页面逻辑...
    } catch (error) {
      console.error('认证失败:', error);
    }
  }
}
```

### 2. 方法权限控制

```javascript
import { requirePermission, requireRole } from '@/utils/middleware.js';

export default {
  methods: {
    @requirePermission('order:create')
    createOrder() {
      // 只有有创建订单权限的用户才能执行
    },
    
    @requireRole('admin')
    adminAction() {
      // 只有管理员角色才能执行
    }
  }
}
```

### 3. 获取用户信息

```javascript
import { getCurrentUser, isUserOnline } from '@/utils/middleware.js';

export default {
  methods: {
    getUserInfo() {
      const user = getCurrentUser();
      const isOnline = isUserOnline();
      console.log('用户信息:', user, '在线状态:', isOnline);
    }
  }
}
```

### 4. 更新工作状态

```javascript
import { updateWorkStatus } from '@/utils/middleware.js';

export default {
  methods: {
    toggleWorkStatus(e) {
      const newStatus = e.detail.value ? 1 : 2; // 1:在线 2:离线
      updateWorkStatus(newStatus);
    }
  }
}
```

### 5. 使用全局状态

```javascript
import store from '@/utils/store.js';

export default {
  methods: {
    checkPermission() {
      const state = store.getState();
      if (state.isAuthenticated) {
        const hasPermission = store.hasPermission('order:view');
        console.log('是否有查看订单权限:', hasPermission);
      }
    }
  }
}
```

## API接口

### 认证相关

- `POST /courier/auth/weixin-mini-app-login` - 微信小程序登录
- `POST /courier/auth/refresh-token` - 刷新token
- `POST /courier/auth/logout` - 登出
- `GET /courier/auth/profile` - 获取用户信息
- `PUT /courier/auth/profile` - 更新用户信息

### 状态管理

- `POST /courier/auth/update-work-status` - 更新工作状态
- `POST /courier/auth/update-avatar` - 更新头像
- `POST /courier/auth/bind-mobile` - 绑定手机号

## 配置说明

### 环境配置 (`utils/config.js`)

```javascript
export const baseUrl = 'http://localhost:48080/app-api';
export const tenantId = '1';
export const loginUserType = 'delivery-express';
```

### 认证配置

- **Token过期时间**: 默认提前5分钟刷新
- **自动重试**: 401错误时自动刷新token并重试
- **错误处理**: 统一的错误提示和跳转逻辑

## 最佳实践

### 1. 页面开发

- 在需要认证的页面`onLoad`中使用`checkPageAuth()`
- 使用`@requirePermission`装饰器保护敏感方法
- 通过`store.getState()`获取全局状态

### 2. 错误处理

- 网络错误会自动显示友好提示
- 业务错误会显示后端返回的错误信息
- 认证失败会自动跳转登录页

### 3. 状态同步

- 登录成功后自动更新全局状态
- 用户信息变更时同步更新本地存储
- 登出时自动清理所有状态

### 4. 性能优化

- Token刷新使用队列机制，避免重复请求
- 用户信息优先从本地获取，再同步服务器
- 页面切换时智能检查认证状态

## 注意事项

1. **Token格式**: 确保后端返回的token格式正确
2. **错误码**: 后端需要返回标准的错误码格式
3. **权限配置**: 页面权限需要在后端配置相应的权限标识
4. **状态同步**: 多端登录时需要注意状态同步问题

## 故障排除

### 常见问题

1. **Token刷新失败**: 检查refresh token是否有效
2. **权限检查失败**: 确认用户权限配置是否正确
3. **状态不同步**: 检查本地存储和全局状态是否一致

### 调试方法

- 查看控制台日志了解认证流程
- 使用`store.getState()`检查全局状态
- 检查网络请求的Authorization头是否正确

## 更新日志

- **v1.0.0**: 初始版本，实现基础认证功能
- **v1.1.0**: 增加权限控制和角色管理
- **v1.2.0**: 优化token自动刷新机制
- **v1.3.0**: 增加全局状态管理和中间件支持
