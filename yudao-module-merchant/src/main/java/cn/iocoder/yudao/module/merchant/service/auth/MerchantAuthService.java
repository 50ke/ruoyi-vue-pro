package cn.iocoder.yudao.module.merchant.service.auth;

import cn.iocoder.yudao.module.merchant.controller.app.auth.vo.AppAuthLoginRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.auth.vo.AppAuthWeixinMiniAppLoginReqVO;
import jakarta.validation.Valid;

/**
 * 商户认证 Service 接口
 *
 * @author 芋道源码
 */
public interface MerchantAuthService {

    /**
     * 商户登录
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
