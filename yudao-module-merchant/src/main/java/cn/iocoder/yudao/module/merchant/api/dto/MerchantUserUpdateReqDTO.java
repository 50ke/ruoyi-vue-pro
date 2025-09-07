package cn.iocoder.yudao.module.merchant.api.dto;

import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import lombok.Data;

import java.util.List;

@Data
public class MerchantUserUpdateReqDTO {

    /**
     * 商户编号
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
     * 门店ID集合（一个商户可能有多个门店）
     */
    private List<Long> storeIds;
}
