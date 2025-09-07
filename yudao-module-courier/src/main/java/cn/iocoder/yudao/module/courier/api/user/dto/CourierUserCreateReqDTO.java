package cn.iocoder.yudao.module.courier.api.user.dto;

import lombok.Data;

import java.util.List;

@Data
public class CourierUserCreateReqDTO {

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
     * 商户ID
     */
    private Long merchantId;

    /**
     * 门店ID
     */
    private List<Long> storeId;
}
