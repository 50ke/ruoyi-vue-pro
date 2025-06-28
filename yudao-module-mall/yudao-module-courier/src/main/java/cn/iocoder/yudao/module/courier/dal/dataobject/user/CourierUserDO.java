package cn.iocoder.yudao.module.courier.dal.dataobject.user;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 配送员用户 DO
 *
 * uk_username 索引：基于 {@link #username} 字段
 * uk_mobile 索引：基于 {@link #mobile} 字段
 *
 * @author 芋道源码
 */
@TableName(value = "courier_user", autoResultMap = true)
@KeySequence("courier_user_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourierUserDO extends TenantBaseDO {

    // ========== 账号信息 ==========

    /**
     * 配送员ID（主键）
     */
    @TableId
    private Long id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 加密后的密码
     *
     * 因为目前使用 {@link BCryptPasswordEncoder} 加密器，所以无需自己处理 salt 盐
     */
    private String password;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 账号状态
     *
     * 枚举 {@link CommonStatusEnum}
     */
    private Integer status;

    /**
     * 最后登录IP
     */
    private String loginIp;

    /**
     * 最后登录时间
     */
    private LocalDateTime loginDate;

    // ========== 基础信息 ==========

    /**
     * 配送员昵称
     */
    private String nickname;

    /**
     * 配送员头像URL
     */
    private String avatar;

    /**
     * 评分（1-5分，保留一位小数）
     */
    private BigDecimal score;

    /**
     * 工作状态（0-休息中，1-空闲，2-配送中）
     */
    private Integer workStatus;

} 