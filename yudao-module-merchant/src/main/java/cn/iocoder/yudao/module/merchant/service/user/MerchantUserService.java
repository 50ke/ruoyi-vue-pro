package cn.iocoder.yudao.module.merchant.service.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantStoreRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserUpdateReqVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;

import java.util.List;

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

    /**
     * 【商户】查询门店
     * @param loginUserId 商户ID
     * @return 门店列表
     */
    List<AppMerchantStoreRespVO> getStores(Long loginUserId);

    /**
     * 【商户】查询门店配送员
     * @param loginUserId 商户ID
     * @param storeId 门店ID
     * @return 配送员列表
     */
    List<AppMerchantCourierRespVO> getStoreCouriers(Long loginUserId, Long storeId);

    /**
     * 【商户】查询所有配送员
     * @param loginUserId 商户ID
     * @return 配送员列表
     */
    List<AppMerchantCourierRespVO> getCouriers(Long loginUserId);
}
