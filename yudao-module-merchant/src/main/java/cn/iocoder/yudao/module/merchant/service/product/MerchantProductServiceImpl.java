package cn.iocoder.yudao.module.merchant.service.product;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductSaveReqVO;
import cn.iocoder.yudao.module.merchant.dal.dataobject.product.MerchantProductSpuDO;
import cn.iocoder.yudao.module.merchant.dal.mysql.product.MerchantProductSpuMapper;
import cn.iocoder.yudao.module.product.api.spu.ProductSpuApi;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageReqDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuSaveReqDTO;
import cn.iocoder.yudao.module.product.enums.spu.ProductSpuStatusEnum;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

@Service
@Validated
@Slf4j
public class MerchantProductServiceImpl implements MerchantProductService{

    @Resource
    private ProductSpuApi productSpuApi;

    @Resource
    private MerchantProductSpuMapper merchantProductSpuMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long createProduct(Long loginUserId, AppMerchantProductSaveReqVO createReqVO) {
        ProductSpuSaveReqDTO reqDTO = BeanUtils.toBean(createReqVO, ProductSpuSaveReqDTO.class);
        Long spuId = productSpuApi.createSpu(reqDTO);
        merchantProductSpuMapper.insert(MerchantProductSpuDO.builder().merchantId(loginUserId).spuId(spuId).build());
        return spuId;
    }

    @Override
    public void updateProduct(Long loginUserId, AppMerchantProductSaveReqVO updateReqVO) {
        ProductSpuSaveReqDTO reqDTO = BeanUtils.toBean(updateReqVO, ProductSpuSaveReqDTO.class);
        productSpuApi.updateSpu(reqDTO);
    }

    @Override
    public void disableProduct(Long loginUserId, Long id) {
        productSpuApi.updateSpuStatus(id, ProductSpuStatusEnum.DISABLE);
    }

    @Override
    public PageResult<AppMerchantProductRespVO> getProductPage(Long loginUserId, AppMerchantProductPageReqVO pageVO) {
        ProductSpuPageReqDTO pageReqDTO = BeanUtils.toBean(pageVO, ProductSpuPageReqDTO.class);
        PageResult<ProductSpuPageRespDTO> pageRespDTO = productSpuApi.getSpuPage(pageReqDTO);
        return BeanUtils.toBean(pageRespDTO, AppMerchantProductRespVO.class);
    }
}
