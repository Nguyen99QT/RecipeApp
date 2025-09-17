import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/main_container/main_container_widget.dart';
import '/pages/componants/no_receipe_filter_yet_container/no_receipe_filter_yet_container_widget.dart';
import '/pages/componants/no_receipe_yet_container/no_receipe_yet_container_widget.dart';
import '/pages/home_pages/filter_bottomsheet/filter_bottomsheet_widget.dart';
import '/pages/shimmers/shimmer_grid_view_component/shimmer_grid_view_component_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'recommended_for_you_screen_model.dart';
export 'recommended_for_you_screen_model.dart';

class RecommendedForYouScreenWidget extends StatefulWidget {
  const RecommendedForYouScreenWidget({super.key});

  @override
  State<RecommendedForYouScreenWidget> createState() =>
      _RecommendedForYouScreenWidgetState();
}

class _RecommendedForYouScreenWidgetState
    extends State<RecommendedForYouScreenWidget> {
  late RecommendedForYouScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecommendedForYouScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
        body: SafeArea(
          top: true,
          child: FutureBuilder<ApiCallResponse>(
            future: RecipeAppGroup.getAdmobApiCall.call(),
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
              final containerGetAdmobApiResponse = snapshot.data!;

              return Container(
                decoration: const BoxDecoration(),
                child: FutureBuilder<ApiCallResponse>(
                  future: FFAppState().getrFavouriteCache(
                    uniqueQueryKey: FFAppState().userId,
                    requestFn: () =>
                        RecipeAppGroup.getAllFavouriteRecipesApiCall.call(
                      token: FFAppState().token,
                    ),
                  ),
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
                    final columnGetAllFavouriteRecipesApiResponse =
                        snapshot.data!;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 79.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).backgroundColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 21.0, 16.0, 18.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.safePop();
                                        },
                                        child: Container(
                                          width: 44.0,
                                          height: 44.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .lightGrey,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: SvgPicture.asset(
                                              'assets/images/arrow-left.svg',
                                              width: 22.0,
                                              height: 22.0,
                                              fit: BoxFit.cover,
                                              alignment: const Alignment(0.0, 0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Recommended for you',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
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
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        const FilterBottomsheetWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: Container(
                                          width: 44.0,
                                          height: 44.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .lightGrey,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: SvgPicture.asset(
                                              'assets/images/filter_svg.svg',
                                              width: 24.0,
                                              height: 24.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).black20,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (FFAppState().connected) {
                                return Builder(
                                  builder: (context) {
                                    if (FFAppState().filterVariable == false) {
                                      return FutureBuilder<ApiCallResponse>(
                                        future: FFAppState()
                                            .recommendedAllCache(
                                          requestFn: () => RecipeAppGroup
                                              .getAllRecipeApiCall
                                              .call(
                                            userId: FFAppState().userId,
                                            token: FFAppState().token,
                                          ),
                                        )
                                            .then((result) {
                                          _model.apiRequestCompleted2 = true;
                                          return result;
                                        }),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child:
                                                    ShimmerGridViewComponentWidget(),
                                              ),
                                            );
                                          }
                                          final containerGetAllRecipeApiResponse =
                                              snapshot.data!;

                                          return Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: const BoxDecoration(),
                                            child: Builder(
                                              builder: (context) {
                                                if (RecipeAppGroup
                                                            .getAllRecipeApiCall
                                                            .recipeList(
                                                          containerGetAllRecipeApiResponse
                                                              .jsonBody,
                                                        ) !=
                                                        null &&
                                                    (RecipeAppGroup
                                                            .getAllRecipeApiCall
                                                            .recipeList(
                                                      containerGetAllRecipeApiResponse
                                                          .jsonBody,
                                                    ))!
                                                        .isNotEmpty) {
                                                  return RefreshIndicator(
                                                    key: const Key(
                                                        'RefreshIndicator_79wb05e9'),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                    onRefresh: () async {
                                                      safeSetState(() {
                                                        FFAppState()
                                                            .clearRecommendedAllCacheCache();
                                                        _model.apiRequestCompleted2 =
                                                            false;
                                                      });
                                                      await _model
                                                          .waitForApiRequestCompleted2();
                                                    },
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                        0,
                                                        16.0,
                                                        0,
                                                        16.0,
                                                      ),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final getAllRecipeList =
                                                                  RecipeAppGroup
                                                                          .getAllRecipeApiCall
                                                                          .recipeList(
                                                                            containerGetAllRecipeApiResponse.jsonBody,
                                                                          )
                                                                          ?.toList() ??
                                                                      [];

                                                              return Wrap(
                                                                spacing: 16.0,
                                                                runSpacing:
                                                                    16.0,
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .start,
                                                                direction: Axis
                                                                    .horizontal,
                                                                runAlignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                verticalDirection:
                                                                    VerticalDirection
                                                                        .down,
                                                                clipBehavior:
                                                                    Clip.none,
                                                                children: List.generate(
                                                                    getAllRecipeList
                                                                        .length,
                                                                    (getAllRecipeListIndex) {
                                                                  final getAllRecipeListItem =
                                                                      getAllRecipeList[
                                                                          getAllRecipeListIndex];
                                                                  return MainContainerWidget(
                                                                    key: Key(
                                                                        'Keytm2_${getAllRecipeListIndex}_of_${getAllRecipeList.length}'),
                                                                    image:
                                                                        '${FFAppConstants.imageUrl}${getJsonField(
                                                                      getAllRecipeListItem,
                                                                      r'''$.image''',
                                                                    ).toString()}',
                                                                    name:
                                                                        getJsonField(
                                                                      getAllRecipeListItem,
                                                                      r'''$.name''',
                                                                    ).toString(),
                                                                    avreragerating:
                                                                        (getJsonField(
                                                                      getAllRecipeListItem,
                                                                      r'''$.averageRating''',
                                                                    ) ?? 0.0).toDouble(),
                                                                    totalReview:
                                                                        (getJsonField(
                                                                      getAllRecipeListItem,
                                                                      r'''$.totalRating''',
                                                                    ) ?? 0.0).toDouble(),
                                                                    totaltime:
                                                                        getJsonField(
                                                                      getAllRecipeListItem,
                                                                      r'''$.totalCookTime''',
                                                                    ).toString(),
                                                                    favCondition: FFAppState().isLogin == true ? functions.checkFavOrNot(
                                                                            RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                .favouriteRecipeList(
                                                                                  columnGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                )
                                                                                ?.toList(),
                                                                            getJsonField(
                                                                              getAllRecipeListItem,
                                                                              r'''$._id''',
                                                                            ).toString()) ==
                                                                        true : false,
                                                                    onFavTap:
                                                                        () async {
                                                                      if (FFAppState()
                                                                              .isLogin ==
                                                                          true) {
                                                                        if (functions.checkFavOrNot(
                                                                                RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                    .favouriteRecipeList(
                                                                                      columnGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                    )
                                                                                    ?.toList(),
                                                                                getJsonField(
                                                                                  getAllRecipeListItem,
                                                                                  r'''$._id''',
                                                                                ).toString()) ==
                                                                            true) {
                                                                          _model.popularDelete = await RecipeAppGroup
                                                                              .deleteFavouriteRecipeApiCall
                                                                              .call(
                                                                            recipeId:
                                                                                getJsonField(
                                                                              getAllRecipeListItem,
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
                                                                          _model.popularAdd = await RecipeAppGroup
                                                                              .addFavouriteRecipeCall
                                                                              .call(
                                                                            recipeId:
                                                                                getJsonField(
                                                                              getAllRecipeListItem,
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
                                                                      } else {
                                                                        FFAppState().favChange =
                                                                            true;
                                                                        FFAppState().recipeId =
                                                                            getJsonField(
                                                                          getAllRecipeListItem,
                                                                          r'''$._id''',
                                                                        ).toString();
                                                                        FFAppState()
                                                                            .update(() {});

                                                                        context.pushNamed(
                                                                            'login_screen');
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    mainTap:
                                                                        () async {
                                                                      context
                                                                          .pushNamed(
                                                                        'recipe_detail_screen',
                                                                        queryParameters:
                                                                            {
                                                                          'recipeDetailId':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              getAllRecipeListItem,
                                                                              r'''$._id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'name':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              getAllRecipeListItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  return wrapWithModel(
                                                    model: _model
                                                        .noReceipeYetContainerModel,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        const NoReceipeYetContainerWidget(),
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return FutureBuilder<ApiCallResponse>(
                                        future: FFAppState()
                                            .filterCache(
                                          requestFn: () => RecipeAppGroup
                                              .filterRecipeApiCall
                                              .call(
                                            categoryId: FFAppState().categoryId,
                                            cuisinesIdList:
                                                FFAppState().cuisinesId,
                                            userId: FFAppState().userId,
                                          ),
                                        )
                                            .then((result) {
                                          _model.apiRequestCompleted1 = true;
                                          return result;
                                        }),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child:
                                                    ShimmerGridViewComponentWidget(),
                                              ),
                                            );
                                          }
                                          final containerFilterRecipeApiResponse =
                                              snapshot.data!;

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              safeSetState(() {
                                                FFAppState()
                                                    .clearFilterCacheCache();
                                                _model.apiRequestCompleted1 =
                                                    false;
                                              });
                                              await _model
                                                  .waitForApiRequestCompleted1();
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    if (RecipeAppGroup
                                                                .filterRecipeApiCall
                                                                .filteredRecipesList(
                                                              containerFilterRecipeApiResponse
                                                                  .jsonBody,
                                                            ) !=
                                                            null &&
                                                        (RecipeAppGroup
                                                                .filterRecipeApiCall
                                                                .filteredRecipesList(
                                                          containerFilterRecipeApiResponse
                                                              .jsonBody,
                                                        ))!
                                                            .isNotEmpty) {
                                                      return RefreshIndicator(
                                                        key: const Key(
                                                            'RefreshIndicator_0hck62lr'),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        onRefresh: () async {
                                                          safeSetState(() {
                                                            FFAppState()
                                                                .clearFilterCacheCache();
                                                            _model.apiRequestCompleted1 =
                                                                false;
                                                          });
                                                          await _model
                                                              .waitForApiRequestCompleted1();
                                                        },
                                                        child: ListView(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                            0,
                                                            16.0,
                                                            0,
                                                            16.0,
                                                          ),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final filterRecipeList = RecipeAppGroup
                                                                          .filterRecipeApiCall
                                                                          .filteredRecipesList(
                                                                            containerFilterRecipeApiResponse.jsonBody,
                                                                          )
                                                                          ?.toList() ??
                                                                      [];
                                                                  if (filterRecipeList
                                                                      .isEmpty) {
                                                                    return const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            300.0,
                                                                        child:
                                                                            NoReceipeYetContainerWidget(),
                                                                      ),
                                                                    );
                                                                  }

                                                                  return Wrap(
                                                                    spacing:
                                                                        16.0,
                                                                    runSpacing:
                                                                        16.0,
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .start,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    runAlignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .down,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: List.generate(
                                                                        filterRecipeList
                                                                            .length,
                                                                        (filterRecipeListIndex) {
                                                                      final filterRecipeListItem =
                                                                          filterRecipeList[
                                                                              filterRecipeListIndex];
                                                                      return MainContainerWidget(
                                                                        key: Key(
                                                                            'Key74p_${filterRecipeListIndex}_of_${filterRecipeList.length}'),
                                                                        image:
                                                                            '${FFAppConstants.imageUrl}${getJsonField(
                                                                          filterRecipeListItem,
                                                                          r'''$.image''',
                                                                        ).toString()}',
                                                                        name:
                                                                            getJsonField(
                                                                          filterRecipeListItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        avreragerating:
                                                                            (getJsonField(
                                                                          filterRecipeListItem,
                                                                          r'''$.averageRating''',
                                                                        ) ?? 0.0).toDouble(),
                                                                        totalReview:
                                                                            (getJsonField(
                                                                          filterRecipeListItem,
                                                                          r'''$.totalRating''',
                                                                        ) ?? 0.0).toDouble(),
                                                                        totaltime:
                                                                            getJsonField(
                                                                          filterRecipeListItem,
                                                                          r'''$.totalCookTime''',
                                                                        ).toString(),
                                                                        favCondition: FFAppState().isLogin == true ? functions.checkFavOrNot(
                                                                                RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                    .favouriteRecipeList(
                                                                                      columnGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                    )
                                                                                    ?.toList(),
                                                                                getJsonField(
                                                                                  filterRecipeListItem,
                                                                                  r'''$._id''',
                                                                                ).toString()) ==
                                                                            true : false,
                                                                        onFavTap:
                                                                            () async {
                                                                          if (FFAppState().isLogin ==
                                                                              true) {
                                                                            if (functions.checkFavOrNot(
                                                                                    RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                        .favouriteRecipeList(
                                                                                          columnGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                        )
                                                                                        ?.toList(),
                                                                                    getJsonField(
                                                                                      filterRecipeListItem,
                                                                                      r'''$._id''',
                                                                                    ).toString()) ==
                                                                                true) {
                                                                              _model.filterPopularDelete = await RecipeAppGroup.deleteFavouriteRecipeApiCall.call(
                                                                                recipeId: getJsonField(
                                                                                  filterRecipeListItem,
                                                                                  r'''$._id''',
                                                                                ).toString(),
                                                                                token: FFAppState().token,
                                                                              );

                                                                              await actions.showCustomToastBottom(
                                                                                FFAppState().unFavText,
                                                                              );
                                                                            } else {
                                                                              _model.filterPopularAdd = await RecipeAppGroup.addFavouriteRecipeCall.call(
                                                                                recipeId: getJsonField(
                                                                                  filterRecipeListItem,
                                                                                  r'''$._id''',
                                                                                ).toString(),
                                                                                token: FFAppState().token,
                                                                              );

                                                                              await actions.showCustomToastBottom(
                                                                                FFAppState().favText,
                                                                              );
                                                                            }

                                                                            FFAppState().clearGetrFavouriteCacheCache();
                                                                          } else {
                                                                            FFAppState().favChange =
                                                                                true;
                                                                            FFAppState().recipeId =
                                                                                getJsonField(
                                                                              filterRecipeListItem,
                                                                              r'''$._id''',
                                                                            ).toString();
                                                                            FFAppState().update(() {});

                                                                            context.pushNamed('login_screen');
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        mainTap:
                                                                            () async {
                                                                          context
                                                                              .pushNamed(
                                                                            'recipe_detail_screen',
                                                                            queryParameters:
                                                                                {
                                                                              'recipeDetailId': serializeParam(
                                                                                getJsonField(
                                                                                  filterRecipeListItem,
                                                                                  r'''$._id''',
                                                                                ).toString(),
                                                                                ParamType.String,
                                                                              ),
                                                                              'name': serializeParam(
                                                                                getJsonField(
                                                                                  filterRecipeListItem,
                                                                                  r'''$.name''',
                                                                                ).toString(),
                                                                                ParamType.String,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        },
                                                                      );
                                                                    }),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return wrapWithModel(
                                                        model: _model
                                                            .noReceipeFilterYetContainerModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            const NoReceipeFilterYetContainerWidget(),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
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
                        const custom_widgets.Bannerwidget(
                          width: double.infinity,
                          height: 80.0,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
