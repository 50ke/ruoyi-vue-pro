package cn.iocoder.yudao.module.courier.convert.user;

import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserInfoRespVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CourierUserConvert {

    CourierUserConvert INSTANCE = Mappers.getMapper(CourierUserConvert.class);

    AppCourierUserInfoRespVO convert(CourierUserDO bean);

}
