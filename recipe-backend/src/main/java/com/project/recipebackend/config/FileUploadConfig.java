package com.project.recipebackend.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

@Configuration
public class FileUploadConfig {

    @Value("${file.upload.images-dir}")
    private String imagesDir;

    @Value("${file.upload.videos-dir}")
    private String videosDir;

    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

    public String getImagesDir() {
        return imagesDir;
    }

    public String getVideosDir() {
        return videosDir;
    }
} 