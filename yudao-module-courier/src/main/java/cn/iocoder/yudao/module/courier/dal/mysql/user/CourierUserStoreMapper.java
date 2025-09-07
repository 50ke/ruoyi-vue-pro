package cn.iocoder.yudao.module.courier.dal.mysql.user;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserStoreDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 配送员和门店关联 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierUserStoreMapper extends BaseMapperX<CourierUserStoreDO> {

}
