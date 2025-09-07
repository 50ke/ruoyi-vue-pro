package cn.iocoder.yudao.module.merchant.service.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserUpdateReqVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;

/**
 * 商户用户 Service 接口
 *
 * @author 芋道源码
 */
public interface MerchantUserService {

    /**
     * 通过用户 ID 查询用户
     *
     * @param id 用户ID
     * @return 用户对象信息
     */
    MerchantUserDO getUser(Long id);

    /**
     * 通过手机号获取用户
     * @param mobile 手机号
     * @return 用户对象信息
     */
    MerchantUserDO getByMobile(String mobile);

    /**
     * 【商户】修改基本信息
     *
     * @param userId 用户编号
     * @param reqVO  基本信息
     */
    void updateUser(Long userId, AppMerchantUserUpdateReqVO reqVO);
}
