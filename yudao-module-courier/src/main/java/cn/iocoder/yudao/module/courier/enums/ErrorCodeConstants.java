package cn.iocoder.yudao.module.courier.enums;

import cn.iocoder.yudao.framework.common.exception.ErrorCode;

/**
 * courier 错误码枚举类
 * <p>
 * 模块 courier 错误码区间 [1-024-000-000 ~ 1-025-000-000)
 */
public interface ErrorCodeConstants {
    ErrorCode USER_MOBILE_NOT_EXISTS = new ErrorCode(1_024_001_000, "手机号未注册用户，请联系管理员！");
    ErrorCode AUTH_LOGIN_USER_DISABLED = new ErrorCode(1_024_001_001, "登录失败，账号被禁用");

    ErrorCode DELIVERY_ORDER_NOT_EXISTS = new ErrorCode(1_024_002_000, "配送订单不存在");
    ErrorCode DELIVERY_ORDER_STATUS_ERROR = new ErrorCode(1_024_002_001, "配送订单状态错误");
}
