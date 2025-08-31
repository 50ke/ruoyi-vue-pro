package cn.iocoder.boot.yudao.module.courier.controller.app.auth;

import cn.hutool.core.util.StrUtil;
import cn.iocoder.boot.yudao.module.courier.controller.app.auth.vo.AppAuthLoginRespVO;
import cn.iocoder.boot.yudao.module.courier.controller.app.auth.vo.AppAuthWeixinMiniAppLoginReqVO;
import cn.iocoder.boot.yudao.module.courier.service.auth.CourierAuthService;
import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.security.config.SecurityProperties;
import cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.annotation.security.PermitAll;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;

@Tag(name = "配送员 APP - 认证")
@RestController
@RequestMapping("/courier/auth")
@Validated
@Slf4j
public class AppAuthController {

    @Resource
    private CourierAuthService authService;

    @Resource
    private SecurityProperties securityProperties;

    @PostMapping("/weixin-mini-app-login")
    @Operation(summary = "微信小程序的一键登录")
    @PermitAll
    public CommonResult<AppAuthLoginRespVO> weixinMiniAppLogin(@RequestBody @Valid AppAuthWeixinMiniAppLoginReqVO reqVO) {
        return success(authService.weixinMiniAppLogin(reqVO));
    }

    @PostMapping("/logout")
    @Operation(summary = "登出系统")
    @PermitAll
    public CommonResult<Boolean> logout(HttpServletRequest request) {
        String token = SecurityFrameworkUtils.obtainAuthorization(request, securityProperties.getTokenHeader(), securityProperties.getTokenParameter());
        if (StrUtil.isNotBlank(token)) {
            authService.logout(token);
        }
        return success(true);
    }

    @PostMapping("/refresh-token")
    @Operation(summary = "刷新令牌")
    @Parameter(name = "refreshToken", description = "刷新令牌", required = true)
    @PermitAll
    public CommonResult<AppAuthLoginRespVO> refreshToken(@RequestParam("refreshToken") String refreshToken) {
        return success(authService.refreshToken(refreshToken));
    }
}
