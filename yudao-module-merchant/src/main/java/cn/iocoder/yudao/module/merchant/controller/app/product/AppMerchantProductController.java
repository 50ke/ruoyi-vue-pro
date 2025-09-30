package cn.iocoder.yudao.module.merchant.controller.app.product;

import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.*;
import cn.iocoder.yudao.module.merchant.service.product.MerchantProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;
import static cn.iocoder.yudao.framework.security.core.util.SecurityFrameworkUtils.getLoginUserId;

@Tag(name = "商户 APP - 商品管理")
@RestController
@RequestMapping("/merchant/product")
@Validated
@Slf4j
public class AppMerchantProductController {

    @Resource
    private MerchantProductService merchantProductService;

    @PostMapping("/create")
    @Operation(summary = "创建商品")
    public CommonResult<Long> createProduct(@Valid @RequestBody AppMerchantProductSaveReqVO createReqVO) {
        return success(merchantProductService.createProduct(getLoginUserId(), createReqVO));
    }

    @PutMapping("/update")
    @Operation(summary = "更新商品")
    public CommonResult<Boolean> updateProduct(@Valid @RequestBody AppMerchantProductSaveReqVO updateReqVO) {
        merchantProductService.updateProduct(getLoginUserId(), updateReqVO);
        return success(true);
    }

    @PutMapping("/disable/{id}")
    @Operation(summary = "下架商品")
    public CommonResult<Boolean> disableProduct(@PathVariable Long id) {
        merchantProductService.disableProduct(getLoginUserId(), id);
        return success(true);
    }

    @GetMapping("/page")
    @Operation(summary = "获得商品分页")
    public CommonResult<PageResult<AppMerchantProductRespVO>> getProductPage(@Valid AppMerchantProductPageReqVO pageVO) {
        return success(merchantProductService.getProductPage(getLoginUserId(), pageVO));
    }

    @GetMapping("/get-detail/{spuId}")
    @Operation(summary = "获得商品详情")
    public CommonResult<AppMerchantProductRespVO> getProductDetail(@PathVariable Long spuId) {
        return success(merchantProductService.getProductDetail(getLoginUserId(), spuId));
    }

    @GetMapping("/category/{categoryId}")
    @Operation(summary = "获取商品分类")
    public CommonResult<List<AppMerchantProductCategoryRespVO>> getProductCategory(@PathVariable Long categoryId) {
        return success(merchantProductService.getProductCategory(getLoginUserId(), categoryId));
    }

    @GetMapping("/category/tree")
    @Operation(summary = "获取商品分类树形结构")
    public CommonResult<List<AppMerchantProductCategoryTreeNodeRespVO>> getProductCategoryTree() {
        return success(merchantProductService.getProductCategoryTree(getLoginUserId()));
    }
}
