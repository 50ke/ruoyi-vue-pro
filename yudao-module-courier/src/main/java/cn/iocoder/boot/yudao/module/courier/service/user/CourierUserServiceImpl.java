package cn.iocoder.boot.yudao.module.courier.service.user;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.iocoder.boot.yudao.module.courier.controller.app.user.vo.AppCourierUserUpdateReqVO;
import cn.iocoder.boot.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.boot.yudao.module.courier.dal.mysql.user.CourierUserMapper;
import cn.iocoder.yudao.framework.common.enums.CommonStatusEnum;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 配送员 User Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Valid
@Slf4j
public class CourierUserServiceImpl implements CourierUserService {

    @Resource
    private CourierUserMapper courierUserMapper;

    @Override
    public CourierUserDO getUser(Long id) {
        return courierUserMapper.selectById(id);
    }

    @Override
    public CourierUserDO createUserIfAbsent(String mobile, String registerIp, Integer terminal) {
        // 用户已经存在
        CourierUserDO user = courierUserMapper.selectByMobile(mobile);
        if (user != null) {
            return user;
        }
        // 用户不存在，则进行创建
        return createUser(mobile, null, null, registerIp, terminal);
    }

    @Override
    public void updateUser(Long userId, AppCourierUserUpdateReqVO reqVO) {
        CourierUserDO updateObj = BeanUtils.toBean(reqVO, CourierUserDO.class).setId(userId);
        courierUserMapper.updateById(updateObj);
    }

    private CourierUserDO createUser(String mobile, String nickname, String avtar,
                                    String registerIp, Integer terminal) {
        // 生成密码
        String password = IdUtil.fastSimpleUUID();
        // 插入用户
        CourierUserDO user = new CourierUserDO();
        user.setMobile(mobile);
        user.setStatus(CommonStatusEnum.ENABLE.getStatus()); // 默认开启
        user.setNickname(nickname).setAvatar(avtar); // 基础信息
        if (StrUtil.isEmpty(nickname)) {
            // 昵称为空时，随机一个名字，避免一些依赖 nickname 的逻辑报错，或者有点丑。例如说，短信发送有昵称时~
            user.setNickname("用户" + RandomUtil.randomNumbers(6));
        }
        courierUserMapper.insert(user);
        return user;
    }
}
