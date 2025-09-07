package cn.iocoder.yudao.module.courier.dal.dataobject.user;

import cn.iocoder.yudao.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

/**
 * 配送员和门店关联表 DO
 *
 * @author 芋道源码
 */
@TableName("courier_user_store")
@KeySequence("courier_user_store_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourierUserStoreDO extends TenantBaseDO {

    /**
     * 配送员编号
     */
    @TableId
    private Long id;

    /**
     * 配送员编号
     */
    private Long courierId;

    /**
     * 商户ID
     */
    private Long merchantId;

    /**
     * 门店ID
     */
    private Long storeId;
}
