package cn.iocoder.yudao.module.courier.dal.dataobject.user;

import cn.iocoder.yudao.module.courier.enums.CourierWorkStatusEnum;
import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

/**
 * 配送员用户 DO
 *
 * @author 芋道源码
 */
@TableName("courier_user")
@KeySequence("courier_user_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourierUserDO extends TenantBaseDO {

    /**
     * 配送员编号
     */
    @TableId
    private Long id;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 手机号
     */
    private String mobile;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 微信openid
     */
    private String openid;

    /**
     * 帐号状态
     *
     * 枚举 {@link CommonStatusEnum}
     */
    private Integer status;

    /**
     * 商户ID
     */
    private Long merchantId;

    /**
     * 工作状态
     * 枚举 {@link CourierWorkStatusEnum}
     */
    private Integer workStatus;

}
