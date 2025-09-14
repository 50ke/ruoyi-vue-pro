package cn.iocoder.yudao.module.merchant.dal.dataobject.user;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.mybatis.core.type.LongListTypeHandler;
import cn.iocoder.yudao.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.util.List;

/**
 * 商户用户 DO
 *
 * @author 芋道源码
 */
@TableName(value = "merchant_user", autoResultMap = true)
@KeySequence("merchant_user_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MerchantUserDO extends TenantBaseDO {

    /**
     * 商户编号
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
     * 帐号状态
     * 枚举 {@link CommonStatusEnum}
     */
    private Integer status;

    /**
     * 门店ID集合（一个商户可能有多个门店）
     */
    @TableField(typeHandler = LongListTypeHandler.class)
    private List<Long> storeIds;
}
