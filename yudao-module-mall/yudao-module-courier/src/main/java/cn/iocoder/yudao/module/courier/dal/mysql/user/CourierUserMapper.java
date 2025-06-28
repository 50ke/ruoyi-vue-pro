package cn.iocoder.yudao.module.courier.dal.mysql.user;

import cn.hutool.core.util.StrUtil;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.courier.controller.admin.user.vo.CourierUserPageReqVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 配送员 User Mapper
 *
 * @author 芋道源码
 */
@Mapper
public interface CourierUserMapper extends BaseMapperX<CourierUserDO> {

    default CourierUserDO selectByUsername(String username) {
        return selectOne(CourierUserDO::getUsername, username);
    }

    default CourierUserDO selectByMobile(String mobile) {
        return selectOne(CourierUserDO::getMobile, mobile);
    }

    default List<CourierUserDO> selectListByNicknameLike(String nickname) {
        return selectList(new LambdaQueryWrapperX<CourierUserDO>()
                .likeIfPresent(CourierUserDO::getNickname, nickname));
    }

    default PageResult<CourierUserDO> selectPage(CourierUserPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<CourierUserDO>()
                .likeIfPresent(CourierUserDO::getUsername, reqVO.getUsername())
                .likeIfPresent(CourierUserDO::getMobile, reqVO.getMobile())
                .likeIfPresent(CourierUserDO::getNickname, reqVO.getNickname())
                .eqIfPresent(CourierUserDO::getStatus, reqVO.getStatus())
                .eqIfPresent(CourierUserDO::getWorkStatus, reqVO.getWorkStatus())
                .betweenIfPresent(CourierUserDO::getLoginDate, reqVO.getLoginDate())
                .betweenIfPresent(CourierUserDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(CourierUserDO::getId));
    }

} 