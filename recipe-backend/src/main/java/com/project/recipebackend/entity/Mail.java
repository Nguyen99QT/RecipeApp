package com.project.recipebackend.entity;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import jakarta.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "smpts")
public class Mail {

    @Id
    private String id;

    @Field(name = "host")
    @NotBlank(message = "Host is required")
    private String host;

    @Field(name = "port")
    @NotBlank(message = "Port is required")
    private String port;

    @Field(name = "mail_username")
    @NotBlank(message = "Mail username is required")
    private String mail_username;
    
    @Field(name = "mail_password")
    @NotBlank(message = "Mail password is required")
    private String mail_password;

    @Field(name = "encryption")
    @NotBlank(message = "Encryption is required")
    private String encryption;

    @Field(name = "senderEmail")
    @NotBlank(message = "Sender email is required")
    private String senderEmail;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
