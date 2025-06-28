package cn.iocoder.yudao.module.courier.enums;

import cn.iocoder.yudao.framework.common.exception.ErrorCode;

/**
 * 配送员模块错误码枚举类
 *
 * 配送员模块，使用 1-020-000-000 段
 */
public interface ErrorCodeConstants {

    // ========== 配送员用户相关 1-015-000-000 ==========
    ErrorCode USER_NOT_EXISTS = new ErrorCode(1_015_000_001, "配送员用户不存在");
    ErrorCode USER_USERNAME_EXISTS = new ErrorCode(1_015_000_002, "配送员用户名已存在");
    ErrorCode USER_USERNAME_NOT_EXISTS = new ErrorCode(1_015_000_003, "配送员用户名不存在");
    ErrorCode USER_MOBILE_EXISTS = new ErrorCode(1_015_000_004, "配送员手机号已存在");
    ErrorCode USER_MOBILE_NOT_EXISTS = new ErrorCode(1_015_000_005, "配送员手机号不存在");

    // ========== 配送员认证相关 1-015-001-000 ==========
    ErrorCode AUTH_LOGIN_BAD_CREDENTIALS = new ErrorCode(1_015_001_000, "登录失败，账号密码不正确");
    ErrorCode AUTH_LOGIN_USER_DISABLED = new ErrorCode(1_015_001_001, "登录失败，账号被禁用");

} 