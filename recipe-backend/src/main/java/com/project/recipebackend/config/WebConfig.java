package com.project.recipebackend.config;

import com.project.recipebackend.middleware.AuthenticationMiddleware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthenticationMiddleware authenticationMiddleware;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authenticationMiddleware)
                .addPathPatterns("/api/admin/**")
                .excludePathPatterns("/api/auth/**", "/api/public/**");
    }
} 