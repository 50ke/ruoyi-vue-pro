package cn.iocoder.yudao.module.merchant.service.product;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.ProductSaveReqVO;
import jakarta.validation.Valid;

public interface MerchantProductService {
    Long createProduct(Long loginUserId, @Valid ProductSaveReqVO createReqVO);

    void updateProduct(Long loginUserId, @Valid ProductSaveReqVO updateReqVO);

    void disableProduct(Long loginUserId, Long id);

    PageResult<ProductRespVO> getProductPage(Long loginUserId, @Valid ProductPageReqVO pageVO);
}
