package cn.iocoder.yudao.module.courier.api.user.dto;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.module.courier.enums.CourierWorkStatusEnum;
import lombok.Data;

@Data
public class CourierUserRespDTO {

    /**
     * 配送员编号
     */
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
     * 商户ID
     */
    private Long merchantId;

    /**
     * 门店ID
     */
    private Long storeId;

    /**
     * 工作状态
     * 枚举 {@link CourierWorkStatusEnum}
     */
    private Integer workStatus;
}
