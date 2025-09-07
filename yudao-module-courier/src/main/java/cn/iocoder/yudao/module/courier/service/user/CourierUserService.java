package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;

/**
 * 配送员用户 Service 接口
 *
 * @author 芋道源码
 */
public interface CourierUserService {

    /**
     * 通过用户 ID 查询用户
     *
     * @param id 用户ID
     * @return 用户对象信息
     */
    CourierUserDO getUser(Long id);

    /**
     * 通过手机号获取用户
     * @param mobile 手机号
     * @return 用户对象信息
     */
    CourierUserDO getByMobile(String mobile);

    /**
     * 【配送员】修改基本信息
     *
     * @param userId 用户编号
     * @param reqVO  基本信息
     */
    void updateUser(Long userId, AppCourierUserUpdateReqVO reqVO);
}
