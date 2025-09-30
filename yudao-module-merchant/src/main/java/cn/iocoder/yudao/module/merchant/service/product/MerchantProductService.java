package cn.iocoder.yudao.module.merchant.service.product;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.*;
import jakarta.validation.Valid;

import java.util.List;

public interface MerchantProductService {
    Long createProduct(Long loginUserId, @Valid AppMerchantProductSaveReqVO createReqVO);

    void updateProduct(Long loginUserId, @Valid AppMerchantProductSaveReqVO updateReqVO);

    void disableProduct(Long loginUserId, Long id);

    PageResult<AppMerchantProductRespVO> getProductPage(Long loginUserId, @Valid AppMerchantProductPageReqVO pageVO);

    AppMerchantProductRespVO getProductDetail(Long loginUserId, Long spuId);

    List<AppMerchantProductCategoryRespVO> getProductCategory(Long loginUserId, Long categoryId);

    List<AppMerchantProductCategoryTreeNodeRespVO> getProductCategoryTree(Long loginUserId);
}
