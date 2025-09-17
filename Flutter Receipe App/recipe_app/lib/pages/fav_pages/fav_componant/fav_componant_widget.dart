import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/main_container/main_container_widget.dart';
import '/pages/componants/nofavorite_yet_container/nofavorite_yet_container_widget.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'fav_componant_model.dart';
export 'fav_componant_model.dart';

class FavComponantWidget extends StatefulWidget {
  const FavComponantWidget({super.key});

  @override
  State<FavComponantWidget> createState() => _FavComponantWidgetState();
}

class _FavComponantWidgetState extends State<FavComponantWidget> {
  late FavComponantModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavComponantModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wrapWithModel(
          model: _model.singleAppbarModel,
          updateCallback: () => safeSetState(() {}),
          child: const SingleAppbarWidget(
            text: 'Favourite',
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (FFAppState().connected) {
                return Builder(
                  builder: (context) {
                    if (FFAppState().isLogin == true) {
                      return FutureBuilder<ApiCallResponse>(
                        future: FFAppState()
                            .getrFavouriteCache(
                          uniqueQueryKey: FFAppState().userId,
                          requestFn: () =>
                              RecipeAppGroup.getAllFavouriteRecipesApiCall.call(
                            token: FFAppState().token,
                          ),
                        )
                            .then((result) {
                          try {
                            _model.apiRequestCompleted = true;
                            _model.apiRequestLastUniqueKey =
                                FFAppState().userId;
                          } finally {}
                          return result;
                        }),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primaryTheme,
                                  ),
                                ),
                              ),
                            );
                          }
                          final listViewGetAllFavouriteRecipesApiResponse =
                              snapshot.data!;

                          return RefreshIndicator(
                            key: const Key('RefreshIndicator_7ckdc2x2'),
                            color: FlutterFlowTheme.of(context).tertiary,
                            onRefresh: () async {
                              safeSetState(() {
                                FFAppState().clearGetrFavouriteCacheCacheKey(
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final favoriteList = RecipeAppGroup
                                              .getAllFavouriteRecipesApiCall
                                              .favouriteRecipeList(
                                                listViewGetAllFavouriteRecipesApiResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];
                                      if (favoriteList.isEmpty) {
                                        return Center(
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.8,
                                            child:
                                                const NofavoriteYetContainerWidget(),
                                          ),
                                        );
                                      }

                                      return Wrap(
                                        spacing: 16.0,
                                        runSpacing: 16.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children:
                                            List.generate(favoriteList.length,
                                                (favoriteListIndex) {
                                          final favoriteListItem =
                                              favoriteList[favoriteListIndex];
                                          return MainContainerWidget(
                                            key: Key(
                                                'Keyzyb_${favoriteListIndex}_of_${favoriteList.length}'),
                                            image:
                                                '${FFAppConstants.imageUrl}${getJsonField(
                                              favoriteListItem,
                                              r'''$.recipeId.image''',
                                            ).toString()}',
                                            name: getJsonField(
                                              favoriteListItem,
                                              r'''$.recipeId.name''',
                                            ).toString(),
                                            avreragerating: (getJsonField(
                                              favoriteListItem,
                                              r'''$.recipeId.averageRating''',
                                            ) ?? 0.0).toDouble(),
                                            totalReview: (getJsonField(
                                              favoriteListItem,
                                              r'''$.recipeId.totalRating''',
                                            ) ?? 0.0).toDouble(),
                                            totaltime: getJsonField(
                                              favoriteListItem,
                                              r'''$.recipeId.totalCookTime''',
                                            ).toString(),
                                            favCondition: true,
                                            onFavTap: () async {
                                              if (FFAppState().isLogin ==
                                                  true) {
                                                _model.popularDelete =
                                                    await RecipeAppGroup
                                                        .deleteFavouriteRecipeApiCall
                                                        .call(
                                                  recipeId: getJsonField(
                                                    favoriteListItem,
                                                    r'''$.recipeId._id''',
                                                  ).toString(),
                                                  token: FFAppState().token,
                                                );

                                                await actions
                                                    .showCustomToastBottom(
                                                  FFAppState().unFavText,
                                                );
                                                FFAppState()
                                                    .clearGetrFavouriteCacheCache();
                                              } else {
                                                FFAppState().favChange = true;
                                                FFAppState().recipeId =
                                                    getJsonField(
                                                  favoriteListItem,
                                                  r'''$.recipeId._id''',
                                                ).toString();
                                                FFAppState().update(() {});

                                                context
                                                    .pushNamed('login_screen');
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
                                                      favoriteListItem,
                                                      r'''$.recipeId._id''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'name': serializeParam(
                                                    getJsonField(
                                                      favoriteListItem,
                                                      r'''$.recipeId.name''',
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
                        },
                      );
                    } else {
                      return wrapWithModel(
                        model: _model.nofavoriteYetContainerModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const NofavoriteYetContainerWidget(),
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
      ],
    );
  }
}
