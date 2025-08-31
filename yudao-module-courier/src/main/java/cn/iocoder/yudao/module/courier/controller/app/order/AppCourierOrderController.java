package cn.iocoder.yudao.module.courier.controller.app.order;

import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderUpdateReqVO;
import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderPageReqVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderRespVO;
import cn.iocoder.yudao.module.courier.controller.app.order.vo.AppOrderDetailRespVO;
import cn.iocoder.yudao.module.courier.service.order.CourierOrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;

@Tag(name = "配送员 - 订单管理")
@RestController
@RequestMapping("/courier/order")
@Validated
@Slf4j
public class AppCourierOrderController {

    @Resource
    private CourierOrderService courierOrderService;

    @GetMapping("/page")
    @Operation(summary = "获得配送订单分页")
    public CommonResult<PageResult<AppOrderRespVO>> getOrderPage(@Valid AppOrderPageReqVO reqVO) {
        return success(courierOrderService.getOrderPage(reqVO));
    }

    @GetMapping("/get/{id}")
    @Operation(summary = "获得配送订单详情")
    @Parameter(name = "id", description = "配送订单编号", required = true)
    public CommonResult<AppOrderDetailRespVO> getOrderDetail(@PathVariable Long id) {
        return success(courierOrderService.getOrderDetail(id));
    }

    @PostMapping("/update")
    @Operation(summary = "更新配送订单")
    public CommonResult<Boolean> updateOrder(@Valid @RequestBody AppOrderUpdateReqVO reqVO) {
        return success(courierOrderService.updateOrder(reqVO));
    }
}
