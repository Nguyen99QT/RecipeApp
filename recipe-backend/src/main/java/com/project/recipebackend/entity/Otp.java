package com.project.recipebackend.entity;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "otps")
public class Otp {

    @Id
    private String id;

    @Field(name = "userId")
    @NotNull(message = "User ID is required")
    private User userId;

    @Field(name = "otp")
    @NotNull(message = "OTP is required")
    private Integer otp;

    @Field(name = "email")
    @NotBlank(message = "Email is required")
    private String email;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
