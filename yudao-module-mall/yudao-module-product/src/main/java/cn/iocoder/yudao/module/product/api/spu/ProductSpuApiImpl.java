package cn.iocoder.yudao.module.product.api.spu;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageReqDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuPageRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuRespDTO;
import cn.iocoder.yudao.module.product.api.spu.dto.ProductSpuSaveReqDTO;
import cn.iocoder.yudao.module.product.controller.admin.spu.vo.ProductSpuPageReqVO;
import cn.iocoder.yudao.module.product.controller.admin.spu.vo.ProductSpuSaveReqVO;
import cn.iocoder.yudao.module.product.controller.admin.spu.vo.ProductSpuUpdateStatusReqVO;
import cn.iocoder.yudao.module.product.dal.dataobject.spu.ProductSpuDO;
import cn.iocoder.yudao.module.product.enums.spu.ProductSpuStatusEnum;
import cn.iocoder.yudao.module.product.service.spu.ProductSpuService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.Collection;
import java.util.List;

/**
 * 商品 SPU API 接口实现类
 *
 * @author LeeYan9
 * @since 2022-09-06
 */
@Service
@Validated
public class ProductSpuApiImpl implements ProductSpuApi {

    @Resource
    private ProductSpuService spuService;

    @Override
    public List<ProductSpuRespDTO> getSpuList(Collection<Long> ids) {
        List<ProductSpuDO> spus = spuService.getSpuList(ids);
        return BeanUtils.toBean(spus, ProductSpuRespDTO.class);
    }

    @Override
    public List<ProductSpuRespDTO> validateSpuList(Collection<Long> ids) {
        List<ProductSpuDO> spus = spuService.validateSpuList(ids);
        return BeanUtils.toBean(spus, ProductSpuRespDTO.class);
    }

    @Override
    public ProductSpuRespDTO getSpu(Long id) {
        ProductSpuDO spu = spuService.getSpu(id);
        return BeanUtils.toBean(spu, ProductSpuRespDTO.class);
    }

    @Override
    public Long createSpu(ProductSpuSaveReqDTO reqDTO) {
        ProductSpuSaveReqVO reqVO = BeanUtils.toBean(reqDTO, ProductSpuSaveReqVO.class);
        return spuService.createSpu(reqVO);
    }

    @Override
    public void updateSpu(ProductSpuSaveReqDTO reqDTO) {
        ProductSpuSaveReqVO reqVO = BeanUtils.toBean(reqDTO, ProductSpuSaveReqVO.class);
        spuService.updateSpu(reqVO);
    }

    @Override
    public void updateSpuStatus(Long id, ProductSpuStatusEnum productSpuStatusEnum) {
        ProductSpuUpdateStatusReqVO reqVO = new ProductSpuUpdateStatusReqVO();
        reqVO.setId(id);
        reqVO.setStatus(productSpuStatusEnum.getStatus());
        spuService.updateSpuStatus(reqVO);
    }

    @Override
    public PageResult<ProductSpuPageRespDTO> getSpuPage(ProductSpuPageReqDTO pageReqDTO) {
        ProductSpuPageReqVO reqVO = BeanUtils.toBean(pageReqDTO, ProductSpuPageReqVO.class);
        PageResult<ProductSpuDO> spuPage = spuService.getSpuPage(reqVO);
        return BeanUtils.toBean(spuPage, ProductSpuPageRespDTO.class);
    }

}
