package cn.iocoder.yudao.module.merchant.service.user;

import cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil;
import cn.iocoder.yudao.framework.common.util.collection.CollectionUtils;
import cn.iocoder.yudao.module.courier.api.user.CourierUserApi;
import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserCreateReqDTO;
import cn.iocoder.yudao.module.courier.api.user.dto.CourierUserRespDTO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierCreateReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantCourierRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantStoreRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.user.vo.AppMerchantUserUpdateReqVO;
import cn.iocoder.yudao.module.merchant.convert.store.MerchantStoreConvert;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.user.MerchantUserMapper;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.merchant.enums.ErrorCodeConstants;
import cn.iocoder.yudao.module.trade.api.delivery.TradeDeliveryApi;
import cn.iocoder.yudao.module.trade.api.delivery.dto.TradeDeliveryPickUpStoreRespDTO;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 商户 User Service 实现类
 *
 * @author 芋道源码
 */
@Service
@Valid
@Slf4j
public class MerchantUserServiceImpl implements MerchantUserService {

    @Resource
    private MerchantUserMapper merchantUserMapper;

    @Resource
    private TradeDeliveryApi tradeDeliveryApi;

    @Resource
    private CourierUserApi courierUserApi;

    @Override
    public MerchantUserDO getUser(Long id) {
        return merchantUserMapper.selectById(id);
    }

    @Override
    public MerchantUserDO getByMobile(String mobile) {
        return merchantUserMapper.selectByMobile(mobile);
    }

    @Override
    public void updateUser(Long userId, AppMerchantUserUpdateReqVO reqVO) {
        MerchantUserDO updateObj = BeanUtils.toBean(reqVO, MerchantUserDO.class).setId(userId);
        merchantUserMapper.updateById(updateObj);
    }

    @Override
    public List<AppMerchantStoreRespVO> getStores(Long loginUserId) {
        MerchantUserDO merchantUserDO = merchantUserMapper.selectById(loginUserId);
        if (merchantUserDO == null){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.USER_NOT_EXISTS);
        }
        List<TradeDeliveryPickUpStoreRespDTO> pickUpStoreList = tradeDeliveryApi.getPickUpStoreList(merchantUserDO.getStoreIds());
        return MerchantStoreConvert.INSTANCE.convertList(pickUpStoreList);
    }

    @Override
    public List<AppMerchantCourierRespVO> getStoreCouriers(Long loginUserId, Long storeId) {
        MerchantUserDO merchantUserDO = merchantUserMapper.selectById(loginUserId);
        if (merchantUserDO == null){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.USER_NOT_EXISTS);
        }
        if (!merchantUserDO.getStoreIds().contains(storeId)){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.STORE_NOT_EXISTS);
        }
        List<CourierUserRespDTO> courierUserRespDTOList = courierUserApi.getCourierListByMerchantStoreId(loginUserId, storeId);

        return MerchantStoreConvert.INSTANCE.convertList1(courierUserRespDTOList);
    }

    @Override
    public List<AppMerchantCourierRespVO> getCouriers(Long loginUserId) {
        MerchantUserDO merchantUserDO = merchantUserMapper.selectById(loginUserId);
        if (merchantUserDO == null){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.USER_NOT_EXISTS);
        }
        List<CourierUserRespDTO> courierUserRespDTOList = courierUserApi.getCourierListByMerchantId(loginUserId);
        return MerchantStoreConvert.INSTANCE.convertList1(courierUserRespDTOList);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long createCourier(Long loginUserId, AppMerchantCourierCreateReqVO reqVO) {
        MerchantUserDO merchantUserDO = merchantUserMapper.selectById(loginUserId);
        if (merchantUserDO == null){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.USER_NOT_EXISTS);
        }
        if (CollectionUtils.isNotSub(merchantUserDO.getStoreIds(), reqVO.getStoreIds())){
            throw ServiceExceptionUtil.exception(ErrorCodeConstants.STORE_NOT_EXISTS);
        }
        CourierUserCreateReqDTO reqDTO = new CourierUserCreateReqDTO();
        reqDTO.setMerchantId(loginUserId);
        reqDTO.setStoreId(reqVO.getStoreIds());
        reqDTO.setNickname(reqVO.getNickname());
        reqDTO.setMobile(reqVO.getMobile());
        reqDTO.setAvatar(reqVO.getAvatar());
        return courierUserApi.createCourier(reqDTO);
    }
}
