package cn.iocoder.yudao.module.merchant.enums;

import cn.iocoder.yudao.framework.common.exception.ErrorCode;

/**
 * merchant 错误码枚举类
 * <p>
 * 模块 merchant 错误码区间 [1-026-000-000 ~ 1-027-000-000)
 */
public interface ErrorCodeConstants {
    ErrorCode USER_MOBILE_NOT_EXISTS = new ErrorCode(1_024_001_000, "手机号未注册用户，请联系管理员！");
    ErrorCode AUTH_LOGIN_USER_DISABLED = new ErrorCode(1_024_001_001, "登录失败，账号被禁用");
}
