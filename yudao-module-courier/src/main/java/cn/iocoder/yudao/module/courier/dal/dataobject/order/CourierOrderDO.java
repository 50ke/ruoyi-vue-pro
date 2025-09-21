package cn.iocoder.yudao.module.courier.dal.dataobject.order;

import cn.iocoder.yudao.module.courier.enums.CourierDeliveryStatusEnum;
import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.time.LocalDateTime;

/**
 * 配送订单 DO
 *
 * @author 芋道源码
 */
@TableName("courier_order")
@KeySequence("courier_order_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourierOrderDO extends TenantBaseDO {

    /**
     * 配送订单编号
     */
    @TableId
    private Long id;

    /**
     * 配送员编号
     */
    private Long courierId;

    /**
     * 订单编号
     */
    private Long orderId;

    /**
     * 配送状态
     * 枚举 {@link CourierDeliveryStatusEnum}
     */
    private Integer deliveryStatus;

    /**
     * 取货时间
     */
    private LocalDateTime pickupTime;

    /**
     * 送达时间
     */
    private LocalDateTime deliveryTime;

}
