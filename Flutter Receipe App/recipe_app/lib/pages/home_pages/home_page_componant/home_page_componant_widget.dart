import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/main_container/main_container_widget.dart';
import '/pages/componants/no_recipe_home_container/no_recipe_home_container_widget.dart';
import '/pages/componants/row_container_componant/row_container_componant_widget.dart';
import '/pages/shimmers/shimmer_row_container_component/shimmer_row_container_component_widget.dart';
import '/utils/network_utils.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'home_page_componant_model.dart';
export 'home_page_componant_model.dart';

class HomePageComponantWidget extends StatefulWidget {
  const HomePageComponantWidget({super.key});

  @override
  State<HomePageComponantWidget> createState() =>
      _HomePageComponantWidgetState();
}

class _HomePageComponantWidgetState extends State<HomePageComponantWidget>
    with TickerProviderStateMixin {
  late HomePageComponantModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

    @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageComponantModel());

    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(-100.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {});
      // Auto-detect network instead of manual IP
      print('[DEBUG] Starting network detection...');
      final ip = await NetworkUtils.getLocalIpAddress();
      print('[DEBUG] Detected IP: $ip');
      await _loadUnreadNotificationCount();
      
      // Load recommended recipes on page initialization
      print('[DEBUG] Loading recommended recipes on init...');
      try {
        _model.allListApi = await RecipeAppGroup.getAllRecipeApiCall.call(
          userId: FFAppState().userId,
          token: FFAppState().token,
        );
        _model.isSelectcategory = true;
        print('[DEBUG] Recommended recipes loaded successfully');
        safeSetState(() {});
      } catch (e) {
        print('[DEBUG] Error loading recommended recipes: $e');
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> _loadUnreadNotificationCount() async {
    try {
      if (FFAppState().token.isEmpty || FFAppState().userId.isEmpty) {
        print('[DEBUG] Missing token or userId, skipping unread count load');
        return;
      }
      
      print('[DEBUG] Loading unread notification count...');
      final response = await RecipeAppGroup.getUnreadNotificationCountApiCall.call(
        token: FFAppState().token,
        userId: FFAppState().userId,
      );
      
      if (response.succeeded) {
        final unreadCount = RecipeAppGroup.getUnreadNotificationCountApiCall.unreadCount(
          response.jsonBody,
        ) ?? 0;
        
        print('[DEBUG] Unread notification count: $unreadCount');
        FFAppState().unreadNotificationCount = unreadCount;
      } else {
        print('[ERROR] Failed to load unread notification count: ${response.statusCode}');
        print('[ERROR] Response body: ${response.bodyText}');
      }
    } catch (e) {
      print('[ERROR] Exception loading unread notification count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: FFAppState()
          .getUserCache(
        uniqueQueryKey: FFAppState().userId,
        requestFn: () => RecipeAppGroup.getUserApiCall.call(
          token: FFAppState().token,
        ),
      )
          .then((result) {
        try {
          _model.apiRequestCompleted2 = true;
          _model.apiRequestLastUniqueKey2 = FFAppState().userId;
        } finally {}
        return result;
      }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 0.0,
              height: 0.0,
              child: BlankComponantWidget(),
            ),
          );
        }
        final columnGetUserApiResponse = snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 24.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 16.0, 0.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).samewhite,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/recipe.png',
                          ).image,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (FFAppState().isLogin == true) {
                          return Text(
                            'Hello,${RecipeAppGroup.getUserApiCall.firstname(
                              columnGetUserApiResponse.jsonBody,
                            )} ${RecipeAppGroup.getUserApiCall.lastname(
                              columnGetUserApiResponse.jsonBody,
                            )}',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: false,
                                  lineHeight: 1.5,
                                ),
                          );
                        } else {
                          return Text(
                            'Hello',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: false,
                                  lineHeight: 1.5,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                  if (FFAppState().isLogin == true)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          // Reset unread count when notification page is opened
                          FFAppState().unreadNotificationCount = 0;
                          context.pushNamed('NotificationPage');
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).lightGrey,
                            shape: BoxShape.circle,
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: SvgPicture.asset(
                                  'assets/images/notification.svg',
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // Notification badge
                              if (FFAppState().unreadNotificationCount > 0)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    child: Text(
                                      FFAppState().unreadNotificationCount > 99 
                                        ? '99+'
                                        : FFAppState().unreadNotificationCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().filterVariable = false;
                  FFAppState().categoryId = '';
                  FFAppState().cuisinesId = [];
                  FFAppState().update(() {});

                  context.pushNamed('search_screen');
                },
                child: Container(
                  width: double.infinity,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).black20,
                    ),
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/images/search_dark_mode.svg'
                                : 'assets/images/search_icon.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Search a recipe...',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context).black40,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Expanded list section - removed AI Recipe Creator button
            Expanded(
              child: Builder(
                builder: (context) {
                  if (FFAppState().connected == true) {
                    return FutureBuilder<ApiCallResponse>(
                      key: ValueKey(_model
                          .favoriteUpdateTrigger), // Add this line for rebuild trigger
                      future: FFAppState().getrFavouriteCache(
                        requestFn: () =>
                            RecipeAppGroup.getAllFavouriteRecipesApiCall.call(
                          token: FFAppState().token,
                        ),
                      ),
                      builder: (context, snapshot) {
                        // Debug logging for getAllFavouriteRecipes
                        print(
                            '[DEBUG] getAllFavouriteRecipes - hasData: ${snapshot.hasData}');
                        print(
                            '[DEBUG] getAllFavouriteRecipes - hasError: ${snapshot.hasError}');
                        if (snapshot.hasData) {
                          print(
                              '[DEBUG] getAllFavouriteRecipes - statusCode: ${snapshot.data?.statusCode}');
                          print(
                              '[DEBUG] getAllFavouriteRecipes - succeeded: ${snapshot.data?.succeeded}');
                          print(
                              '[DEBUG] getAllFavouriteRecipes - bodyText: ${snapshot.data?.bodyText}');
                        }
                        if (snapshot.hasError) {
                          print(
                              '[DEBUG] getAllFavouriteRecipes - error: ${snapshot.error}');
                        }

                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: 0.0,
                              height: 0.0,
                              child: BlankComponantWidget(),
                            ),
                          );
                        }
                        final listViewGetAllFavouriteRecipesApiResponse =
                            snapshot.data!;

                        return RefreshIndicator(
                          key: const Key('RefreshIndicator_07u1fpfn'),
                          color: FlutterFlowTheme.of(context).tertiary,
                          onRefresh: () async {
                            await Future.wait([
                              Future(() async {
                                safeSetState(() {
                                  FFAppState().clearGetAllCategoryCacheCache();
                                  _model.apiRequestCompleted3 = false;
                                });
                                await _model.waitForApiRequestCompleted3();
                              }),
                              Future(() async {
                                safeSetState(() {
                                  FFAppState().clearPopularListCaChCacheKey(
                                      _model.apiRequestLastUniqueKey1);
                                  _model.apiRequestCompleted1 = false;
                                });
                                await _model.waitForApiRequestCompleted1();
                              }),
                            ]);
                          },
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              8.0,
                              0,
                              0,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              if (true /* Warning: Trying to access variable not yet defined. */)
                                FutureBuilder<ApiCallResponse>(
                                  future: (() {
                                    print(
                                        '[DEBUG] Starting Popular Recipe API call...');
                                    print(
                                        '[DEBUG] userId: ${FFAppState().userId}');
                                    print(
                                        '[DEBUG] token: ${FFAppState().token}');

                                    return FFAppState()
                                        .popularListCaCh(
                                      uniqueQueryKey: FFAppState().userId,
                                      requestFn: () => RecipeAppGroup
                                          .popularRecipeApiCall
                                          .call(
                                        userId: FFAppState().userId,
                                        token: FFAppState().token,
                                      ),
                                    )
                                        .then((result) {
                                      print(
                                          '[DEBUG] Popular Recipe API result: ${result.statusCode}');
                                      print(
                                          '[DEBUG] Popular Recipe API body: ${result.bodyText}');
                                      try {
                                        _model.apiRequestCompleted1 = true;
                                        _model.apiRequestLastUniqueKey1 =
                                            FFAppState().userId;
                                      } finally {}
                                      return result;
                                    });
                                  })(),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 252.0,
                                          child:
                                              ShimmerRowContainerComponentWidget(),
                                        ),
                                      );
                                    }
                                    final columnPopularRecipeApiResponse =
                                        snapshot.data!;

                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Popular recipe',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryTextColor,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  FFAppState().filterVariable =
                                                      false;
                                                  FFAppState().categoryId = '';
                                                  FFAppState().cuisinesId = [];
                                                  safeSetState(() {});

                                                  context.pushNamed(
                                                      'popularrecipe_screen');
                                                },
                                                child: Text(
                                                  'View all',
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryTextColor,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: false,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ),
                                            ].divide(
                                                const SizedBox(width: 12.0)),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 252.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .backgroundColor,
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final popularList = (RecipeAppGroup
                                                          .popularRecipeApiCall
                                                          .receipeList(
                                                            columnPopularRecipeApiResponse
                                                                .jsonBody,
                                                          )
                                                          ?.toList() ??
                                                      [])
                                                  .take(3)
                                                  .toList();

                                              print(
                                                  '[DEBUG] Popular list length: ${popularList.length}');
                                              print(
                                                  '[DEBUG] Popular list data: $popularList');

                                              if (popularList.isEmpty) {
                                                print(
                                                    '[DEBUG] Popular list is empty!');
                                                return Center(
                                                  child: Text(
                                                    'No popular recipes found',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                  ),
                                                );
                                              }

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearGetUserCacheCacheKey(
                                                            _model
                                                                .apiRequestLastUniqueKey2);
                                                    _model.apiRequestCompleted2 =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted2();
                                                },
                                                child: ListView.separated(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    16.0,
                                                    0,
                                                    16.0,
                                                    0,
                                                  ),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: popularList.length,
                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(
                                                          width: 16.0),
                                                  itemBuilder: (context,
                                                      popularListIndex) {
                                                    final popularListItem =
                                                        popularList[
                                                            popularListIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              16.0, 0.0, 16.0),
                                                      child: Container(
                                                        width: 190.0,
                                                        height: 220.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child:
                                                            MainContainerWidget(
                                                          key: Key(
                                                              'Keyf8y_${popularListIndex}_of_${popularList.length}'),
                                                          image:
                                                              '${FFAppConstants.imageUrl}${getJsonField(
                                                            popularListItem,
                                                            r'''$.image''',
                                                          ).toString()}',
                                                          name: getJsonField(
                                                            popularListItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          avreragerating:
                                                              (getJsonField(
                                                                        popularListItem,
                                                                        r'''$.averageRating''',
                                                                      ) ??
                                                                      0.0)
                                                                  .toDouble(),
                                                          totalReview:
                                                              (getJsonField(
                                                                        popularListItem,
                                                                        r'''$.totalRating''',
                                                                      ) ??
                                                                      0.0)
                                                                  .toDouble(),
                                                          totaltime:
                                                              getJsonField(
                                                            popularListItem,
                                                            r'''$.totalCookTime''',
                                                          ).toString(),
                                                          favCondition: FFAppState().isLogin == true ? functions
                                                                  .checkFavOrNot(
                                                                      RecipeAppGroup
                                                                          .getAllFavouriteRecipesApiCall
                                                                          .favouriteRecipeList(
                                                                            listViewGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                          )
                                                                          ?.toList(),
                                                                      getJsonField(
                                                                        popularListItem,
                                                                        r'''$._id''',
                                                                      ).toString()) ==
                                                              true : false,
                                                          onFavTap: () async {
                                                            print(
                                                                '[DEBUG] Heart favorite button tapped!');
                                                            print(
                                                                '[DEBUG] isLogin: ${FFAppState().isLogin}');
                                                            print(
                                                                '[DEBUG] token: ${FFAppState().token}');

                                                            if (FFAppState()
                                                                    .isLogin ==
                                                                true) {
                                                              final recipeId =
                                                                  getJsonField(
                                                                popularListItem,
                                                                r'''$._id''',
                                                              ).toString();
                                                              print(
                                                                  '[DEBUG] Recipe ID: $recipeId');

                                                              if (functions.checkFavOrNot(
                                                                      RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                          .favouriteRecipeList(
                                                                            listViewGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                          )
                                                                          ?.toList(),
                                                                      recipeId) ==
                                                                  true) {
                                                                print(
                                                                    '[DEBUG] Removing from favorites...');
                                                                _model.popularDelete =
                                                                    await RecipeAppGroup
                                                                        .deleteFavouriteRecipeApiCall
                                                                        .call(
                                                                  recipeId:
                                                                      recipeId,
                                                                  token:
                                                                      FFAppState()
                                                                          .token,
                                                                );

                                                                print(
                                                                    '[DEBUG] Delete API response: ${_model.popularDelete?.statusCode}');
                                                                print(
                                                                    '[DEBUG] Delete API body: ${_model.popularDelete?.bodyText}');

                                                                await actions
                                                                    .showCustomToastBottom(
                                                                  FFAppState()
                                                                      .unFavText,
                                                                );
                                                              } else {
                                                                print(
                                                                    '[DEBUG] Adding to favorites...');
                                                                _model.popularAdd =
                                                                    await RecipeAppGroup
                                                                        .addFavouriteRecipeCall
                                                                        .call(
                                                                  recipeId:
                                                                      getJsonField(
                                                                    popularListItem,
                                                                    r'''$._id''',
                                                                  ).toString(),
                                                                  token:
                                                                      FFAppState()
                                                                          .token,
                                                                );

                                                                print(
                                                                    '[DEBUG] Add API response: ${_model.popularAdd?.statusCode}');
                                                                print(
                                                                    '[DEBUG] Add API body: ${_model.popularAdd?.bodyText}');

                                                                await actions
                                                                    .showCustomToastBottom(
                                                                  FFAppState()
                                                                      .favText,
                                                                );
                                                              }

                                                              FFAppState()
                                                                  .clearGetrFavouriteCacheCache();
                                                              _model
                                                                  .favoriteUpdateTrigger++;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              FFAppState()
                                                                      .favChange =
                                                                  true;
                                                              FFAppState()
                                                                      .recipeId =
                                                                  getJsonField(
                                                                popularListItem,
                                                                r'''$._id''',
                                                              ).toString();
                                                              FFAppState()
                                                                  .update(
                                                                      () {});

                                                              context.pushNamed(
                                                                  'login_screen');
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          mainTap: () async {
                                                            context.pushNamed(
                                                              'recipe_detail_screen',
                                                              queryParameters: {
                                                                'recipeDetailId':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    popularListItem,
                                                                    r'''$._id''',
                                                                  ).toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'name':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    popularListItem,
                                                                    r'''$.name''',
                                                                  ).toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Recommended for you',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SF Pro Display',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryTextColor,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: false,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        FFAppState().filterVariable = false;
                                        FFAppState().categoryId = '';
                                        FFAppState().cuisinesId = [];
                                        safeSetState(() {});

                                        context.pushNamed(
                                            'recommended_for_you_screen');
                                      },
                                      child: Text(
                                        'View all',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SF Pro Display',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryTextColor,
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: false,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 12.0)),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 40.0,
                                decoration: const BoxDecoration(),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.allListApi =
                                              await RecipeAppGroup
                                                  .getAllRecipeApiCall
                                                  .call(
                                            userId: FFAppState().userId,
                                            token: FFAppState().token,
                                          );

                                          _model.isSelectcategory = true;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _model.isSelectcategory ==
                                                    true
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryTheme
                                                : FlutterFlowTheme.of(context)
                                                    .backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: _model.isSelectcategory ==
                                                      true
                                                  ? const Color(0x00000000)
                                                  : FlutterFlowTheme.of(context)
                                                      .black20,
                                            ),
                                          ),
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 9.0, 16.0, 9.0),
                                            child: Text(
                                              'All',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    color: _model
                                                                .isSelectcategory ==
                                                            true
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .samewhite
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryTextColor,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    useGoogleFonts: false,
                                                    lineHeight: 1.2,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FutureBuilder<ApiCallResponse>(
                                      future: FFAppState()
                                          .getAllCategoryCache(
                                        requestFn: () => RecipeAppGroup
                                            .getAllCategoryApiCall
                                            .call(
                                          token: FFAppState().token,
                                        ),
                                      )
                                          .then((result) {
                                        _model.apiRequestCompleted3 = true;
                                        return result;
                                      }),
                                      builder: (context, snapshot) {
                                        // Debug logging for getAllCategory
                                        print(
                                            '[DEBUG] getAllCategory - hasData: ${snapshot.hasData}');
                                        print(
                                            '[DEBUG] getAllCategory - hasError: ${snapshot.hasError}');
                                        if (snapshot.hasData) {
                                          print(
                                              '[DEBUG] getAllCategory - statusCode: ${snapshot.data?.statusCode}');
                                          print(
                                              '[DEBUG] getAllCategory - succeeded: ${snapshot.data?.succeeded}');
                                          print(
                                              '[DEBUG] getAllCategory - bodyText: ${snapshot.data?.bodyText}');
                                        }
                                        if (snapshot.hasError) {
                                          print(
                                              '[DEBUG] getAllCategory - error: ${snapshot.error}');
                                        }

                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const SizedBox(
                                            width: 0.0,
                                            height: 0.0,
                                            child: BlankComponantWidget(),
                                          );
                                        }
                                        final listViewGetAllCategoryApiResponse =
                                            snapshot.data!;

                                        return Builder(
                                          builder: (context) {
                                            final categoryList = RecipeAppGroup
                                                    .getAllCategoryApiCall
                                                    .categoryList(
                                                      listViewGetAllCategoryApiResponse
                                                          .jsonBody,
                                                    )
                                                    ?.toList() ??
                                                [];

                                            print(
                                                '[DEBUG] categoryList length: ${categoryList.length}');
                                            print(
                                                '[DEBUG] categoryList sample: ${categoryList.take(2).toList()}');

                                            return ListView.separated(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                12.0,
                                                0,
                                                16.0,
                                                0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: categoryList.length,
                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(width: 12.0),
                                              itemBuilder:
                                                  (context, categoryListIndex) {
                                                final categoryListItem =
                                                    categoryList[
                                                        categoryListIndex];
                                                return Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      print(
                                                          '[DEBUG] Category button clicked: ${getJsonField(categoryListItem, r'''$.name''')}');
                                                      _model.isSelectcategory =
                                                          false;
                                                      _model.categoryId =
                                                          getJsonField(
                                                        categoryListItem,
                                                        r'''$._id''',
                                                      ).toString();
                                                      print(
                                                          '[DEBUG] Selected categoryId: ${_model.categoryId}');
                                                      safeSetState(() {});
                                                      _model.getRecipeByCategoryId =
                                                          await RecipeAppGroup
                                                              .getRecipeByCategoryIdApiCall
                                                              .call(
                                                        categoryId:
                                                            _model.categoryId,
                                                        userId:
                                                            FFAppState().userId,
                                                        token:
                                                            FFAppState().token,
                                                      );
                                                      print(
                                                          '[DEBUG] GetRecipeByCategoryId API result:');
                                                      print(
                                                          '[DEBUG] - statusCode: ${_model.getRecipeByCategoryId?.statusCode}');
                                                      print(
                                                          '[DEBUG] - succeeded: ${_model.getRecipeByCategoryId?.succeeded}');
                                                      print(
                                                          '[DEBUG] - bodyText: ${_model.getRecipeByCategoryId?.bodyText}');

                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (_model.isSelectcategory ==
                                                                    false) &&
                                                                (_model
                                                                        .categoryId ==
                                                                    getJsonField(
                                                                      categoryListItem,
                                                                      r'''$._id''',
                                                                    )
                                                                        .toString())
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryTheme
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color: (_model.isSelectcategory ==
                                                                      false) &&
                                                                  (_model
                                                                          .categoryId ==
                                                                      getJsonField(
                                                                        categoryListItem,
                                                                        r'''$._id''',
                                                                      )
                                                                          .toString())
                                                              ? const Color(
                                                                  0x00000000)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .black20,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(16.0,
                                                                9.0, 16.0, 9.0),
                                                        child: Text(
                                                          getJsonField(
                                                            categoryListItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SF Pro Display',
                                                                color: (_model.isSelectcategory ==
                                                                            false) &&
                                                                        (_model
                                                                                .categoryId ==
                                                                            getJsonField(
                                                                              categoryListItem,
                                                                              r'''$._id''',
                                                                            )
                                                                                .toString())
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .samewhite
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryTextColor,
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    false,
                                                                lineHeight: 1.2,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  print(
                                      '[DEBUG] isSelectcategory: ${_model.isSelectcategory}');
                                  print(
                                      '[DEBUG] allListApi is null: ${_model.allListApi == null}');
                                  if (_model.allListApi != null) {
                                    print(
                                        '[DEBUG] allListApi statusCode: ${_model.allListApi?.statusCode}');
                                    print(
                                        '[DEBUG] allListApi bodyText: ${_model.allListApi?.bodyText}');
                                  }

                                  if (_model.isSelectcategory == true) {
                                    return Builder(
                                      builder: (context) {
                                        final allList =
                                            (RecipeAppGroup.getAllRecipeApiCall
                                                        .recipeList(
                                                          (_model.allListApi
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )
                                                        ?.toList() ??
                                                    [])
                                                .take(4)
                                                .toList();

                                        print(
                                            '[DEBUG] allList length: ${allList.length}');
                                        print(
                                            '[DEBUG] allList items: $allList');

                                        return ListView.separated(
                                          padding: const EdgeInsets.fromLTRB(
                                            0,
                                            16.0,
                                            0,
                                            16.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: allList.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(height: 16.0),
                                          itemBuilder: (context, allListIndex) {
                                            final allListItem =
                                                allList[allListIndex];
                                            return RowContainerComponantWidget(
                                              key: Key(
                                                  'Key18w_${allListIndex}_of_${allList.length}'),
                                              image:
                                                  '${FFAppConstants.imageUrl}${getJsonField(
                                                allListItem,
                                                r'''$.image''',
                                              ).toString()}',
                                              name: getJsonField(
                                                allListItem,
                                                r'''$.name''',
                                              ).toString(),
                                              totalTime: getJsonField(
                                                allListItem,
                                                r'''$.totalCookTime''',
                                              ).toString(),
                                              averageReview: (getJsonField(
                                                        allListItem,
                                                        r'''$.averageRating''',
                                                      ) ??
                                                      0.0)
                                                  .toDouble(),
                                              totalReview: (getJsonField(
                                                allListItem,
                                                r'''$.totalRating''',
                                              ) ?? 0.0).toDouble(),
                                              onfavCondition: FFAppState().isLogin == true ?
                                                  functions.checkFavOrNot(
                                                          RecipeAppGroup
                                                              .getAllFavouriteRecipesApiCall
                                                              .favouriteRecipeList(
                                                                listViewGetAllFavouriteRecipesApiResponse
                                                                    .jsonBody,
                                                              )
                                                              ?.toList(),
                                                          getJsonField(
                                                            allListItem,
                                                            r'''$._id''',
                                                          ).toString()) ==
                                                      true : false,
                                              onFavTap: () async {
                                                if (FFAppState().isLogin ==
                                                    true) {
                                                  if (functions.checkFavOrNot(
                                                          RecipeAppGroup
                                                              .getAllFavouriteRecipesApiCall
                                                              .favouriteRecipeList(
                                                                listViewGetAllFavouriteRecipesApiResponse
                                                                    .jsonBody,
                                                              )
                                                              ?.toList(),
                                                          getJsonField(
                                                            allListItem,
                                                            r'''$._id''',
                                                          ).toString()) ==
                                                      true) {
                                                    _model.recommendedDelete =
                                                        await RecipeAppGroup
                                                            .deleteFavouriteRecipeApiCall
                                                            .call(
                                                      recipeId: getJsonField(
                                                        allListItem,
                                                        r'''$._id''',
                                                      ).toString(),
                                                      token: FFAppState().token,
                                                    );

                                                    await actions
                                                        .showCustomToastBottom(
                                                      FFAppState().unFavText,
                                                    );
                                                  } else {
                                                    _model.recommendedAdd =
                                                        await RecipeAppGroup
                                                            .addFavouriteRecipeCall
                                                            .call(
                                                      recipeId: getJsonField(
                                                        allListItem,
                                                        r'''$._id''',
                                                      ).toString(),
                                                      token: FFAppState().token,
                                                    );

                                                    await actions
                                                        .showCustomToastBottom(
                                                      FFAppState().favText,
                                                    );
                                                  }

                                                  FFAppState()
                                                      .clearGetrFavouriteCacheCache();
                                                  _model
                                                      .favoriteUpdateTrigger++;
                                                  safeSetState(() {});
                                                } else {
                                                  FFAppState().favChange = true;
                                                  FFAppState().recipeId =
                                                      getJsonField(
                                                    allListItem,
                                                    r'''$._id''',
                                                  ).toString();
                                                  safeSetState(() {});

                                                  context.pushNamed(
                                                      'login_screen');
                                                }

                                                safeSetState(() {});
                                              },
                                              onMainTap: () async {
                                                context.pushNamed(
                                                  'recipe_detail_screen',
                                                  queryParameters: {
                                                    'recipeDetailId':
                                                        serializeParam(
                                                      getJsonField(
                                                        allListItem,
                                                        r'''$._id''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'name': serializeParam(
                                                      getJsonField(
                                                        allListItem,
                                                        r'''$.name''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Builder(
                                      builder: (context) {
                                        print(
                                            '[DEBUG] Building category recipe list...');
                                        print(
                                            '[DEBUG] _model.getRecipeByCategoryId is null: ${_model.getRecipeByCategoryId == null}');
                                        if (_model.getRecipeByCategoryId !=
                                            null) {
                                          print(
                                              '[DEBUG] Category API statusCode: ${_model.getRecipeByCategoryId?.statusCode}');
                                          print(
                                              '[DEBUG] Category API bodyText: ${_model.getRecipeByCategoryId?.bodyText}');
                                        }

                                        final getRecipeByCategoryIdList =
                                            (RecipeAppGroup
                                                        .getRecipeByCategoryIdApiCall
                                                        .recipeCategoryList(
                                                          (_model.getRecipeByCategoryId
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )
                                                        ?.toList() ??
                                                    [])
                                                .take(3)
                                                .toList();
                                        print(
                                            '[DEBUG] Category recipe list length: ${getRecipeByCategoryIdList.length}');
                                        print(
                                            '[DEBUG] Category recipe list items: ${getRecipeByCategoryIdList.take(2).toList()}');
                                        if (getRecipeByCategoryIdList.isEmpty) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 250.0,
                                              height: 300.0,
                                              child:
                                                  NoRecipeHomeContainerWidget(),
                                            ),
                                          );
                                        }

                                        return RefreshIndicator(
                                          key: const Key(
                                              'RefreshIndicator_eg8ehb83'),
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          onRefresh: () async {},
                                          child: ListView.separated(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              16.0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: getRecipeByCategoryIdList
                                                .length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(height: 16.0),
                                            itemBuilder: (context,
                                                getRecipeByCategoryIdListIndex) {
                                              final getRecipeByCategoryIdListItem =
                                                  getRecipeByCategoryIdList[
                                                      getRecipeByCategoryIdListIndex];
                                              return RowContainerComponantWidget(
                                                key: Key(
                                                    'Keyh7c_${getRecipeByCategoryIdListIndex}_of_${getRecipeByCategoryIdList.length}'),
                                                image:
                                                    '${FFAppConstants.imageUrl}${getJsonField(
                                                  getRecipeByCategoryIdListItem,
                                                  r'''$.image''',
                                                ).toString()}',
                                                name: getJsonField(
                                                  getRecipeByCategoryIdListItem,
                                                  r'''$.name''',
                                                ).toString(),
                                                totalTime: getJsonField(
                                                  getRecipeByCategoryIdListItem,
                                                  r'''$.totalCookTime''',
                                                ).toString(),
                                                averageReview: (getJsonField(
                                                          getRecipeByCategoryIdListItem,
                                                          r'''$.averageRating''',
                                                        ) ??
                                                        0.0)
                                                    .toDouble(),
                                                totalReview: (getJsonField(
                                                  getRecipeByCategoryIdListItem,
                                                  r'''$.totalRating''',
                                                ) ?? 0.0).toDouble(),
                                                onfavCondition: FFAppState().isLogin == true ?
                                                    functions.checkFavOrNot(
                                                            RecipeAppGroup
                                                                .getAllFavouriteRecipesApiCall
                                                                .favouriteRecipeList(
                                                                  listViewGetAllFavouriteRecipesApiResponse
                                                                      .jsonBody,
                                                                )
                                                                ?.toList(),
                                                            getJsonField(
                                                              getRecipeByCategoryIdListItem,
                                                              r'''$._id''',
                                                            ).toString()) ==
                                                        true : false,
                                                onFavTap: () async {
                                                  if (FFAppState().isLogin ==
                                                      true) {
                                                    if (functions.checkFavOrNot(
                                                            RecipeAppGroup
                                                                .getAllFavouriteRecipesApiCall
                                                                .favouriteRecipeList(
                                                                  listViewGetAllFavouriteRecipesApiResponse
                                                                      .jsonBody,
                                                                )
                                                                ?.toList(),
                                                            getJsonField(
                                                              getRecipeByCategoryIdListItem,
                                                              r'''$._id''',
                                                            ).toString()) ==
                                                        true) {
                                                      _model.recommendedFilterDelete =
                                                          await RecipeAppGroup
                                                              .deleteFavouriteRecipeApiCall
                                                              .call(
                                                        recipeId: getJsonField(
                                                          getRecipeByCategoryIdListItem,
                                                          r'''$._id''',
                                                        ).toString(),
                                                        token:
                                                            FFAppState().token,
                                                      );

                                                      await actions
                                                          .showCustomToastBottom(
                                                        FFAppState().unFavText,
                                                      );
                                                    } else {
                                                      _model.recommendedFilterAdd =
                                                          await RecipeAppGroup
                                                              .addFavouriteRecipeCall
                                                              .call(
                                                        recipeId: getJsonField(
                                                          getRecipeByCategoryIdListItem,
                                                          r'''$._id''',
                                                        ).toString(),
                                                        token:
                                                            FFAppState().token,
                                                      );

                                                      await actions
                                                          .showCustomToastBottom(
                                                        FFAppState().favText,
                                                      );
                                                    }

                                                    FFAppState()
                                                        .clearGetrFavouriteCacheCache();
                                                    _model
                                                        .favoriteUpdateTrigger++;
                                                    safeSetState(() {});
                                                  } else {
                                                    FFAppState().favChange =
                                                        true;
                                                    FFAppState().recipeId =
                                                        getJsonField(
                                                      getRecipeByCategoryIdListItem,
                                                      r'''$._id''',
                                                    ).toString();
                                                    safeSetState(() {});

                                                    context.pushNamed(
                                                        'login_screen');
                                                  }

                                                  safeSetState(() {});
                                                },
                                                onMainTap: () async {
                                                  context.pushNamed(
                                                    'recipe_detail_screen',
                                                    queryParameters: {
                                                      'recipeDetailId':
                                                          serializeParam(
                                                        getJsonField(
                                                          getRecipeByCategoryIdListItem,
                                                          r'''$._id''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'name': serializeParam(
                                                        getJsonField(
                                                          getRecipeByCategoryIdListItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Lottie.asset(
                        'assets/lottie_animations/No_Wifi.json',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
