package cn.iocoder.yudao.module.merchant.convert.user;

import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserInfoRespVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MerchantUserConvert {

    MerchantUserConvert INSTANCE = Mappers.getMapper(MerchantUserConvert.class);

    AppMerchantUserInfoRespVO convert(MerchantUserDO bean);

}
