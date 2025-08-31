package cn.iocoder.yudao.module.courier.enums;

import cn.iocoder.yudao.framework.common.core.ArrayValuable;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

/**
 * 配送状态枚举
 *
 * @author 芋道源码
 */
@Getter
@AllArgsConstructor
public enum CourierDeliveryStatusEnum implements ArrayValuable<Integer> {

    PENDING(1, "待配送"),
    DELIVERING(2, "配送中"),
    DELIVERED(3, "已送达"),
    CANCELLED(4, "已取消");

    public static final Integer[] ARRAYS = Arrays.stream(values()).map(CourierDeliveryStatusEnum::getStatus).toArray(Integer[]::new);

    /**
     * 配送状态
     */
    private final Integer status;
    /**
     * 状态名
     */
    private final String name;

    @Override
    public Integer[] array() {
        return ARRAYS;
    }

}
