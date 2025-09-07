package cn.iocoder.yudao.module.courier.convert.user;

import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;
import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserInfoRespVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface CourierUserConvert {

    CourierUserConvert INSTANCE = Mappers.getMapper(CourierUserConvert.class);

    AppCourierUserInfoRespVO convert(CourierUserDO bean);

    List<CourierUserRespDTO> convertList(List<CourierUserDO> courierUserDOList);
}
