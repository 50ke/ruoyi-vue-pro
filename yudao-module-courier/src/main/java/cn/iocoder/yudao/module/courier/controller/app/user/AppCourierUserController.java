package cn.iocoder.yudao.module.courier.controller.app.user;

import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserInfoRespVO;
import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.convert.user.CourierUserConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
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

@Tag(name = "配送员 APP - 用户个人中心")
@RestController
@RequestMapping("/courier/user")
@Validated
@Slf4j
public class AppCourierUserController {

    @Resource
    private CourierUserService userService;

    @GetMapping("/get")
    @Operation(summary = "获得基本信息")
    public CommonResult<AppCourierUserInfoRespVO> getUserInfo() {
        CourierUserDO user = userService.getUser(getLoginUserId());
        return success(CourierUserConvert.INSTANCE.convert(user));
    }

    @PutMapping("/update")
    @Operation(summary = "修改基本信息")
    public CommonResult<Boolean> updateUser(@RequestBody @Valid AppCourierUserUpdateReqVO reqVO) {
        userService.updateUser(getLoginUserId(), reqVO);
        return success(true);
    }
}