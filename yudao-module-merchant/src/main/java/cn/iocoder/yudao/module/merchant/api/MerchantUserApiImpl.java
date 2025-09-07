package cn.iocoder.yudao.module.merchant.api;

import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.merchant.api.dto.MerchantUserUpdateReqDTO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import cn.iocoder.yudao.module.merchant.service.user.MerchantUserService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Slf4j
@Service
@Validated
public class MerchantUserApiImpl implements MerchantUserApi{

    @Resource
    private MerchantUserService merchantUserService;

    @Override
    public void updateMerchantUser(MerchantUserUpdateReqDTO reqDTO) {
        MerchantUserDO merchantUserDO = BeanUtils.toBean(reqDTO, MerchantUserDO.class);
        merchantUserService.updateUserById(merchantUserDO);
    }
}
