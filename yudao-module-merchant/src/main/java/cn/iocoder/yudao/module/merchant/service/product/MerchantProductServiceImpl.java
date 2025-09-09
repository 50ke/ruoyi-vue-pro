package cn.iocoder.yudao.module.merchant.service.product;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductSaveReqVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Service
@Validated
@Slf4j
public class MerchantProductServiceImpl implements MerchantProductService{
    @Override
    public Long createProduct(Long loginUserId, ProductSaveReqVO createReqVO) {
        return 0L;
    }

    @Override
    public void updateProduct(Long loginUserId, ProductSaveReqVO updateReqVO) {

    }

    @Override
    public void disableProduct(Long loginUserId, Long id) {

    }

    @Override
    public PageResult<ProductRespVO> getProductPage(Long loginUserId, ProductPageReqVO pageVO) {
        return null;
    }
}
