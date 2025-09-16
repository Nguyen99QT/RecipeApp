package com.project.recipebackend.entity;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "userNotification")
public class UserNotification {

    @Id
    private String id;

    @Field(name = "userId")
    @NotNull(message = "User ID is required")
    private User userId;

    @Field(name = "registrationToken")
    @NotNull(message = "Registration Token is required")
    private String registrationToken;

    @Field(name = "deviceId")
    @NotNull(message = "Device ID is required")
    private String deviceId;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
