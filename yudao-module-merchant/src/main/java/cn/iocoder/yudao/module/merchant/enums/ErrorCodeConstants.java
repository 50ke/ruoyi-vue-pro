package cn.iocoder.yudao.module.merchant.enums;

import cn.iocoder.yudao.framework.common.exception.ErrorCode;

/**
 * merchant 错误码枚举类
 * <p>
 * 模块 merchant 错误码区间 [1-026-000-000 ~ 1-027-000-000)
 */
public interface ErrorCodeConstants {
    ErrorCode AUTH_LOGIN_USER_DISABLED = new ErrorCode(1_024_001_000, "登录失败，账号被禁用");

    ErrorCode USER_MOBILE_NOT_EXISTS = new ErrorCode(1_024_002_000, "手机号未注册用户，请联系管理员！");
    ErrorCode USER_NOT_EXISTS = new ErrorCode(1_024_002_001, "用户不存在");

    ErrorCode STORE_NOT_EXISTS = new ErrorCode(1_024_003_000, "门店不存在");
}
