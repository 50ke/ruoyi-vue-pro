package cn.iocoder.yudao.module.merchant.service.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierCreateReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantStoreRespVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import jakarta.validation.Valid;

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

    /**
     * 创建配送员
     * @param loginUserId 商户ID
     * @param reqVO 配送员信息
     * @return 配送员ID
     */
    Long createCourier(Long loginUserId, @Valid AppMerchantCourierCreateReqVO reqVO);

    /**
     * 根据id更新商户信息
     * @param merchantUserDO 商户信息
     */
    void updateUserById(MerchantUserDO merchantUserDO);
}
