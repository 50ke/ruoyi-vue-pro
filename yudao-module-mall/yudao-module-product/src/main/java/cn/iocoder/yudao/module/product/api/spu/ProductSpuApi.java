package cn.iocoder.yudao.module.product.api.spu;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.product.api.spu.dto.*;
import cn.iocoder.yudao.module.product.enums.spu.ProductSpuStatusEnum;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import static cn.iocoder.yudao.framework.common.util.collection.CollectionUtils.convertMap;

/**
 * 商品 SPU API 接口
 *
 * @author LeeYan9
 * @since 2022-08-26
 */
public interface ProductSpuApi {

    /**
     * 批量查询 SPU 数组
     *
     * @param ids SPU 编号列表
     * @return SPU 数组
     */
    List<ProductSpuRespDTO> getSpuList(Collection<Long> ids);

    /**
     * 批量查询 SPU MAP
     *
     * @param ids SPU 编号列表
     * @return SPU MAP
     */
    default Map<Long, ProductSpuRespDTO> getSpuMap(Collection<Long> ids) {
        return convertMap(getSpuList(ids), ProductSpuRespDTO::getId);
    }

    /**
     * 批量查询 SPU 数组，并且校验是否 SPU 是否有效。
     *
     * 如下情况，视为无效：
     * 1. 商品编号不存在
     * 2. 商品被禁用
     *
     * @param ids SPU 编号列表
     * @return SPU 数组
     */
    List<ProductSpuRespDTO> validateSpuList(Collection<Long> ids);

    /**
     * 获得 SPU
     *
     * @return SPU
     */
    ProductSpuRespDTO getSpu(Long id);

    /**
     * 创建SPU
     * @param reqDTO 商品信息
     * @return 商品ID
     */
    Long createSpu(ProductSpuSaveReqDTO reqDTO);

    /**
     * 更新SPU
     * @param reqDTO 商品信息
     */
    void updateSpu(ProductSpuSaveReqDTO reqDTO);

    /**
     * 更新SPU状态
     * @param id SPU ID
     * @param productSpuStatusEnum SPU 状态
     */
    void updateSpuStatus(Long id, ProductSpuStatusEnum productSpuStatusEnum);

    /**
     * 分页查询SPU
     * @param pageReqDTO 查询条件
     * @return 查询结果
     */
    PageResult<ProductSpuPageRespDTO> getSpuPage(ProductSpuPageReqDTO pageReqDTO);

    /**
     * 获取SPU详情
     * @param spuId SPU ID
     * @return SPU详情
     */
    ProductSpuDetailRespDTO getSpuDetail(Long spuId);
}
