package com.project.recipebackend.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Slf4j
@Service
public class FileService {

    // Default paths for uploaded files
    @Value("${app.upload.images.path:./uploads/images/}")
    private String imagePath;

    @Value("${app.upload.videos.path:./uploads/video/}")
    private String videoPath;

    /**
     * Delete an uploaded image file
     * Equivalent to deleteImages function in Node.js
     * 
     * @param filename Name of the file to delete
     * @throws IOException if file deletion fails
     */
    public void deleteImage(String filename) {
        if (filename == null || filename.trim().isEmpty()) {
            log.warn("Filename is null or empty, skipping deletion");
            return;
        }

        try {
            Path filePath = Paths.get(imagePath + filename);
            
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                log.info("Successfully deleted image file: {}", filename);
            } else {
                log.warn("Image file not found: {}", filename);
            }

        } catch (IOException e) {
            log.error("Error deleting image file: {}", filename, e);
            throw new RuntimeException("Failed to delete image file: " + filename, e);
        }
    }

    /**
     * Delete an uploaded video file
     * Equivalent to deleteVideo function in Node.js
     * 
     * @param filename Name of the video file to delete
     * @throws IOException if file deletion fails
     */
    public void deleteVideo(String filename) {
        if (filename == null || filename.trim().isEmpty()) {
            log.warn("Video filename is null or empty, skipping deletion");
            return;
        }

        try {
            Path filePath = Paths.get(videoPath + filename);
            
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                log.info("Successfully deleted video file: {}", filename);
            } else {
                log.warn("Video file not found: {}", filename);
            }

        } catch (IOException e) {
            log.error("Error deleting video file: {}", filename, e);
            throw new RuntimeException("Failed to delete video file: " + filename, e);
        }
    }

    /**
     * Delete multiple image files
     * 
     * @param filenames List of image filenames to delete
     */
    public void deleteImages(java.util.List<String> filenames) {
        if (filenames == null || filenames.isEmpty()) {
            log.warn("No filenames provided for deletion");
            return;
        }

        log.info("Deleting {} image files", filenames.size());
        
        filenames.forEach(filename -> {
            try {
                deleteImage(filename);
            } catch (Exception e) {
                log.error("Failed to delete image: {}", filename, e);
            }
        });
    }

    /**
     * Delete multiple video files
     * 
     * @param filenames List of video filenames to delete
     */
    public void deleteVideos(java.util.List<String> filenames) {
        if (filenames == null || filenames.isEmpty()) {
            log.warn("No video filenames provided for deletion");
            return;
        }

        log.info("Deleting {} video files", filenames.size());
        
        filenames.forEach(filename -> {
            try {
                deleteVideo(filename);
            } catch (Exception e) {
                log.error("Failed to delete video: {}", filename, e);
            }
        });
    }

    /**
     * Check if a file exists
     * 
     * @param filename Name of the file to check
     * @param isVideo Whether the file is a video (true) or image (false)
     * @return true if file exists, false otherwise
     */
    public boolean fileExists(String filename, boolean isVideo) {
        if (filename == null || filename.trim().isEmpty()) {
            return false;
        }

        String basePath = isVideo ? videoPath : imagePath;
        Path filePath = Paths.get(basePath + filename);
        
        return Files.exists(filePath);
    }

    /**
     * Get the full path for an image file
     * 
     * @param filename Image filename
     * @return Full path to the image file
     */
    public String getImagePath(String filename) {
        return imagePath + filename;
    }

    /**
     * Get the full path for a video file
     * 
     * @param filename Video filename
     * @return Full path to the video file
     */
    public String getVideoPath(String filename) {
        return videoPath + filename;
    }

    /**
     * Get file size in bytes
     * 
     * @param filename Name of the file
     * @param isVideo Whether the file is a video (true) or image (false)
     * @return File size in bytes, or -1 if file doesn't exist
     */
    public long getFileSize(String filename, boolean isVideo) {
        if (filename == null || filename.trim().isEmpty()) {
            return -1;
        }

        String basePath = isVideo ? videoPath : imagePath;
        Path filePath = Paths.get(basePath + filename);
        
        try {
            if (Files.exists(filePath)) {
                return Files.size(filePath);
            }
        } catch (IOException e) {
            log.error("Error getting file size for: {}", filename, e);
        }
        
        return -1;
    }
} 