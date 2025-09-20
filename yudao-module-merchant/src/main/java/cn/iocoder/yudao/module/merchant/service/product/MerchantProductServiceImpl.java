package cn.iocoder.yudao.module.merchant.service.product;

import cn.hutool.core.collection.CollUtil;
import cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductSaveReqVO;
import cn.iocoder.yudao.module.merchant.convert.product.MerchantProductConvert;
import cn.iocoder.yudao.module.merchant.dal.dataobject.product.MerchantStoreProductSpuDO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.user.MerchantUserDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.product.MerchantStoreProductSpuMapper;
import cn.iocoder.yudao.module.merchant.service.user.MerchantUserService;
import cn.iocoder.yudao.module.product.api.brand.ProductBrandApi;
import cn.iocoder.yudao.module.product.api.brand.dto.ProductBrandRespDTO;
import cn.iocoder.yudao.module.product.api.sku.ProductSkuApi;
import cn.iocoder.yudao.module.product.api.sku.dto.ProductSkuRespDTO;
import cn.iocoder.yudao.module.product.api.spu.ProductSpuApi;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuDetailRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageReqDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageRespDTO;
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
import java.util.List;

import static cn.iocoder.yudao.module.merchant.enums.ErrorCodeConstants.*;

@Service
@Validated
@Slf4j
public class MerchantProductServiceImpl implements MerchantProductService{

    @Resource
    private ProductSpuApi productSpuApi;

    @Resource
    private ProductSkuApi productSkuApi;

    @Resource
    private ProductBrandApi productBrandApi;

    @Resource
    private MerchantUserService merchantUserService;

    @Resource
    private MerchantStoreProductSpuMapper merchantStoreProductSpuMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long createProduct(Long loginUserId, AppMerchantProductSaveReqVO createReqVO) {
        validateMerchantStore(loginUserId, createReqVO.getStoreId());

        ProductSpuSaveReqDTO reqDTO = BeanUtils.toBean(createReqVO, ProductSpuSaveReqDTO.class);
        setProductDefaultValue(reqDTO);
        Long spuId = productSpuApi.createSpu(reqDTO);

        List<MerchantStoreProductSpuDO> merchantStoreProductSpuDOList = createReqVO.getStoreId().stream().map(e -> MerchantStoreProductSpuDO.builder().merchantId(loginUserId).storeId(e).spuId(spuId).build()).toList();
        merchantStoreProductSpuMapper.insertBatch(merchantStoreProductSpuDOList);
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
        pageReqDTO.setMerchantId(loginUserId);
        PageResult<ProductSpuPageRespDTO> pageRespDTO = productSpuApi.getSpuPage(pageReqDTO);
        return BeanUtils.toBean(pageRespDTO, AppMerchantProductRespVO.class);
    }

    @Override
    public AppMerchantProductRespVO getProductDetail(Long loginUserId, Long spuId) {
        validateMerchantProductExists(loginUserId, spuId);
        ProductSpuDetailRespDTO spuDetailRespDTO = productSpuApi.getSpuDetail(spuId);
        List<ProductSkuRespDTO> skuRespDTOS = productSkuApi.getSkuListBySpuId(Collections.singletonList(spuId));
        List<MerchantStoreProductSpuDO> merchantStoreProductSpuDOList = merchantStoreProductSpuMapper.selectList(new LambdaQueryWrapperX<MerchantStoreProductSpuDO>().eq(MerchantStoreProductSpuDO::getMerchantId, loginUserId).eq(MerchantStoreProductSpuDO::getSpuId, spuId));
        return MerchantProductConvert.INSTANCE.convert(spuDetailRespDTO, skuRespDTOS, merchantStoreProductSpuDOList.stream().map(MerchantStoreProductSpuDO::getStoreId).toList());
    }

    private void validateMerchantProductExists(Long merchantId, Long spuId){
        boolean exists = merchantStoreProductSpuMapper.exists(new LambdaQueryWrapperX<MerchantStoreProductSpuDO>()
                .eq(MerchantStoreProductSpuDO::getMerchantId, merchantId)
                .eq(MerchantStoreProductSpuDO::getSpuId, spuId));
        if (!exists){
            throw ServiceExceptionUtil.exception(PRODUCT_NOT_EXISTS);
        }
    }

    private void validateMerchantStore(Long merchantId, List<Long> storeIdList){
        MerchantUserDO user = merchantUserService.getUser(merchantId);
        if (user == null){
            throw ServiceExceptionUtil.exception(USER_NOT_EXISTS);
        }
        if (!CollUtil.containsAll(user.getStoreIds(), storeIdList)){
            throw ServiceExceptionUtil.exception(STORE_NOT_EXISTS);
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
