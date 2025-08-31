package cn.iocoder.boot.yudao.module.courier.service.auth;

import cn.iocoder.boot.yudao.module.courier.controller.app.auth.vo.*;
import jakarta.validation.Valid;

/**
 * 配送员认证 Service 接口
 *
 * @author 芋道源码
 */
public interface CourierAuthService {

    /**
     * 配送员登录
     *
     * @param reqVO 登录信息
     * @return 登录结果
     */
    AppAuthLoginRespVO weixinMiniAppLogin(@Valid AppAuthWeixinMiniAppLoginReqVO reqVO);

    /**
     * 基于 token 退出登录
     *
     * @param token token
     */
    void logout(String token);


    /**
     * 刷新访问令牌
     *
     * @param refreshToken 刷新令牌
     * @return 登录结果
     */
    AppAuthLoginRespVO refreshToken(String refreshToken);
}
