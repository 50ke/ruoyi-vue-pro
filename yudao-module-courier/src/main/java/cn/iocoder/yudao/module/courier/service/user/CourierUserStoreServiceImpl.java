package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserStoreDO;
import cn.iocoder.yudao.module.courier.dal.mysql.user.CourierUserStoreMapper;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Valid
@Slf4j
public class CourierUserStoreServiceImpl implements CourierUserStoreService{

    @Resource
    private CourierUserStoreMapper courierUserStoreMapper;

    @Override
    public void save(List<CourierUserStoreDO> courierUserStoreDOList) {
        courierUserStoreMapper.insert(courierUserStoreDOList);
    }
}
