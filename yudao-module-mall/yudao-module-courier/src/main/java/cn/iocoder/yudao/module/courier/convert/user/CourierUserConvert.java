package cn.iocoder.yudao.module.courier.convert.user;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserRespVO;
import cn.iocoder.yudao.module.courier.controller.app.user.vo.AppCourierUserRespVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 配送员用户 Convert
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierUserConvert {

    CourierUserConvert INSTANCE = Mappers.getMapper(CourierUserConvert.class);

    CourierUserRespVO convert(CourierUserDO bean);

    List<CourierUserRespVO> convertList(List<CourierUserDO> list);

    PageResult<CourierUserRespVO> convertPage(PageResult<CourierUserDO> page);

    AppCourierUserRespVO convertApp(CourierUserDO bean);

} 