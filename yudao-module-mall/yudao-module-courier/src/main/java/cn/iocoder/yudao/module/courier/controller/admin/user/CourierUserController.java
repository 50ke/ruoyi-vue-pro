package cn.iocoder.yudao.module.courier.controller.admin.user;

import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.*;
import cn.iocoder.yudao.module.courier.convert.user.CourierUserConvert;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - 配送员用户")
@RestController
@RequestMapping("/courier/user")
@Validated
public class CourierUserController {

    @Resource
    private CourierUserService courierUserService;

    @PutMapping("/update")
    @Operation(summary = "更新配送员用户")
    @PreAuthorize("@ss.hasPermission('courier:user:update')")
    public CommonResult<Boolean> updateUser(@Valid @RequestBody CourierUserUpdateReqVO updateReqVO) {
        courierUserService.updateUser(updateReqVO);
        return success(true);
    }

    @DeleteMapping("/delete")
    @Operation(summary = "删除配送员用户")
    @Parameter(name = "id", description = "编号", required = true)
    @PreAuthorize("@ss.hasPermission('courier:user:delete')")
    public CommonResult<Boolean> deleteUser(@RequestParam("id") Long id) {
        courierUserService.deleteUser(id);
        return success(true);
    }

    @GetMapping("/get")
    @Operation(summary = "获得配送员用户")
    @Parameter(name = "id", description = "编号", required = true, example = "1024")
    @PreAuthorize("@ss.hasPermission('courier:user:query')")
    public CommonResult<CourierUserRespVO> getUser(@RequestParam("id") Long id) {
        CourierUserDO user = courierUserService.getUser(id);
        return success(CourierUserConvert.INSTANCE.convert(user));
    }

    @GetMapping("/page")
    @Operation(summary = "获得配送员用户分页")
    @PreAuthorize("@ss.hasPermission('courier:user:query')")
    public CommonResult<PageResult<CourierUserRespVO>> getUserPage(@Valid CourierUserPageReqVO pageVO) {
        PageResult<CourierUserDO> pageResult = courierUserService.getUserPage(pageVO);
        return success(CourierUserConvert.INSTANCE.convertPage(pageResult));
    }

    @PutMapping("/update-work-status")
    @Operation(summary = "更新配送员工作状态")
    @PreAuthorize("@ss.hasPermission('courier:user:update')")
    public CommonResult<Boolean> updateUserWorkStatus(@RequestParam("id") Long id, @RequestParam("workStatus") Integer workStatus) {
        courierUserService.updateUserWorkStatus(id, workStatus);
        return success(true);
    }

} 