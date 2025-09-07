import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Recipe App Group Code

class RecipeAppGroup {
  static String getBaseUrl({
    String? token = '',
  }) {
    // Use computer's IP address instead of localhost for real device testing
    // Change this IP if your computer's IP changes
    return 'http://192.168.101.207:8190/api';
  }
  static Map<String, String> headers = {
    'Authorization': 'Bearer [token]',
  };
  static SignupApiCall signupApiCall = SignupApiCall();
  static CheckRegisterUserApiCall checkRegisterUserApiCall =
      CheckRegisterUserApiCall();
  static VerifyOtpApiCall verifyOtpApiCall = VerifyOtpApiCall();
  static SignInApiCall signInApiCall = SignInApiCall();
  static IsVerifyAccountApiCall isVerifyAccountApiCall =
      IsVerifyAccountApiCall();
  static ResendOtpCall resendOtpCall = ResendOtpCall();
  static ForgotPasswordCall forgotPasswordCall = ForgotPasswordCall();
  static ForgotPasswordVerificationApiCall forgotPasswordVerificationApiCall =
      ForgotPasswordVerificationApiCall();
  static ResetPasswordApiCall resetPasswordApiCall = ResetPasswordApiCall();
  static UserEditApiCall userEditApiCall = UserEditApiCall();
  static GetUserApiCall getUserApiCall = GetUserApiCall();
  static UploadImageApiCall uploadImageApiCall = UploadImageApiCall();
  static ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static DeleteAccountUserApiCall deleteAccountUserApiCall =
      DeleteAccountUserApiCall();
  static SearchRecipesApiCall searchRecipesApiCall = SearchRecipesApiCall();
  static GetAllFavouriteRecipesApiCall getAllFavouriteRecipesApiCall =
      GetAllFavouriteRecipesApiCall();
  static GetAllRecipeApiCall getAllRecipeApiCall = GetAllRecipeApiCall();
  static GetAllCategoryApiCall getAllCategoryApiCall = GetAllCategoryApiCall();
  static GetRecipeByIdApiCall getRecipeByIdApiCall = GetRecipeByIdApiCall();
  static AddFavouriteRecipeCall addFavouriteRecipeCall =
      AddFavouriteRecipeCall();
  static DeleteFavouriteRecipeApiCall deleteFavouriteRecipeApiCall =
      DeleteFavouriteRecipeApiCall();
  static GetAllCuisinesApiCall getAllCuisinesApiCall = GetAllCuisinesApiCall();
  static PopularRecipeApiCall popularRecipeApiCall = PopularRecipeApiCall();
  static AddReviewApiCall addReviewApiCall = AddReviewApiCall();
  static AddAppFeedbackApiCall addAppFeedbackApiCall = AddAppFeedbackApiCall();
  static GetReviewByRecipeIdApiCall getReviewByRecipeIdApiCall =
      GetReviewByRecipeIdApiCall();
  static GetPolicyAndTermsApiCall getPolicyAndTermsApiCall =
      GetPolicyAndTermsApiCall();
  static GetAllFaqApiCall getAllFaqApiCall = GetAllFaqApiCall();
  static GetAdmobApiCall getAdmobApiCall = GetAdmobApiCall();
  static GetAllNotificationApiCall getAllNotificationApiCall =
      GetAllNotificationApiCall();
  static GetAllIntroApiCall getAllIntroApiCall = GetAllIntroApiCall();
  static FilterRecipeApiCall filterRecipeApiCall = FilterRecipeApiCall();
  static GetRecipeByCategoryIdApiCall getRecipeByCategoryIdApiCall =
      GetRecipeByCategoryIdApiCall();
}

class SignupApiCall {
  Future<ApiCallResponse> call({
    String? firstname = '',
    String? lastname = '',
    String? email = '',
    String? countryCode = '',
    String? phone = '',
    String? password = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "firstname": "$firstname",
  "lastname": "$lastname",
  "email": "$email",
  "country_code": "$countryCode",
  "phone": "$phone",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SignupApi',
      apiUrl: '$baseUrl/SignUp',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class CheckRegisterUserApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CheckRegisterUserApi',
      apiUrl: '$baseUrl/CheckRegisterUser',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class VerifyOtpApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    int? otp,
    String? deviceId = '',
    String? registrationToken = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email",
  "otp": $otp,
  "deviceId": "$deviceId",
  "registrationToken": "$registrationToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VerifyOtpApi',
      apiUrl: '$baseUrl/VerifyOtp',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class SignInApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? deviceId = '',
    String? registrationToken = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email",
  "password": "$password",
  "deviceId": "$deviceId",
  "registrationToken": "$registrationToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SignInApi',
      apiUrl: '$baseUrl/SignIn',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? useId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.id''',
      ));
  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
  dynamic userDetail(dynamic response) => getJsonField(
        response,
        r'''$.user''',
      );
  String? countryCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.country_code''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.phone''',
      ));
  String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.firstname''',
      ));
  String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.lastname''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.email''',
      ));
}

class IsVerifyAccountApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'isVerifyAccountApi',
      apiUrl: '$baseUrl/isVerifyAccount',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ResendOtpCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'resendOtp',
      apiUrl: '$baseUrl/resendOtp',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ForgotPasswordCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ForgotPassword',
      apiUrl: '$baseUrl/ForgotPassword',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ForgotPasswordVerificationApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    int? otp,
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email",
  "otp": $otp
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ForgotPasswordVerificationApi',
      apiUrl: '$baseUrl/ForgotPasswordVerification',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ResetPasswordApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? newPassword = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "email": "$email",
  "newPassword": "$newPassword"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ResetPasswordApi',
      apiUrl: '$baseUrl/ResetPassword',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class UserEditApiCall {
  Future<ApiCallResponse> call({
    String? firstname = '',
    String? lastname = '',
    String? countryCode = '',
    String? phone = '',
    String? avatar = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "firstname": "$firstname",
  "lastname": "$lastname",
  "country_code": "$countryCode",
  "phone": "$phone",
  "avatar": "$avatar"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UserEditApi',
      apiUrl: '$baseUrl/UserEdit',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetUserApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetUserApi',
      apiUrl: '$baseUrl/GetUser',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  dynamic userDetail(dynamic response) => getJsonField(
        response,
        r'''$.user''',
      );
  String? userId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user._id''',
      ));
  String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.firstname''',
      ));
  String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.lastname''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.email''',
      ));
  String? countryCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.country_code''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.phone''',
      ));
  String? avatar(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.avatar''',
      ));
}

class UploadImageApiCall {
  Future<ApiCallResponse> call({
    FFUploadedFile? avatar,
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'UploadImageApi',
      apiUrl: '$baseUrl/UploadImage',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {
        'avatar': avatar,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ChangePasswordCall {
  Future<ApiCallResponse> call({
    String? currentPassword = '',
    String? newPassword = '',
    String? confirmPassword = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "currentPassword": "$currentPassword",
  "newPassword": "$newPassword",
  "confirmPassword": "$confirmPassword"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ChangePassword',
      apiUrl: '$baseUrl/ChangePassword',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class DeleteAccountUserApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteAccountUserApi',
      apiUrl: '$baseUrl/DeleteAccountUser',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class SearchRecipesApiCall {
  Future<ApiCallResponse> call({
    String? recipeName = '',
    String? userId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "recipeName": "$recipeName"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SearchRecipesApi',
      apiUrl: '$baseUrl/SearchRecipes',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? recipeList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetAllFavouriteRecipesApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetAllFavouriteRecipesApi',
      apiUrl: '$baseUrl/GetAllFavouriteRecipes',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? favouriteRecipeList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? gallery(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].recipeId.gallery''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].recipeId.name''',
      ));
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].recipeId.image''',
      ));
  String? totalCookTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].recipeId.totalCookTime''',
      ));
  bool? isFavourite(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].recipeId.isFavourite''',
      ));
  int? totalRating(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].recipeId.totalRating''',
      ));
  int? averageRating(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].recipeId.averageRating''',
      ));
}

class GetAllRecipeApiCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": "$userId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllRecipeApi',
      apiUrl: '$baseUrl/GetAllRecipe',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? recipeList(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? totalCookTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].totalCookTime''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? totalRating(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].totalRating''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? averageRating(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].averageRating''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class GetAllCategoryApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetAllCategoryApi',
      apiUrl: '$baseUrl/GetAllCategory',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? categoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? categoryId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetRecipeByIdApiCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? recipeId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "recipeId": "$recipeId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetRecipeByIdApi',
      apiUrl: '$baseUrl/GetRecipeById',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic recipeList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.image''',
      ));
  String? cookTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.cookTime''',
      ));
  String? totalCookTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.totalCookTime''',
      ));
  String? servings(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.servings''',
      ));
  String? difficultyLevel(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.difficultyLevel''',
      ));
  double? averageRating(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.data.averageRating''',
      ));
  int? totalRating(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.totalRating''',
      ));
  int? totalReviews(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.totalReviews''',
      ));
  String? howtocook(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.how_to_cook''',
      ));
  String? cuisinesIdName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.cuisinesId.name''',
      ));
  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.url''',
      ));
  String? overView(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.overview''',
      ));
  List<String>? galleryList(dynamic response) => (getJsonField(
        response,
        r'''$.data.gallery''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? recipeId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data._id''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  List<String>? ingredients(dynamic response) => (getJsonField(
        response,
        r'''$.data.ingredients''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? video(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.video''',
      ));
}

class AddFavouriteRecipeCall {
  Future<ApiCallResponse> call({
    String? recipeId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "recipeId": "$recipeId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddFavouriteRecipe',
      apiUrl: '$baseUrl/AddFavouriteRecipe',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class DeleteFavouriteRecipeApiCall {
  Future<ApiCallResponse> call({
    String? recipeId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "recipeId": "$recipeId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteFavouriteRecipeApi',
      apiUrl: '$baseUrl/DeleteFavouriteRecipe',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetAllCuisinesApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetAllCuisinesApi',
      apiUrl: '$baseUrl/GetAllCuisines',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? cuisinesList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? cuisinesId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PopularRecipeApiCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": "$userId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'popularRecipeApi',
      apiUrl: '$baseUrl/popularRecipe',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? totalCookTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].totalCookTime''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? receipeList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<int>? totalRating(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].totalRating''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class AddReviewApiCall {
  Future<ApiCallResponse> call({
    String? recipeId = '',
    int? rating,
    String? comment = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "recipeId": "$recipeId",
  "rating": $rating,
  "comment": "$comment"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddReviewApi',
      apiUrl: '$baseUrl/AddReview',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class AddAppFeedbackApiCall {
  Future<ApiCallResponse> call({
    int? rating,
    String? comment = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "rating": $rating,
  "comment": "$comment"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddAppFeedbackApi',
      apiUrl: '$baseUrl/AddAppFeedback',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetReviewByRecipeIdApiCall {
  Future<ApiCallResponse> call({
    String? recipeId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "recipeId": "$recipeId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetReviewByRecipeIdApi',
      apiUrl: '$baseUrl/GetReviewByRecipeId',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPolicyAndTermsApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetPolicyAndTermsApi',
      apiUrl: '$baseUrl/GetPolicyAndTerms',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? privatePolicy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[0].privatePolicy''',
      ));
  String? termsAndConditions(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[0].termsAndConditions''',
      ));
}

class GetAllFaqApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getAllFaqApi',
      apiUrl: '$baseUrl/GetAllFaq',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? faqList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? question(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].question''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? answer(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].answer''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAdmobApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getAdmobApi',
      apiUrl: '$baseUrl/getAdmob',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic ads(dynamic response) => getJsonField(
        response,
        r'''$.data.ads''',
      );
  int? androidisEnable(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.ads.android_is_enable''',
      ));
  int? iosisEnable(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.ads.ios_is_enable''',
      ));
  String? androidbanneradid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.ads.android_banner_ad_id''',
      ));
  String? androidinterstitialadid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.ads.android_interstitial_ad_id''',
      ));
  String? androidrewardedads(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.ads.android_rewarded_ads''',
      ));
  int? androidbanneradidisenable(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.ads.android_banner_ad_id_is_enable''',
      ));
  int? androidinterstitialadidisenable(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.ads.android_interstitial_ad_id_is_enable''',
      ));
  int? androidrewardedadsisenable(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.ads.android_rewarded_ads_is_enable''',
      ));
  String? iosbanneradid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.ads.ios_banner_ad_id''',
      ));
  String? iosinterstitialadid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.ads.ios_interstitial_ad_id''',
      ));
  String? iosrewardedads(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.ads.ios_rewarded_ads''',
      ));
  int? iosbanneradidisenable(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.ads.ios_banner_ad_id_is_enable''',
      ));
  int? iosinterstitialadidisenable(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.ads.ios_interstitial_ad_id_is_enable''',
      ));
  int? iosrewardedadsisenable(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.ads.ios_rewarded_ads_is_enable''',
      ));
  String? androidappadid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.ads.android_app_ad_id''',
      ));
  String? iosappadid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.ads.ios_app_ad_id''',
      ));
}

class GetAllNotificationApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    // Debug logging
    print('[DEBUG] GetAllNotificationApi - baseUrl: $baseUrl');
    print('[DEBUG] GetAllNotificationApi - full URL: $baseUrl/GetAllNotification');
    print('[DEBUG] GetAllNotificationApi - token: ${token?.isNotEmpty == true ? 'present' : 'empty'}');

    return ApiManager.instance.makeApiCall(
      callName: 'GetAllNotificationApi',
      apiUrl: '$baseUrl/GetAllNotification',
      callType: ApiCallType.POST,
      headers: token?.isNotEmpty == true ? {
        'Authorization': 'Bearer $token',
      } : {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? notificationList(dynamic response) => getJsonField(
        response,
        r'''$.data.notification''',
        true,
      ) as List?;
}

class GetAllIntroApiCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );
    
    print('[DEBUG] GetAllIntroApiCall - baseUrl: $baseUrl');
    print('[DEBUG] GetAllIntroApiCall - full URL: $baseUrl/getAllIntro');

    return ApiManager.instance.makeApiCall(
      callName: 'getAllIntroApi',
      apiUrl: '$baseUrl/getAllIntro',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      params: {},
      body: '{}',
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? introList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class FilterRecipeApiCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
    List<String>? cuisinesIdList,
    String? userId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );
    final cuisinesId = _serializeList(cuisinesIdList);

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "categoryId": "$categoryId",
  "cuisinesIdList": $cuisinesId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FilterRecipeApi',
      apiUrl: '$baseUrl/FilterRecipe',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List? filteredRecipesList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetRecipeByCategoryIdApiCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? categoryId = '',
    String? token = '',
  }) async {
    final baseUrl = RecipeAppGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "categoryId": "$categoryId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetRecipeByCategoryIdApi',
      apiUrl: '$baseUrl/GetRecipeByCategoryId',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? recipeCategoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
}

/// End Recipe App Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  // if (item is DocumentReference) {
  if (item) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

