package cn.iocoder.boot.yudao.module.courier.convert.auth;

import cn.iocoder.boot.yudao.module.courier.controller.app.auth.vo.AppAuthLoginRespVO;
import cn.iocoder.yudao.framework.common.biz.system.oauth2.dto.OAuth2AccessTokenRespDTO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AuthConvert {

    AuthConvert INSTANCE = Mappers.getMapper(AuthConvert.class);

    AppAuthLoginRespVO convert(OAuth2AccessTokenRespDTO bean, String openid);
}
