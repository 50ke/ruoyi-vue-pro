package cn.iocoder.boot.yudao.module.courier.dal.mysql.user;

import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.boot.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 配送员用户 Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierUserMapper extends BaseMapperX<CourierUserDO> {

    default CourierUserDO selectByMobile(String mobile) {
        return selectOne(CourierUserDO::getMobile, mobile);
    }

}
