package cn.iocoder.yudao.module.courier.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 配送员工作状态枚举
 *
 * @author 芋道源码
 */
@AllArgsConstructor
@Getter
public enum CourierWorkStatusEnum {

    REST(0, "休息中"),
    IDLE(1, "空闲"),
    DELIVERING(2, "配送中");

    /**
     * 状态值
     */
    private final Integer status;
    /**
     * 状态名
     */
    private final String name;

} 