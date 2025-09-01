package cn.iocoder.yudao.module.courier.enums;

import cn.iocoder.yudao.framework.common.core.ArrayValuable;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

/**
 * 配送员工作状态枚举
 *
 * @author 芋道源码
 */
@Getter
@AllArgsConstructor
public enum CourierWorkStatusEnum implements ArrayValuable<Integer> {

    ONLINE(2, "在线"),
    OFFLINE(1, "离线");

    public static final Integer[] ARRAYS = Arrays.stream(values()).map(CourierWorkStatusEnum::getStatus).toArray(Integer[]::new);

    /**
     * 工作状态
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
