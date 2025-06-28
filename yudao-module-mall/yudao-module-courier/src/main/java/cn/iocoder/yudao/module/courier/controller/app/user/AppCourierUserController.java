package cn.iocoder.yudao.module.courier.controller.app.user;

import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils;
import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserRespVO;
import cn.iocoder.yudao.module.courier.convert.user.CourierUserConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;

@Tag(name = "配送员 APP - 配送员用户")
@RestController
@RequestMapping("/courier/user")
@Validated
public class AppCourierUserController {

    @Resource
    private CourierUserService courierUserService;

    @GetMapping("/get")
    @Operation(summary = "获得配送员用户详情")
    public CommonResult<AppCourierUserRespVO> getUser() {
        Long courierId = SecurityFrameworkUtils.getLoginUserId();
        CourierUserDO user = courierUserService.getUser(courierId);
        return success(CourierUserConvert.INSTANCE.convertApp(user));
    }

    @PutMapping("/update-work-status")
    @Operation(summary = "更新配送员工作状态")
    public CommonResult<Boolean> updateUserWorkStatus(@RequestParam("workStatus") Integer workStatus) {
        Long courierId = SecurityFrameworkUtils.getLoginUserId();
        courierUserService.updateUserWorkStatus(courierId, workStatus);
        return success(true);
    }

} 