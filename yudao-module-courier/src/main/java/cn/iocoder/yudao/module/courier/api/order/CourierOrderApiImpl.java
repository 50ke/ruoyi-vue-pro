package cn.iocoder.yudao.module.courier.api.order;

import cn.iocoder.yudao.module.courier.service.order.CourierOrderService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Service
@Validated
public class CourierOrderApiImpl implements CourierOrderApi {

    @Resource
    private CourierOrderService courierOrderService;

    @Override
    public Long createCourierOrder(Long courier, Long orderId) {
        return courierOrderService.createOrder(courier, orderId);
    }
}
