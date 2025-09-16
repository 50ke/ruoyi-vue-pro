package cn.iocoder.yudao.module.merchant.service.product;

import cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductSaveReqVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.product.MerchantProductSpuDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.product.MerchantProductSpuMapper;
import cn.iocoder.yudao.module.product.api.brand.ProductBrandApi;
import cn.iocoder.yudao.module.product.api.brand.dto.ProductBrandRespDTO;
import cn.iocoder.yudao.module.product.api.spu.ProductSpuApi;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuDetailRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageReqDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuSaveReqDTO;
import cn.iocoder.yudao.module.product.enums.spu.ProductSpuStatusEnum;
import cn.iocoder.yudao.module.trade.enums.delivery.DeliveryTypeEnum;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.Arrays;
import java.util.Collections;

import static cn.iocoder.yudao.module.merchant.enums.ErrorCodeConstants.*;

@Service
@Validated
@Slf4j
public class MerchantProductServiceImpl implements MerchantProductService{

    @Resource
    private ProductSpuApi productSpuApi;

    @Resource
    private ProductBrandApi productBrandApi;

    @Resource
    private MerchantProductSpuMapper merchantProductSpuMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long createProduct(Long loginUserId, AppMerchantProductSaveReqVO createReqVO) {
        ProductSpuSaveReqDTO reqDTO = BeanUtils.toBean(createReqVO, ProductSpuSaveReqDTO.class);
        setProductDefaultValue(reqDTO);
        Long spuId = productSpuApi.createSpu(reqDTO);
        merchantProductSpuMapper.insert(MerchantProductSpuDO.builder().merchantId(loginUserId).spuId(spuId).build());
        return spuId;
    }

    @Override
    public void updateProduct(Long loginUserId, AppMerchantProductSaveReqVO updateReqVO) {
        validateMerchantProductExists(loginUserId, updateReqVO.getId());
        ProductSpuSaveReqDTO reqDTO = BeanUtils.toBean(updateReqVO, ProductSpuSaveReqDTO.class);
        setProductDefaultValue(reqDTO);
        productSpuApi.updateSpu(reqDTO);
    }

    @Override
    public void disableProduct(Long loginUserId, Long id) {
        validateMerchantProductExists(loginUserId, id);
        productSpuApi.updateSpuStatus(id, ProductSpuStatusEnum.DISABLE);
    }

    @Override
    public PageResult<AppMerchantProductRespVO> getProductPage(Long loginUserId, AppMerchantProductPageReqVO pageVO) {
        ProductSpuPageReqDTO pageReqDTO = BeanUtils.toBean(pageVO, ProductSpuPageReqDTO.class);
        PageResult<ProductSpuPageReqDTO> pageRespDTO = productSpuApi.getSpuPage(pageReqDTO);
        return BeanUtils.toBean(pageRespDTO, AppMerchantProductRespVO.class);
    }

    @Override
    public AppMerchantProductRespVO getProductDetail(Long loginUserId, Long spuId) {
        validateMerchantProductExists(loginUserId, spuId);
        ProductSpuDetailRespDTO spuDetailRespDTO = productSpuApi.getSpuDetail(spuId);
        return BeanUtils.toBean(spuDetailRespDTO, AppMerchantProductRespVO.class);
    }

    private void validateMerchantProductExists(Long merchantId, Long spuId){
        boolean exists = merchantProductSpuMapper.exists(new LambdaQueryWrapperX<MerchantProductSpuDO>()
                .eq(MerchantProductSpuDO::getMerchantId, merchantId)
                .eq(MerchantProductSpuDO::getSpuId, spuId));
        if (!exists){
            throw ServiceExceptionUtil.exception(PRODUCT_NOT_EXISTS);
        }
    }

    private void setProductDefaultValue(ProductSpuSaveReqDTO reqDTO){
        ProductBrandRespDTO defaultBrand = productBrandApi.getDefaultBrand();
        if (defaultBrand == null){
            throw ServiceExceptionUtil.exception(PRODUCT_BRAND_NOT_EXISTS);
        }
        reqDTO.setBrandId(defaultBrand.getId());
        reqDTO.setDeliveryTypes(Arrays.stream(DeliveryTypeEnum.ARRAYS).toList());
        reqDTO.setDeliveryTemplateId(null);
    }
}
