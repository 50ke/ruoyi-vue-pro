package cn.iocoder.yudao.module.merchant.service.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserUpdateReqVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.user.MerchantUserMapper;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 商户 User Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Valid
@Slf4j
public class MerchantUserServiceImpl implements MerchantUserService {

    @Resource
    private MerchantUserMapper merchantUserMapper;

    @Override
    public MerchantUserDO getUser(Long id) {
        return merchantUserMapper.selectById(id);
    }

    @Override
    public MerchantUserDO getByMobile(String mobile) {
        return merchantUserMapper.selectByMobile(mobile);
    }

    @Override
    public void updateUser(Long userId, AppMerchantUserUpdateReqVO reqVO) {
        MerchantUserDO updateObj = BeanUtils.toBean(reqVO, MerchantUserDO.class).setId(userId);
        merchantUserMapper.updateById(updateObj);
    }
}
