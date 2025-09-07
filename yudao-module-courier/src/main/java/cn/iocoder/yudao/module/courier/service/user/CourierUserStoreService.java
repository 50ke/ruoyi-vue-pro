package cn.iocoder.yudao.module.courier.service.user;

import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserStoreDO;

import java.util.List;

public interface CourierUserStoreService {
    void save(List<CourierUserStoreDO> courierUserStoreDOList);
}
