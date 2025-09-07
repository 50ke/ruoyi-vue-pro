package cn.iocoder.yudao.module.merchant.convert.auth;

import cn.iocoder.yudao.module.merchant.controller.app.auth.vo.AppAuthLoginRespVO;
import cn.iocoder.yudao.framework.common.biz.system.oauth2.dto.OAuth2AccessTokenRespDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AuthConvert {

    AuthConvert INSTANCE = Mappers.getMapper(AuthConvert.class);

    AppAuthLoginRespVO convert(OAuth2AccessTokenRespDTO bean, String openid);
}
