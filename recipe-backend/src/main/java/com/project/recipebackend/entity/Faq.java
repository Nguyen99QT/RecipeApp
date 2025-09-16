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
@Document(collection = "faqs")
public class Faq {

    @Id
    private String id;

    @Field(name = "question")
    @NotBlank(message = "Question is required")
    private String question;

    @Field(name = "answer")
    @NotBlank(message = "Answer is required")
    private String answer;

    @Field(name = "status")
    @NotBlank(message = "Status is required")
    private String status;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
