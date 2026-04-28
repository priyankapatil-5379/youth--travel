package com.youthtravel;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String userDir = System.getProperty("user.dir").replace("\\", "/");

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:///" + userDir + "/uploads/",
                        "file:///" + userDir + "/src/main/resources/static/uploads/");
    }
}
