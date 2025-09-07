package cn.iocoder.yudao.module.merchant.dal.mysql.user;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商户用户 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface MerchantUserMapper extends BaseMapperX<MerchantUserDO> {

    default MerchantUserDO selectByMobile(String mobile) {
        return selectOne(MerchantUserDO::getMobile, mobile);
    }

}
