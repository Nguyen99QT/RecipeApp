package com.project.recipebackend.entity;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.data.mongodb.core.mapping.Document;

import com.project.recipebackend.enums.DifficultyLevel;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "recipes")
public class Recipe {

    @Id
    private String id;

    @Field(name = "image")
    @NotBlank(message = "Image is required")
    private String image;

    @Field(name = "name")
    @NotBlank(message = "Name is required")
    private String name;

    @Field(name = "categoryId")
    @NotNull(message = "Category ID is required")
    private Category categoryId;

    @Field(name = "cuisinesId")
    @NotNull(message = "Cuisines ID is required")
    private Cuisines cuisinesId;

    @Field(name = "ingredients")
    @NotNull(message = "Ingredients are required")
    private List<String> ingredients;

    @Field(name = "prepTime")
    @NotBlank(message = "Prep time is required")
    private String prepTime;

    @Field(name = "cookTime")
    @NotBlank(message = "Cook time is required")
    private String cookTime;

    @Field(name = "totalCookTime")
    @NotBlank(message = "Total cook time is required")
    private String totalCookTime;

    @Field(name = "servings")
    @NotBlank(message = "Servings are required")
    private String servings;

    @Field(name = "difficultyLevel")
    @NotBlank(message = "Difficulty level is required")
    private DifficultyLevel difficultyLevel;

    @Field(name = "gallery")
    @NotNull(message = "Gallery is required")
    private List<String> gallery;

    @Field(name = "video")
    @NotBlank(message = "Video is required")
    private String video;

    @Field(name = "url")
    @NotBlank(message = "URL is required")
    private String url;

    @Field(name = "overview")
    @NotBlank(message = "Overview is required")
    private String overview;

    @Field(name = "how_to_cook")
    @NotBlank(message = "How to cook is required")
    private String how_to_cook;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
