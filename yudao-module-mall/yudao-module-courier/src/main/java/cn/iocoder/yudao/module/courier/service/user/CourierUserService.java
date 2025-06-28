package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserPageReqVO;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserRespVO;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserUpdateReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;

import jakarta.validation.Valid;

/**
 * 配送员用户 Service 接口
 *
 * @author 芋道源码
 */
public interface CourierUserService {

    /**
     * 创建配送员用户
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    Long createUser(@Valid CourierUserDO createReqVO);

    /**
     * 更新配送员用户
     *
     * @param updateReqVO 更新信息
     */
    void updateUser(@Valid CourierUserUpdateReqVO updateReqVO);

    /**
     * 删除配送员用户
     *
     * @param id 编号
     */
    void deleteUser(Long id);

    /**
     * 获得配送员用户
     *
     * @param id 编号
     * @return 配送员用户
     */
    CourierUserDO getUser(Long id);

    /**
     * 获得配送员用户分页
     *
     * @param pageReqVO 分页查询
     * @return 配送员用户分页
     */
    PageResult<CourierUserDO> getUserPage(CourierUserPageReqVO pageReqVO);

    /**
     * 通过用户名获取配送员用户
     *
     * @param username 用户名
     * @return 配送员用户
     */
    CourierUserDO getUserByUsername(String username);

    /**
     * 通过手机号获取配送员用户
     *
     * @param mobile 手机号
     * @return 配送员用户
     */
    CourierUserDO getUserByMobile(String mobile);

    /**
     * 更新配送员用户登录信息
     *
     * @param id 配送员编号
     * @param loginIp 登录IP
     */
    void updateUserLogin(Long id, String loginIp);

    /**
     * 更新配送员用户密码
     *
     * @param id 配送员编号
     * @param password 新密码
     */
    void updateUserPassword(Long id, String password);

    /**
     * 更新配送员工作状态
     *
     * @param id 配送员编号
     * @param workStatus 工作状态
     */
    void updateUserWorkStatus(Long id, Integer workStatus);

    /**
     * 校验密码是否匹配
     *
     * @param rawPassword 原始密码
     * @param encodedPassword 加密后的密码
     * @return 是否匹配
     */
    boolean isPasswordMatch(String rawPassword, String encodedPassword);

} 