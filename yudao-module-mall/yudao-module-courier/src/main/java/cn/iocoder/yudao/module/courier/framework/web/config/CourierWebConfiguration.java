package cn.iocoder.yudao.module.courier.framework.web.config;

import cn.iocoder.yudao.framework.swagger.config.YudaoSwaggerAutoConfiguration;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * courier 模块的 web 组件的 Configuration
 *
 * @author 芋道源码
 */
@Configuration(proxyBeanMethods = false)
public class CourierWebConfiguration {

    /**
     * courier 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi courierGroupedOpenApi() {
        return YudaoSwaggerAutoConfiguration.buildGroupedOpenApi("courier");
    }

} 