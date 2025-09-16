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
@Document(collection = "users")
public class User {

    @Id
    private String id;

    @Field(name = "firstname")
    @NotNull(message = "Firstname is required")
    private String firstname;

    @Field(name = "lastname")
    @NotNull(message = "Lastname is required")
    private String lastname;

    @Field(name = "email")
    @NotNull(message = "Email is required")
    private String email;

    @Field(name = "country_code")
    @NotNull(message = "Country Code is required")
    private String countryCode;

    @Field(name = "phone")
    @NotNull(message = "Phone is required")
    private String phone;

    @Field(name = "password")
    @NotNull(message = "Password is required")
    private String password;

    @Field(name = "avatar")
    @NotNull(message = "Avatar is required")
    private String avatar;

    @Field(name = "isOTPVerified")
    @NotNull(message = "Is OTP Verified is required")
    private int isOTPVerified = 0;

    @Field(name = "is_active")
    @NotNull(message = "Is Active is required")
    private int isActive = 1;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
