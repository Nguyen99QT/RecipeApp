import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isLogin = prefs.getBool('ff_isLogin') ?? _isLogin;
    });
    _safeInit(() {
      _intro = prefs.getBool('ff_intro') ?? _intro;
    });
    _safeInit(() {
      _searchList = prefs.getStringList('ff_searchList') ?? _searchList;
    });
    _safeInit(() {
      _userId = prefs.getString('ff_userId') ?? _userId;
    });
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
    _safeInit(() {
      _recipeId = prefs.getString('ff_recipeId') ?? _recipeId;
    });
    _safeInit(() {
      _favChange = prefs.getBool('ff_favChange') ?? _favChange;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userDetail')) {
        try {
          _userDetail = jsonDecode(prefs.getString('ff_userDetail') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _currentPassword =
          prefs.getString('ff_currentPassword') ?? _currentPassword;
    });
    _safeInit(() {
      _deviceId = prefs.getString('ff_deviceId') ?? _deviceId;
    });
    _safeInit(() {
      String savedCountryName = prefs.getString('ff_countryName') ?? _countryName;
      // Override US from emulator to prefer Vietnam for better UX
      if (savedCountryName == 'US' || savedCountryName.isEmpty) {
        _countryName = 'VN';
        prefs.setString('ff_countryName', 'VN'); // Save the corrected value
      } else {
        _countryName = savedCountryName;
      }
    });
    _safeInit(() {
      _isVerified = prefs.getBool('ff_isVerified') ?? _isVerified;
    });
    _safeInit(() {
      _anbanner = prefs.getString('ff_anbanner') ?? _anbanner;
    });
    _safeInit(() {
      _iobanner = prefs.getString('ff_iobanner') ?? _iobanner;
    });
    _safeInit(() {
      _anInterstitial = prefs.getString('ff_anInterstitial') ?? _anInterstitial;
    });
    _safeInit(() {
      _ioInterstitial = prefs.getString('ff_ioInterstitial') ?? _ioInterstitial;
    });
    _safeInit(() {
      _AndroidAdmobId = prefs.getString('ff_AndroidAdmobId') ?? _AndroidAdmobId;
    });
    _safeInit(() {
      _IosAdmobId = prefs.getString('ff_IosAdmobId') ?? _IosAdmobId;
    });
    _safeInit(() {
      _androidBannerEnable =
          prefs.getInt('ff_androidBannerEnable') ?? _androidBannerEnable;
    });
    _safeInit(() {
      _iosBannerEnable = prefs.getInt('ff_iosBannerEnable') ?? _iosBannerEnable;
    });
    _safeInit(() {
      _rewardedVideoAndroidId = prefs.getString('ff_rewardedVideoAndroidId') ??
          _rewardedVideoAndroidId;
    });
    _safeInit(() {
      _rewardedVideoIOSId =
          prefs.getString('ff_rewardedVideoIOSId') ?? _rewardedVideoIOSId;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  int _introIndex = 0;
  int get introIndex => _introIndex;
  set introIndex(int value) {
    _introIndex = value;
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
    prefs.setBool('ff_isLogin', value);
  }

  bool _intro = false;
  bool get intro => _intro;
  set intro(bool value) {
    _intro = value;
    prefs.setBool('ff_intro', value);
  }

  List<String> _searchList = [];
  List<String> get searchList => _searchList;
  set searchList(List<String> value) {
    _searchList = value;
    prefs.setStringList('ff_searchList', value);
  }

  void addToSearchList(String value) {
    searchList.add(value);
    prefs.setStringList('ff_searchList', _searchList);
  }

  void removeFromSearchList(String value) {
    searchList.remove(value);
    prefs.setStringList('ff_searchList', _searchList);
  }

  void removeAtIndexFromSearchList(int index) {
    searchList.removeAt(index);
    prefs.setStringList('ff_searchList', _searchList);
  }

  void updateSearchListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    searchList[index] = updateFn(_searchList[index]);
    prefs.setStringList('ff_searchList', _searchList);
  }

  void insertAtIndexInSearchList(int index, String value) {
    searchList.insert(index, value);
    prefs.setStringList('ff_searchList', _searchList);
  }

  int _carsualindexdetailpage = 0;
  int get carsualindexdetailpage => _carsualindexdetailpage;
  set carsualindexdetailpage(int value) {
    _carsualindexdetailpage = value;
  }

  String _userId = '';
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
    prefs.setString('ff_userId', value);
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  bool _connected = true;
  bool get connected => _connected;
  set connected(bool value) {
    _connected = value;
  }

  String _recipeId = '';
  String get recipeId => _recipeId;
  set recipeId(String value) {
    _recipeId = value;
    prefs.setString('ff_recipeId', value);
  }

  bool _favChange = false;
  bool get favChange => _favChange;
  set favChange(bool value) {
    _favChange = value;
    prefs.setBool('ff_favChange', value);
  }

  dynamic _userDetail;
  dynamic get userDetail => _userDetail;
  set userDetail(dynamic value) {
    _userDetail = value;
    prefs.setString('ff_userDetail', jsonEncode(value));
  }

  bool _filterVariable = false;
  bool get filterVariable => _filterVariable;
  set filterVariable(bool value) {
    _filterVariable = value;
  }

  String _categoryId = '';
  String get categoryId => _categoryId;
  set categoryId(String value) {
    _categoryId = value;
  }

  List<String> _cuisinesId = [];
  List<String> get cuisinesId => _cuisinesId;
  set cuisinesId(List<String> value) {
    _cuisinesId = value;
  }

  void addToCuisinesId(String value) {
    cuisinesId.add(value);
  }

  void removeFromCuisinesId(String value) {
    cuisinesId.remove(value);
  }

  void removeAtIndexFromCuisinesId(int index) {
    cuisinesId.removeAt(index);
  }

  void updateCuisinesIdAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    cuisinesId[index] = updateFn(_cuisinesId[index]);
  }

  void insertAtIndexInCuisinesId(int index, String value) {
    cuisinesId.insert(index, value);
  }

  String _currentPassword = '';
  String get currentPassword => _currentPassword;
  set currentPassword(String value) {
    _currentPassword = value;
    prefs.setString('ff_currentPassword', value);
  }

  String _favText = '     Recipe added to favorite     ';
  String get favText => _favText;
  set favText(String value) {
    _favText = value;
  }

  String _unFavText = '     Recipe removed from favorite     ';
  String get unFavText => _unFavText;
  set unFavText(String value) {
    _unFavText = value;
  }

  String _deviceId = 'TP1A.220624.018';
  String get deviceId => _deviceId;
  set deviceId(String value) {
    _deviceId = value;
    prefs.setString('ff_deviceId', value);
  }

  String _countryCode = '+84'; // Default to Vietnam country code
  String get countryCode => _countryCode;
  set countryCode(String value) {
    _countryCode = value;
  }

  String _phone = '';
  String get phone => _phone;
  set phone(String value) {
    _phone = value;
  }

  String _countryCodeEdit = '+84'; // Default to Vietnam
  String get countryCodeEdit => _countryCodeEdit;
  set countryCodeEdit(String value) {
    _countryCodeEdit = value;
  }

  String _countryName = 'VN'; // Always default to Vietnam for better UX
  String get countryName => _countryName;
  set countryName(String value) {
    // Override US from emulator to prefer Vietnam
    if (value == 'US' || value.isEmpty) {
      _countryName = 'VN';
      prefs.setString('ff_countryName', 'VN');
    } else {
      _countryName = value;
      prefs.setString('ff_countryName', value);
    }
  }

  String _fcmToken = '';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
  }

  bool _isVerified = false;
  bool get isVerified => _isVerified;
  set isVerified(bool value) {
    _isVerified = value;
    prefs.setBool('ff_isVerified', value);
  }

  String _anbanner = '';
  String get anbanner => _anbanner;
  set anbanner(String value) {
    _anbanner = value;
    prefs.setString('ff_anbanner', value);
  }

  String _iobanner = '';
  String get iobanner => _iobanner;
  set iobanner(String value) {
    _iobanner = value;
    prefs.setString('ff_iobanner', value);
  }

  String _anInterstitial = '';
  String get anInterstitial => _anInterstitial;
  set anInterstitial(String value) {
    _anInterstitial = value;
    prefs.setString('ff_anInterstitial', value);
  }

  String _ioInterstitial = '';
  String get ioInterstitial => _ioInterstitial;
  set ioInterstitial(String value) {
    _ioInterstitial = value;
    prefs.setString('ff_ioInterstitial', value);
  }

  int _unreadNotificationCount = 0;
  int get unreadNotificationCount => _unreadNotificationCount;
  set unreadNotificationCount(int value) {
    _unreadNotificationCount = value;
    notifyListeners();
  }

  String _AndroidAdmobId = '';
  String get AndroidAdmobId => _AndroidAdmobId;
  set AndroidAdmobId(String value) {
    _AndroidAdmobId = value;
    prefs.setString('ff_AndroidAdmobId', value);
  }

  String _IosAdmobId = '';
  String get IosAdmobId => _IosAdmobId;
  set IosAdmobId(String value) {
    _IosAdmobId = value;
    prefs.setString('ff_IosAdmobId', value);
  }

  int _androidBannerEnable = 0;
  int get androidBannerEnable => _androidBannerEnable;
  set androidBannerEnable(int value) {
    _androidBannerEnable = value;
    prefs.setInt('ff_androidBannerEnable', value);
  }

  int _iosBannerEnable = 0;
  int get iosBannerEnable => _iosBannerEnable;
  set iosBannerEnable(int value) {
    _iosBannerEnable = value;
    prefs.setInt('ff_iosBannerEnable', value);
  }

  String _rewardedVideoAndroidId = '';
  String get rewardedVideoAndroidId => _rewardedVideoAndroidId;
  set rewardedVideoAndroidId(String value) {
    _rewardedVideoAndroidId = value;
    prefs.setString('ff_rewardedVideoAndroidId', value);
  }

  String _rewardedVideoIOSId = '';
  String get rewardedVideoIOSId => _rewardedVideoIOSId;
  set rewardedVideoIOSId(String value) {
    _rewardedVideoIOSId = value;
    prefs.setString('ff_rewardedVideoIOSId', value);
  }

  final _popularListCaChManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> popularListCaCh({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _popularListCaChManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPopularListCaChCache() => _popularListCaChManager.clear();
  void clearPopularListCaChCacheKey(String? uniqueKey) =>
      _popularListCaChManager.clearRequest(uniqueKey);

  final _getrFavouriteCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getrFavouriteCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getrFavouriteCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetrFavouriteCacheCache() => _getrFavouriteCacheManager.clear();
  void clearGetrFavouriteCacheCacheKey(String? uniqueKey) =>
      _getrFavouriteCacheManager.clearRequest(uniqueKey);

  final _recommendedAllCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> recommendedAllCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _recommendedAllCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRecommendedAllCacheCache() => _recommendedAllCacheManager.clear();
  void clearRecommendedAllCacheCacheKey(String? uniqueKey) =>
      _recommendedAllCacheManager.clearRequest(uniqueKey);

  final _getAllCategoryCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getAllCategoryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getAllCategoryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetAllCategoryCacheCache() => _getAllCategoryCacheManager.clear();
  void clearGetAllCategoryCacheCacheKey(String? uniqueKey) =>
      _getAllCategoryCacheManager.clearRequest(uniqueKey);

  final _recipeDetailCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> recipeDetailCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _recipeDetailCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRecipeDetailCacheCache() => _recipeDetailCacheManager.clear();
  void clearRecipeDetailCacheCacheKey(String? uniqueKey) =>
      _recipeDetailCacheManager.clearRequest(uniqueKey);

  final _getUserCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getUserCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getUserCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetUserCacheCache() => _getUserCacheManager.clear();
  void clearGetUserCacheCacheKey(String? uniqueKey) =>
      _getUserCacheManager.clearRequest(uniqueKey);

  final _cuisinesCcheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> cuisinesCche({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _cuisinesCcheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCuisinesCcheCache() => _cuisinesCcheManager.clear();
  void clearCuisinesCcheCacheKey(String? uniqueKey) =>
      _cuisinesCcheManager.clearRequest(uniqueKey);

  final _filterCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> filterCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _filterCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFilterCacheCache() => _filterCacheManager.clear();
  void clearFilterCacheCacheKey(String? uniqueKey) =>
      _filterCacheManager.clearRequest(uniqueKey);

  final _termsAndConditionsCacheManager =
      FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> termsAndConditionsCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _termsAndConditionsCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTermsAndConditionsCacheCache() =>
      _termsAndConditionsCacheManager.clear();
  void clearTermsAndConditionsCacheCacheKey(String? uniqueKey) =>
      _termsAndConditionsCacheManager.clearRequest(uniqueKey);

  final _getAllNotificationCacheManager =
      FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getAllNotificationCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getAllNotificationCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetAllNotificationCacheCache() =>
      _getAllNotificationCacheManager.clear();
  void clearGetAllNotificationCacheCacheKey(String? uniqueKey) =>
      _getAllNotificationCacheManager.clearRequest(uniqueKey);

  final _faqsCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> faqsCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _faqsCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFaqsCacheCache() => _faqsCacheManager.clear();
  void clearFaqsCacheCacheKey(String? uniqueKey) =>
      _faqsCacheManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
