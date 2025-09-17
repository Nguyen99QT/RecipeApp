package com.project.recipebackend.entity;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "logins")
public class AdminLogin {

    @Id
    private String id;

    @Field(name = "name")
    @NotBlank(message = "Name is required")
    private String name;

    @Field(name = "email")
    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    @Field(name = "password")
    @NotBlank(message = "Password is required")
    private String password;

    @Field(name = "contact")
    @NotBlank(message = "Contact is required")
    private String contact;

    @Field(name = "avatar")
    private String avatar;

    @Field(name = "isAdmin")
    private Integer isAdmin = 0;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
