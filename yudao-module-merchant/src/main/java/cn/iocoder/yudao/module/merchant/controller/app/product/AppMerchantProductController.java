package cn.iocoder.yudao.module.merchant.controller.app.product;

import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductPageReqVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductRespVO;
import cn.iocoder.yudao.module.merchant.controller.app.product.vo.AppMerchantProductSaveReqVO;
import cn.iocoder.yudao.module.merchant.service.product.MerchantProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/page")
    @Operation(summary = "获得商品分页")
    public CommonResult<PageResult<AppMerchantProductRespVO>> getProductPage(@Valid @RequestBody AppMerchantProductPageReqVO pageVO) {
        return success(merchantProductService.getProductPage(getLoginUserId(), pageVO));
    }
}
