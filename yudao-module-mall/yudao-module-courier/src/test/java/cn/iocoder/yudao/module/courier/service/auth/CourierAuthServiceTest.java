package cn.iocoder.yudao.module.courier.service.auth;

import cn.iocoder.yudao.framework.test.core.ut.BaseDbUnitTest;
import cn.iocoder.yudao.module.courier.controller.app.auth.vo.AppAuthLoginReqVO;
import cn.iocoder.yudao.module.courier.controller.app.auth.vo.AppAuthLoginRespVO;
import cn.iocoder.yudao.module.courier.dal.dataobject.user.CourierUserDO;
import cn.iocoder.yudao.module.courier.service.user.CourierUserService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.security.crypto.password.PasswordEncoder;

import jakarta.annotation.Resource;

import static cn.iocoder.yudao.framework.common.util.object.ObjectUtils.cloneIgnoreId;
import static cn.iocoder.yudao.framework.test.core.util.AssertUtils.assertPojoEquals;
import static cn.iocoder.yudao.framework.test.core.util.RandomUtils.randomLongId;
import static cn.iocoder.yudao.framework.test.core.util.RandomUtils.randomPojo;
import static cn.iocoder.yudao.framework.test.core.util.RandomUtils.randomString;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.argThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * {@link CourierAuthServiceImpl} 的单元测试类
 *
 * @author 芋道源码
 */
@Import(CourierAuthServiceImpl.class)
public class CourierAuthServiceTest extends BaseDbUnitTest {

    @Resource
    private CourierAuthService authService;

    @MockBean
    private CourierUserService courierUserService;
    @MockBean
    private PasswordEncoder passwordEncoder;

    @Test
    public void testLogin_success() {
        // 准备参数
        AppAuthLoginReqVO reqVO = new AppAuthLoginReqVO();
        reqVO.setUsername("courier001");
        reqVO.setPassword("123456");

        // mock 数据
        CourierUserDO courier = randomPojo(CourierUserDO.class, o -> {
            o.setId(randomLongId());
            o.setUsername(reqVO.getUsername());
            o.setPassword("encoded_password");
            o.setStatus(1); // 启用状态
        });
        when(courierUserService.getUserByUsername(eq(reqVO.getUsername()))).thenReturn(courier);
        when(passwordEncoder.matches(eq(reqVO.getPassword()), eq(courier.getPassword()))).thenReturn(true);

        // 调用
        AppAuthLoginRespVO respVO = authService.login(reqVO);
        // 断言
        assertNotNull(respVO);
        assertNotNull(respVO.getAccessToken());
        assertNotNull(respVO.getRefreshToken());
        assertPojoEquals(courier, respVO, "accessToken", "refreshToken", "expiresTime");
    }

} 