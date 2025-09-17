package com.project.recipebackend.entity;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "ads")
public class Ads {

    @Id
    private String id;

    @Field(name = "android_is_enable")
    private Integer androidIsEnable = 0;

    @Field(name = "android_app_ad_id")
    private String androidAppAdId;

    @Field(name = "android_banner_ad_id")
    private String androidBannerAdId;

    @Field(name = "android_banner_ad_id_is_enable")
    private Integer androidBannerAdIdIsEnable = 0;

    @Field(name = "android_interstitial_ad_id")
    private String androidInterstitialAdId;

    @Field(name = "android_interstitial_ad_id_is_enable")
    private Integer androidInterstitialAdIdIsEnable = 0;

    @Field(name = "android_rewarded_ads")
    private String androidRewardedAds;

    @Field(name = "android_rewarded_ads_is_enable")
    private Integer androidRewardedAdsIsEnable = 0;

    @Field(name = "ios_is_enable")
    private Integer iosIsEnable = 0;

    @Field(name = "ios_app_ad_id")
    private String iosAppAdId;

    @Field(name = "ios_banner_ad_id")
    private String iosBannerAdId;

    @Field(name = "ios_banner_ad_id_is_enable")
    private Integer iosBannerAdIdIsEnable = 0;

    @Field(name = "ios_interstitial_ad_id")
    private String iosInterstitialAdId;

    @Field(name = "ios_interstitial_ad_id_is_enable")
    private Integer iosInterstitialAdIdIsEnable = 0;

    @Field(name = "ios_rewarded_ads")
    private String iosRewardedAds;

    @Field(name = "ios_rewarded_ads_is_enable")
    private Integer iosRewardedAdsIsEnable = 0;

    @CreatedDate
    @Field(name = "createdAt")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Field(name = "updatedAt")
    private LocalDateTime updatedAt;
}
