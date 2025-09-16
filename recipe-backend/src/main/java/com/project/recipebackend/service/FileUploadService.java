package com.project.recipebackend.service;

import com.project.recipebackend.config.FileUploadConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class FileUploadService {

    @Autowired
    private FileUploadConfig fileUploadConfig;

    private static final List<String> ALLOWED_IMAGE_TYPES = List.of(
        "image/jpeg", "image/jpg", "image/png", "image/gif", "image/bmp", "image/webp"
    );

    private static final List<String> DISALLOWED_TYPES = List.of(
        "application/pdf", "video/mp4", "video/mpeg", "video/quicktime"
    );

    public String uploadSingleImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File cannot be empty");
        }

        validateImageFile(file);

        String fileName = generateFileName(file.getOriginalFilename());
        Path uploadPath = Paths.get(fileUploadConfig.getImagesDir());
        
        // Create directory if it doesn't exist
        Files.createDirectories(uploadPath);
        
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath);

        return fileName;
    }

    public List<String> uploadMultipleImages(MultipartFile[] files) throws IOException {
        List<String> uploadedFiles = new ArrayList<>();
        
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                String fileName = uploadSingleImage(file);
                uploadedFiles.add(fileName);
            }
        }
        
        return uploadedFiles;
    }

    public String uploadAvatar(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("Avatar file cannot be empty");
        }

        if (!ALLOWED_IMAGE_TYPES.contains(file.getContentType())) {
            throw new IllegalArgumentException("Invalid file type: " + file.getOriginalFilename() + ". Only images are allowed.");
        }

        return uploadSingleImage(file);
    }

    private void validateImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        
        if (DISALLOWED_TYPES.contains(contentType)) {
            throw new IllegalArgumentException("Invalid file type: " + file.getOriginalFilename() + ". Only images are allowed.");
        }
        
        if (!ALLOWED_IMAGE_TYPES.contains(contentType)) {
            throw new IllegalArgumentException("Invalid file type: " + file.getOriginalFilename() + ". Only images are allowed.");
        }
    }

    private String generateFileName(String originalFilename) {
        if (originalFilename == null) {
            originalFilename = "unknown";
        }
        
        // Get file extension
        String extension = "";
        int lastDotIndex = originalFilename.lastIndexOf('.');
        if (lastDotIndex > 0) {
            extension = originalFilename.substring(lastDotIndex);
        }
        
        // Sanitize filename
        String sanitizedName = originalFilename.replaceAll("\\s+", "-");
        
        // Generate timestamp and UUID for uniqueness
        long timestamp = System.currentTimeMillis();
        
        return timestamp + "_" + sanitizedName;
    }
} 