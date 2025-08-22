import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/main_container/main_container_widget.dart';
import '/pages/componants/no_receipe_yet_container/no_receipe_yet_container_widget.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import '/pages/shimmers/shimmer_grid_view_component/shimmer_grid_view_component_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'recipe_componant_model.dart';
export 'recipe_componant_model.dart';

class RecipeComponantWidget extends StatefulWidget {
  const RecipeComponantWidget({super.key});

  @override
  State<RecipeComponantWidget> createState() => _RecipeComponantWidgetState();
}

class _RecipeComponantWidgetState extends State<RecipeComponantWidget> {
  late RecipeComponantModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeComponantModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: FFAppState().getrFavouriteCache(
        uniqueQueryKey: FFAppState().userId,
        requestFn: () => RecipeAppGroup.getAllFavouriteRecipesApiCall.call(
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
        final columnGetAllFavouriteRecipesApiResponse = snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrapWithModel(
              model: _model.singleAppbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const SingleAppbarWidget(
                text: 'Recipe',
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (FFAppState().connected) {
                    return FutureBuilder<ApiCallResponse>(
                      future: FFAppState()
                          .recommendedAllCache(
                        uniqueQueryKey: FFAppState().userId,
                        requestFn: () =>
                            RecipeAppGroup.getAllRecipeApiCall.call(
                          userId: FFAppState().userId,
                          token: FFAppState().token,
                        ),
                      )
                          .then((result) {
                        try {
                          _model.apiRequestCompleted = true;
                          _model.apiRequestLastUniqueKey = FFAppState().userId;
                        } finally {}
                        return result;
                      }),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: ShimmerGridViewComponentWidget(),
                            ),
                          );
                        }
                        final containerGetAllRecipeApiResponse = snapshot.data!;

                        return Container(
                          decoration: const BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              if (RecipeAppGroup.getAllRecipeApiCall.recipeList(
                                        containerGetAllRecipeApiResponse
                                            .jsonBody,
                                      ) !=
                                      null &&
                                  (RecipeAppGroup.getAllRecipeApiCall
                                          .recipeList(
                                    containerGetAllRecipeApiResponse.jsonBody,
                                  ) ?? [])
                                      .isNotEmpty) {
                                return Container(
                                  decoration: const BoxDecoration(),
                                  child: RefreshIndicator(
                                    key: const Key('RefreshIndicator_mjgzpos3'),
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    onRefresh: () async {
                                      safeSetState(() {
                                        FFAppState()
                                            .clearRecommendedAllCacheCacheKey(
                                                _model.apiRequestLastUniqueKey);
                                        _model.apiRequestCompleted = false;
                                      });
                                      await _model.waitForApiRequestCompleted();
                                    },
                                    child: ListView(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        16.0,
                                        0,
                                        16.0,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Builder(
                                            builder: (context) {
                                              final getAllRecipeLists =
                                                  RecipeAppGroup
                                                          .getAllRecipeApiCall
                                                          .recipeList(
                                                            containerGetAllRecipeApiResponse
                                                                .jsonBody,
                                                          )
                                                          ?.toList() ??
                                                      [];

                                              return Wrap(
                                                spacing: 16.0,
                                                runSpacing: 16.0,
                                                alignment: WrapAlignment.start,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                clipBehavior: Clip.none,
                                                children: List.generate(
                                                    getAllRecipeLists.length,
                                                    (getAllRecipeListsIndex) {
                                                  final getAllRecipeListsItem =
                                                      getAllRecipeLists[
                                                          getAllRecipeListsIndex];
                                                  return MainContainerWidget(
                                                    key: Key(
                                                        'Key6mk_${getAllRecipeListsIndex}_of_${getAllRecipeLists.length}'),
                                                    image:
                                                        '${FFAppConstants.imageUrl}${getJsonField(
                                                      getAllRecipeListsItem,
                                                      r'''$.image''',
                                                    ).toString()}',
                                                    name: getJsonField(
                                                      getAllRecipeListsItem,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    avreragerating:
                                                        (getJsonField(
                                                      getAllRecipeListsItem,
                                                      r'''$.averageRating''',
                                                    ) ?? 0.0).toDouble(),
                                                    totalReview: (getJsonField(
                                                      getAllRecipeListsItem,
                                                      r'''$.totalRating''',
                                                    ) ?? 0.0).toDouble(),
                                                    totaltime: getJsonField(
                                                      getAllRecipeListsItem,
                                                      r'''$.totalCookTime''',
                                                    ).toString(),
                                                    favCondition:
                                                        functions.checkFavOrNot(
                                                                RecipeAppGroup
                                                                    .getAllFavouriteRecipesApiCall
                                                                    .favouriteRecipeList(
                                                                      columnGetAllFavouriteRecipesApiResponse
                                                                          .jsonBody,
                                                                    )
                                                                    ?.toList(),
                                                                getJsonField(
                                                                  getAllRecipeListsItem,
                                                                  r'''$._id''',
                                                                ).toString()) ==
                                                            true,
                                                    onFavTap: () async {
                                                      if (FFAppState()
                                                              .isLogin ==
                                                          true) {
                                                        if (functions.checkFavOrNot(
                                                                RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                    .favouriteRecipeList(
                                                                      columnGetAllFavouriteRecipesApiResponse
                                                                          .jsonBody,
                                                                    )
                                                                    ?.toList(),
                                                                getJsonField(
                                                                  getAllRecipeListsItem,
                                                                  r'''$._id''',
                                                                ).toString()) ==
                                                            true) {
                                                          _model.popularDelete =
                                                              await RecipeAppGroup
                                                                  .deleteFavouriteRecipeApiCall
                                                                  .call(
                                                            recipeId:
                                                                getJsonField(
                                                              getAllRecipeListsItem,
                                                              r'''$._id''',
                                                            ).toString(),
                                                            token: FFAppState()
                                                                .token,
                                                          );

                                                          await actions
                                                              .showCustomToastBottom(
                                                            FFAppState()
                                                                .unFavText,
                                                          );
                                                        } else {
                                                          _model.popularAdd =
                                                              await RecipeAppGroup
                                                                  .addFavouriteRecipeCall
                                                                  .call(
                                                            recipeId:
                                                                getJsonField(
                                                              getAllRecipeListsItem,
                                                              r'''$._id''',
                                                            ).toString(),
                                                            token: FFAppState()
                                                                .token,
                                                          );

                                                          await actions
                                                              .showCustomToastBottom(
                                                            FFAppState()
                                                                .favText,
                                                          );
                                                        }

                                                        FFAppState()
                                                            .clearGetrFavouriteCacheCache();
                                                      } else {
                                                        FFAppState().favChange =
                                                            true;
                                                        FFAppState().recipeId =
                                                            getJsonField(
                                                          getAllRecipeListsItem,
                                                          r'''$._id''',
                                                        ).toString();
                                                        FFAppState()
                                                            .update(() {});

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
                                                              getAllRecipeListsItem,
                                                              r'''$._id''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'name':
                                                              serializeParam(
                                                            getJsonField(
                                                              getAllRecipeListsItem,
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
                                  ),
                                );
                              } else {
                                return wrapWithModel(
                                  model: _model.noReceipeYetContainerModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const NoReceipeYetContainerWidget(),
                                );
                              }
                            },
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
