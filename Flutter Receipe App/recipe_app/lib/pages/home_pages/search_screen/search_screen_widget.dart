import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/pages/componants/main_container/main_container_widget.dart';
import '/pages/componants/no_receipe_filter_yet_container/no_receipe_filter_yet_container_widget.dart';
import '/pages/home_pages/filter_bottomsheet/filter_bottomsheet_widget.dart';
import '/pages/shimmers/shimmer_grid_view_component/shimmer_grid_view_component_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/utils/vietnamese_input_helper.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'search_screen_model.dart';
export 'search_screen_model.dart';

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({super.key});

  @override
  State<SearchScreenWidget> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  late SearchScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchScreenModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(
      () async {
        _model.focus = true;
        safeSetState(() {});
        safeSetState(() => _model.apiRequestCompleter2 = null);
        await _model.waitForApiRequestCompleted2();
      },
    );
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customAppbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomAppbarWidget(
                  text: 'Search',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).black20,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/images/search_dark_mode.svg'
                                : 'assets/images/search_icon.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController',
                            const Duration(
                                milliseconds:
                                    1000), // Reduced from 2000ms to 1000ms for faster response
                            () async {
                              print(
                                  '[DEBUG] Search text changed: "${_model.textController.text}"');
                              if (_model.textController.text == '') {
                                print(
                                    '[DEBUG] Search text is empty - showing all recipes');
                                _model.focus = false;
                                safeSetState(() {});
                                safeSetState(
                                    () => _model.apiRequestCompleter2 = null);
                                await _model.waitForApiRequestCompleted2();
                              } else {
                                print(
                                    '[DEBUG] Search text entered - filtering recipes');
                                _model.focus = true;
                                safeSetState(() {});
                                safeSetState(
                                    () => _model.apiRequestCompleter2 = null);
                                await _model.waitForApiRequestCompleted2();
                              }
                            },
                          ),
                          onFieldSubmitted: (_) async {
                            safeSetState(
                                () => _model.apiRequestCompleter2 = null);
                            await _model.waitForApiRequestCompleted2();
                          },
                          autofocus: true,
                          inputFormatters:
                              VietnameseInputHelper.vietnameseFormatters,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search recipes...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).black40,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: false,
                                ),
                            errorStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color:
                                      FlutterFlowTheme.of(context).errorColor,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: false,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).errorColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).errorColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).backgroundColor,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 15.0, 16.0, 15.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryTextColor,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: false,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 16.0, 0.0),
                        child: InkWell(
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
                                        FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: const SizedBox(
                                        height: 474.0,
                                        child: FilterBottomsheetWidget(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: SvgPicture.asset(
                              'assets/images/filter_svg.svg',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: FFAppState().getrFavouriteCache(
                    requestFn: () =>
                        RecipeAppGroup.getAllFavouriteRecipesApiCall.call(
                      token: FFAppState().token,
                    ),
                  ),
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
                    final containerGetAllFavouriteRecipesApiResponse =
                        snapshot.data!;

                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (FFAppState().connected) {
                            return Builder(
                              builder: (context) {
                                if (FFAppState().filterVariable == false) {
                                  return FutureBuilder<ApiCallResponse>(
                                    future: (_model.apiRequestCompleter2 ??=
                                            Completer<ApiCallResponse>()
                                              ..complete(RecipeAppGroup
                                                  .searchRecipesApiCall
                                                  .call(
                                                recipeName:
                                                    _model.textController.text,
                                                userId: FFAppState().userId,
                                                token: FFAppState().token,
                                              )))
                                        .future,
                                    builder: (context, snapshot) {
                                      // Add debug logging
                                      print(
                                          '[DEBUG] Search FutureBuilder state:');
                                      print('  - hasData: ${snapshot.hasData}');
                                      print(
                                          '  - hasError: ${snapshot.hasError}');
                                      print(
                                          '  - connectionState: ${snapshot.connectionState}');
                                      print(
                                          '  - search query: "${_model.textController.text}"');

                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        print(
                                            '[DEBUG] No data - showing loading/all recipes');
                                        return const Center(
                                          child: SizedBox(
                                            width: 0.0,
                                            height: 0.0,
                                            child: BlankComponantWidget(),
                                          ),
                                        );
                                      }
                                      final containerSearchRecipesApiResponse =
                                          snapshot.data!;

                                      // Debug API response
                                      print('[DEBUG] Search API Response:');
                                      print(
                                          '  - statusCode: ${containerSearchRecipesApiResponse.statusCode}');
                                      print(
                                          '  - succeeded: ${containerSearchRecipesApiResponse.succeeded}');
                                      if (containerSearchRecipesApiResponse
                                              .jsonBody !=
                                          null) {
                                        final recipeList = RecipeAppGroup
                                            .searchRecipesApiCall
                                            .recipeList(
                                                containerSearchRecipesApiResponse
                                                    .jsonBody);
                                        print(
                                            '  - recipes found: ${recipeList?.length ?? 0}');
                                      }

                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: const BoxDecoration(),
                                        child: Builder(
                                          builder: (context) {
                                            if (RecipeAppGroup
                                                        .searchRecipesApiCall
                                                        .recipeList(
                                                      containerSearchRecipesApiResponse
                                                          .jsonBody,
                                                    ) !=
                                                    null &&
                                                (RecipeAppGroup
                                                        .searchRecipesApiCall
                                                        .recipeList(
                                                  containerSearchRecipesApiResponse
                                                      .jsonBody,
                                                ))!
                                                    .isNotEmpty) {
                                              return RefreshIndicator(
                                                key: const Key(
                                                    'RefreshIndicator_60b5oz0y'),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter2 =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted2();
                                                },
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    0,
                                                    8.0,
                                                    0,
                                                    16.0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(16.0,
                                                              0.0, 16.0, 0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final recipeList =
                                                              RecipeAppGroup
                                                                      .searchRecipesApiCall
                                                                      .recipeList(
                                                                        containerSearchRecipesApiResponse
                                                                            .jsonBody,
                                                                      )
                                                                      ?.toList() ??
                                                                  [];

                                                          return Wrap(
                                                            spacing: 16.0,
                                                            runSpacing: 16.0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: List.generate(
                                                                recipeList
                                                                    .length,
                                                                (recipeListIndex) {
                                                              final recipeListItem =
                                                                  recipeList[
                                                                      recipeListIndex];
                                                              return MainContainerWidget(
                                                                key: Key(
                                                                    'Keybij_${recipeListIndex}_of_${recipeList.length}'),
                                                                image:
                                                                    '${FFAppConstants.imageUrl}${getJsonField(
                                                                  recipeListItem,
                                                                  r'''$.image''',
                                                                ).toString()}',
                                                                name:
                                                                    getJsonField(
                                                                  recipeListItem,
                                                                  r'''$.name''',
                                                                ).toString(),
                                                                avreragerating:
                                                                    (getJsonField(
                                                                              recipeListItem,
                                                                              r'''$.averageRating''',
                                                                            ) ??
                                                                            0.0)
                                                                        .toDouble(),
                                                                totalReview:
                                                                    (getJsonField(
                                                                              recipeListItem,
                                                                              r'''$.totalRating''',
                                                                            ) ??
                                                                            0.0)
                                                                        .toDouble(),
                                                                totaltime:
                                                                    getJsonField(
                                                                  recipeListItem,
                                                                  r'''$.totalCookTime''',
                                                                ).toString(),
                                                                favCondition: functions.checkFavOrNot(
                                                                        RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                            .favouriteRecipeList(
                                                                              containerGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                            )
                                                                            ?.toList(),
                                                                        getJsonField(
                                                                          recipeListItem,
                                                                          r'''$._id''',
                                                                        ).toString()) ==
                                                                    true,
                                                                onFavTap:
                                                                    () async {
                                                                  if (FFAppState()
                                                                          .isLogin ==
                                                                      true) {
                                                                    if (functions.checkFavOrNot(
                                                                            RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                .favouriteRecipeList(
                                                                                  containerGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                )
                                                                                ?.toList(),
                                                                            getJsonField(
                                                                              recipeListItem,
                                                                              r'''$._id''',
                                                                            ).toString()) ==
                                                                        true) {
                                                                      _model.popularDelete = await RecipeAppGroup
                                                                          .deleteFavouriteRecipeApiCall
                                                                          .call(
                                                                        recipeId:
                                                                            getJsonField(
                                                                          recipeListItem,
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
                                                                      _model.popularAdd = await RecipeAppGroup
                                                                          .addFavouriteRecipeCall
                                                                          .call(
                                                                        recipeId:
                                                                            getJsonField(
                                                                          recipeListItem,
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
                                                                    FFAppState()
                                                                            .favChange =
                                                                        true;
                                                                    FFAppState()
                                                                            .recipeId =
                                                                        getJsonField(
                                                                      recipeListItem,
                                                                      r'''$._id''',
                                                                    ).toString();
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});

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
                                                                          recipeListItem,
                                                                          r'''$._id''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'name':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          recipeListItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
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
                                                    .noReceipeFilterYetContainerModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child:
                                                    const NoReceipeFilterYetContainerWidget(),
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
                                        cuisinesIdList: FFAppState().cuisinesId,
                                        userId: FFAppState().userId,
                                        token: FFAppState().token,
                                      ),
                                    )
                                        .then((result) {
                                      _model.apiRequestCompleted1 = true;
                                      return result;
                                    }),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return const ShimmerGridViewComponentWidget();
                                      }
                                      final containerFilterRecipeApiResponse =
                                          snapshot.data!;

                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: const BoxDecoration(),
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
                                                    'RefreshIndicator_n7y0r1af'),
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    0,
                                                    16.0,
                                                    0,
                                                    16.0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(16.0,
                                                              0.0, 16.0, 0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final filterRecipeSearchList =
                                                              RecipeAppGroup
                                                                      .filterRecipeApiCall
                                                                      .filteredRecipesList(
                                                                        containerFilterRecipeApiResponse
                                                                            .jsonBody,
                                                                      )
                                                                      ?.toList() ??
                                                                  [];

                                                          return Wrap(
                                                            spacing: 16.0,
                                                            runSpacing: 16.0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: List.generate(
                                                                filterRecipeSearchList
                                                                    .length,
                                                                (filterRecipeSearchListIndex) {
                                                              final filterRecipeSearchListItem =
                                                                  filterRecipeSearchList[
                                                                      filterRecipeSearchListIndex];
                                                              return MainContainerWidget(
                                                                key: Key(
                                                                    'Key51t_${filterRecipeSearchListIndex}_of_${filterRecipeSearchList.length}'),
                                                                image:
                                                                    '${FFAppConstants.imageUrl}${getJsonField(
                                                                  filterRecipeSearchListItem,
                                                                  r'''$.image''',
                                                                ).toString()}',
                                                                name:
                                                                    getJsonField(
                                                                  filterRecipeSearchListItem,
                                                                  r'''$.name''',
                                                                ).toString(),
                                                                avreragerating:
                                                                    (getJsonField(
                                                                              filterRecipeSearchListItem,
                                                                              r'''$.averageRating''',
                                                                            ) ??
                                                                            0.0)
                                                                        .toDouble(),
                                                                totalReview:
                                                                    (getJsonField(
                                                                              filterRecipeSearchListItem,
                                                                              r'''$.totalRating''',
                                                                            ) ??
                                                                            0.0)
                                                                        .toDouble(),
                                                                totaltime:
                                                                    getJsonField(
                                                                  filterRecipeSearchListItem,
                                                                  r'''$.totalCookTime''',
                                                                ).toString(),
                                                                favCondition: functions.checkFavOrNot(
                                                                        RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                            .favouriteRecipeList(
                                                                              containerGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                            )
                                                                            ?.toList(),
                                                                        getJsonField(
                                                                          filterRecipeSearchListItem,
                                                                          r'''$._id''',
                                                                        ).toString()) ==
                                                                    true,
                                                                onFavTap:
                                                                    () async {
                                                                  if (FFAppState()
                                                                          .isLogin ==
                                                                      true) {
                                                                    if (functions.checkFavOrNot(
                                                                            RecipeAppGroup.getAllFavouriteRecipesApiCall
                                                                                .favouriteRecipeList(
                                                                                  containerGetAllFavouriteRecipesApiResponse.jsonBody,
                                                                                )
                                                                                ?.toList(),
                                                                            getJsonField(
                                                                              filterRecipeSearchListItem,
                                                                              r'''$._id''',
                                                                            ).toString()) ==
                                                                        true) {
                                                                      _model.filterPopularDelete = await RecipeAppGroup
                                                                          .deleteFavouriteRecipeApiCall
                                                                          .call(
                                                                        recipeId:
                                                                            getJsonField(
                                                                          filterRecipeSearchListItem,
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
                                                                      _model.filterPopularAdd = await RecipeAppGroup
                                                                          .addFavouriteRecipeCall
                                                                          .call(
                                                                        recipeId:
                                                                            getJsonField(
                                                                          filterRecipeSearchListItem,
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
                                                                    FFAppState()
                                                                            .favChange =
                                                                        true;
                                                                    FFAppState()
                                                                            .recipeId =
                                                                        getJsonField(
                                                                      filterRecipeSearchListItem,
                                                                      r'''$._id''',
                                                                    ).toString();
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});

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
                                                                          filterRecipeSearchListItem,
                                                                          r'''$._id''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'name':
                                                                          serializeParam(
                                                                        '',
                                                                        ParamType
                                                                            .String,
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
                                                    .noReceipeFilterYetContainerModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child:
                                                    const NoReceipeFilterYetContainerWidget(),
                                              );
                                            }
                                          },
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
