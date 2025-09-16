package com.project.recipebackend.dto;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailResponse {
    private boolean success;
    private String message;
    private String messageId;
    private String error;
    
    public static EmailResponse success(String message, String messageId) {
        return new EmailResponse(true, message, messageId, null);
    }
    
    public static EmailResponse failure(String error) {
        return new EmailResponse(false, null, null, error);
    }
} 