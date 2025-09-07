package cn.iocoder.yudao.module.merchant.controller.app.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserInfoRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserUpdateReqVO;
import cn.iocoder.yudao.module.merchant.convert.user.MerchantUserConvert;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import cn.iocoder.yudao.module.merchant.service.user.MerchantUserService;
import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;
import static cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils.getLoginUserId;

@Tag(name = "商户 APP - 用户个人中心")
@RestController
@RequestMapping("/merchant/user")
@Validated
@Slf4j
public class AppMerchantUserController {

    @Resource
    private MerchantUserService userService;

    @GetMapping("/get")
    @Operation(summary = "获得基本信息")
    public CommonResult<AppMerchantUserInfoRespVO> getUserInfo() {
        MerchantUserDO user = userService.getUser(getLoginUserId());
        return success(MerchantUserConvert.INSTANCE.convert(user));
    }

    @PutMapping("/update")
    @Operation(summary = "修改基本信息")
    public CommonResult<Boolean> updateUser(@RequestBody @Valid AppMerchantUserUpdateReqVO reqVO) {
        userService.updateUser(getLoginUserId(), reqVO);
        return success(true);
    }
}