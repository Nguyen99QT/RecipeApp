import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/shimmers/shimmer_recipe_detail/shimmer_recipe_detail_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'recipe_detail_screen_model.dart';
export 'recipe_detail_screen_model.dart';

class RecipeDetailScreenWidget extends StatefulWidget {
  const RecipeDetailScreenWidget({
    super.key,
    required this.recipeDetailId,
    required this.name,
  });

  final String? recipeDetailId;
  final String? name;

  @override
  State<RecipeDetailScreenWidget> createState() =>
      _RecipeDetailScreenWidgetState();
}

class _RecipeDetailScreenWidgetState extends State<RecipeDetailScreenWidget>
    with TickerProviderStateMixin {
  late RecipeDetailScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeDetailScreenModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, -50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, -50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 20.0.ms,
            duration: 1000.0.ms,
            color: FlutterFlowTheme.of(context).black20,
            angle: 0.524,
          ),
        ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 20.0.ms,
            duration: 1000.0.ms,
            color: FlutterFlowTheme.of(context).black20,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, -50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });

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

    return FutureBuilder<ApiCallResponse>(
      future: RecipeAppGroup.getRecipeByIdApiCall.call(
        userId: FFAppState().userId,
        recipeId: widget.recipeDetailId,
        token: FFAppState().token,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
            body: const Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ShimmerRecipeDetailWidget(),
              ),
            ),
          );
        }
        final recipeDetailScreenGetRecipeByIdApiResponse = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
            body: Builder(
              builder: (context) {
                if (FFAppState().connected) {
                  return FutureBuilder<ApiCallResponse>(
                    future: FFAppState().getrFavouriteCache(
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
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                16.0,
                              ),
                              scrollDirection: Axis.vertical,
                              children: [
                                SizedBox(
                                  height: 305.0,
                                  child: Stack(
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (RecipeAppGroup
                                                      .getRecipeByIdApiCall
                                                      .galleryList(
                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                        .jsonBody,
                                                  ) !=
                                                  null &&
                                              (RecipeAppGroup
                                                      .getRecipeByIdApiCall
                                                      .galleryList(
                                                recipeDetailScreenGetRecipeByIdApiResponse
                                                    .jsonBody,
                                              ) ?? [])
                                                  .isNotEmpty) {
                                            return Builder(
                                              builder: (context) {
                                                final galleryList =
                                                    RecipeAppGroup
                                                            .getRecipeByIdApiCall
                                                            .galleryList(
                                                              recipeDetailScreenGetRecipeByIdApiResponse
                                                                  .jsonBody,
                                                            )
                                                            ?.toList() ??
                                                        [];

                                                return SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: PageView.builder(
                                                    controller: _model
                                                            .pageViewController ??=
                                                        PageController(
                                                            initialPage: max(
                                                                0,
                                                                min(
                                                                    0,
                                                                    galleryList
                                                                            .length -
                                                                        1))),
                                                    onPageChanged: (_) async {
                                                      _model.pageviewIndex = _model
                                                          .pageViewCurrentIndex;
                                                      safeSetState(() {});
                                                    },
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        galleryList.length,
                                                    itemBuilder: (context,
                                                        galleryListIndex) {
                                                      final galleryListItem =
                                                          galleryList[
                                                              galleryListIndex];
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          fadeInDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          fadeOutDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          imageUrl:
                                                              '${FFAppConstants.imageUrl}$galleryListItem',
                                                          width:
                                                              double.infinity,
                                                          height: 305.0,
                                                          fit: BoxFit.cover,
                                                          alignment: const Alignment(
                                                              0.0, -1.0),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: CachedNetworkImage(
                                                fadeInDuration:
                                                    const Duration(milliseconds: 200),
                                                fadeOutDuration:
                                                    const Duration(milliseconds: 200),
                                                imageUrl:
                                                    '${FFAppConstants.imageUrl}${RecipeAppGroup.getRecipeByIdApiCall.image(
                                                  recipeDetailScreenGetRecipeByIdApiResponse
                                                      .jsonBody,
                                                )}',
                                                width: double.infinity,
                                                height: 305.0,
                                                fit: BoxFit.cover,
                                                alignment: const Alignment(0.0, -1.0),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      SafeArea(
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 21.0, 16.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.safePop();
                                                  },
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .samewhite,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  7.0,
                                                                  7.0,
                                                                  7.0,
                                                                  7.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/arrow_back.svg',
                                                          width: 24.0,
                                                          height: 24.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'containerOnPageLoadAnimation1']!),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (FFAppState().isLogin ==
                                                        true) {
                                                      if (functions
                                                              .checkFavOrNot(
                                                                  RecipeAppGroup
                                                                      .getAllFavouriteRecipesApiCall
                                                                      .favouriteRecipeList(
                                                                        columnGetAllFavouriteRecipesApiResponse
                                                                            .jsonBody,
                                                                      )
                                                                      ?.toList(),
                                                                  RecipeAppGroup
                                                                      .getRecipeByIdApiCall
                                                                      .recipeId(
                                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                                        .jsonBody,
                                                                  )) ==
                                                          true) {
                                                        _model.detailDelete =
                                                            await RecipeAppGroup
                                                                .deleteFavouriteRecipeApiCall
                                                                .call(
                                                          recipeId: RecipeAppGroup
                                                              .getRecipeByIdApiCall
                                                              .recipeId(
                                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                                .jsonBody,
                                                          ),
                                                          token: FFAppState()
                                                              .token,
                                                        );

                                                        await actions
                                                            .showCustomToastBottom(
                                                          FFAppState()
                                                              .unFavText,
                                                        );
                                                      } else {
                                                        _model.detailAdd =
                                                            await RecipeAppGroup
                                                                .addFavouriteRecipeCall
                                                                .call(
                                                          recipeId: RecipeAppGroup
                                                              .getRecipeByIdApiCall
                                                              .recipeId(
                                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                                .jsonBody,
                                                          ),
                                                          token: FFAppState()
                                                              .token,
                                                        );

                                                        await actions
                                                            .showCustomToastBottom(
                                                          FFAppState()
                                                              .unFavText,
                                                        );
                                                      }

                                                      FFAppState()
                                                          .clearGetrFavouriteCacheCache();
                                                    } else {
                                                      FFAppState().favChange =
                                                          true;
                                                      FFAppState().recipeId =
                                                          RecipeAppGroup
                                                              .getRecipeByIdApiCall
                                                              .recipeId(
                                                        recipeDetailScreenGetRecipeByIdApiResponse
                                                            .jsonBody,
                                                      ) ?? '';
                                                      FFAppState()
                                                          .update(() {});

                                                      context.pushNamed(
                                                          'login_screen');
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .samewhite,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (functions
                                                                .checkFavOrNot(
                                                                    RecipeAppGroup
                                                                        .getAllFavouriteRecipesApiCall
                                                                        .favouriteRecipeList(
                                                                          columnGetAllFavouriteRecipesApiResponse
                                                                              .jsonBody,
                                                                        )
                                                                        ?.toList(),
                                                                    RecipeAppGroup
                                                                        .getRecipeByIdApiCall
                                                                        .recipeId(
                                                                      recipeDetailScreenGetRecipeByIdApiResponse
                                                                          .jsonBody,
                                                                    )) ==
                                                            true) {
                                                          return ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/Heart_fill.svg',
                                                              width: 24.0,
                                                              height: 24.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          );
                                                        } else {
                                                          return ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child: Image.asset(
                                                              'assets/images/favourite_unlike.png',
                                                              width: 24.0,
                                                              height: 24.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'containerOnPageLoadAnimation2']!),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1.0, 1.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Opacity(
                                                opacity: 0.7,
                                                child: Container(
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .samewhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 6.0,
                                                                20.0, 6.0),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                (_model.pageViewCurrentIndex +
                                                                        1)
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .sameBlack,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: '/ ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .sameBlack,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                valueOrDefault<
                                                                    String>(
                                                              RecipeAppGroup
                                                                  .getRecipeByIdApiCall
                                                                  .galleryList(
                                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                                        .jsonBody,
                                                                  )
                                                                  ?.length
                                                                  .toString(),
                                                              '1',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .sameBlack,
                                                                  fontSize:
                                                                      13.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].addToStart(const SizedBox(width: 16.0)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      widget.name,
                                      'Name',
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SF Pro Display',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryTextColor,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: false,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                                if (valueOrDefault<String>(
                                          RecipeAppGroup.getRecipeByIdApiCall
                                              .cuisinesIdName(
                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                .jsonBody,
                                          ),
                                          '',
                                        ) !=
                                        '')
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        RecipeAppGroup.getRecipeByIdApiCall
                                            .cuisinesIdName(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        '',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryTheme,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ),
                                if (RecipeAppGroup.getRecipeByIdApiCall
                                        .averageRating(
                                      recipeDetailScreenGetRecipeByIdApiResponse
                                          .jsonBody,
                                    ) !=
                                    0)
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 8.0, 16.0, 16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 0.0),
                                          child: SvgPicture.asset(
                                            'assets/images/star_yellow.svg',
                                            width: 18.0,
                                            height: 18.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            RecipeAppGroup.getRecipeByIdApiCall
                                                .averageRating(
                                                  recipeDetailScreenGetRecipeByIdApiResponse
                                                      .jsonBody,
                                                )
                                                ?.toString(),
                                            '4.0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryTextColor,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: false,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                        Text(
                                          '(${formatNumber(
                                            RecipeAppGroup.getRecipeByIdApiCall
                                                .totalRating(
                                              recipeDetailScreenGetRecipeByIdApiResponse
                                                  .jsonBody,
                                            ),
                                            formatType: FormatType.compact,
                                          )} reviews)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryTextColor,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: false,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (valueOrDefault<String>(
                                          RecipeAppGroup.getRecipeByIdApiCall
                                              .overView(
                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                .jsonBody,
                                          ),
                                          'overView',
                                        ) !=
                                        '')
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: custom_widgets.ReadMoreHtml(
                                      width: double.infinity,
                                      height: 50.0,
                                      htmlContent: RecipeAppGroup
                                          .getRecipeByIdApiCall
                                          .overView(
                                        recipeDetailScreenGetRecipeByIdApiResponse
                                            .jsonBody,
                                      ),
                                      maxLength: 200,
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 114.0,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (valueOrDefault<String>(
                                                  RecipeAppGroup
                                                      .getRecipeByIdApiCall
                                                      .difficultyLevel(
                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                        .jsonBody,
                                                  ),
                                                  'difficultyLevel',
                                                ) !=
                                                '')
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 42.0,
                                                      height: 42.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .samewhite,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (RecipeAppGroup
                                                                  .getRecipeByIdApiCall
                                                                  .difficultyLevel(
                                                                recipeDetailScreenGetRecipeByIdApiResponse
                                                                    .jsonBody,
                                                              ) ==
                                                              'Easy') {
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/easy_level.svg',
                                                                width: 24.0,
                                                                height: 24.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ).animateOnPageLoad(
                                                                animationsMap[
                                                                    'imageOnPageLoadAnimation1']!);
                                                          } else if (RecipeAppGroup
                                                                  .getRecipeByIdApiCall
                                                                  .difficultyLevel(
                                                                recipeDetailScreenGetRecipeByIdApiResponse
                                                                    .jsonBody,
                                                              ) ==
                                                              'Medium') {
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/low_1.svg',
                                                                width: 24.0,
                                                                height: 24.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            );
                                                          } else {
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/challenge_1.svg',
                                                                width: 24.0,
                                                                height: 24.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Text(
                                                      '${valueOrDefault<String>(
                                                        RecipeAppGroup
                                                            .getRecipeByIdApiCall
                                                            .difficultyLevel(
                                                          recipeDetailScreenGetRecipeByIdApiResponse
                                                              .jsonBody,
                                                        ),
                                                        'difficultyLevel',
                                                      )} Level',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SF Pro Display',
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                false,
                                                            lineHeight: 1.5,
                                                          ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          const SizedBox(height: 4.0))
                                                      .addToStart(const SizedBox(
                                                          height: 11.0))
                                                      .addToEnd(const SizedBox(
                                                          height: 11.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (valueOrDefault<String>(
                                                  RecipeAppGroup
                                                      .getRecipeByIdApiCall
                                                      .servings(
                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                        .jsonBody,
                                                  ),
                                                  '1',
                                                ) !=
                                                '')
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 42.0,
                                                      height: 42.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .samewhite,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          RecipeAppGroup
                                                              .getRecipeByIdApiCall
                                                              .servings(
                                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                                .jsonBody,
                                                          ),
                                                          '1',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryTheme,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Serving person',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SF Pro Display',
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                false,
                                                            lineHeight: 1.5,
                                                          ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          const SizedBox(height: 4.0))
                                                      .addToStart(const SizedBox(
                                                          height: 11.0))
                                                      .addToEnd(const SizedBox(
                                                          height: 11.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (valueOrDefault<String>(
                                                  RecipeAppGroup
                                                      .getRecipeByIdApiCall
                                                      .totalCookTime(
                                                    recipeDetailScreenGetRecipeByIdApiResponse
                                                        .jsonBody,
                                                  ),
                                                  '0 Min',
                                                ) !=
                                                '')
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 42.0,
                                                      height: 42.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .samewhite,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/clock.svg',
                                                          width: 24.0,
                                                          height: 24.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'imageOnPageLoadAnimation2']!),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        RecipeAppGroup
                                                            .getRecipeByIdApiCall
                                                            .totalCookTime(
                                                          recipeDetailScreenGetRecipeByIdApiResponse
                                                              .jsonBody,
                                                        ),
                                                        '0 Min',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SF Pro Display',
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                false,
                                                            lineHeight: 1.5,
                                                          ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          const SizedBox(height: 4.0))
                                                      .addToStart(const SizedBox(
                                                          height: 11.0))
                                                      .addToEnd(const SizedBox(
                                                          height: 11.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ]
                                          .divide(const SizedBox(width: 12.0))
                                          .addToStart(const SizedBox(width: 16.0))
                                          .addToEnd(const SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                                if (RecipeAppGroup.getRecipeByIdApiCall
                                            .ingredients(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ) !=
                                        null &&
                                    (RecipeAppGroup.getRecipeByIdApiCall
                                            .ingredients(
                                      recipeDetailScreenGetRecipeByIdApiResponse
                                          .jsonBody,
                                    ) ?? [])
                                        .isNotEmpty)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: Text(
                                          'Ingredients',
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final howToCookList = RecipeAppGroup
                                                    .getRecipeByIdApiCall
                                                    .ingredients(
                                                      recipeDetailScreenGetRecipeByIdApiResponse
                                                          .jsonBody,
                                                    )
                                                    ?.toList() ??
                                                [];

                                            return ListView.builder(
                                              padding: const EdgeInsets.fromLTRB(
                                                0,
                                                16.0,
                                                0,
                                                16.0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: howToCookList.length,
                                              itemBuilder: (context,
                                                  howToCookListIndex) {
                                                final howToCookListItem =
                                                    howToCookList[
                                                        howToCookListIndex];
                                                return Text(
                                                  '•  $howToCookListItem',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: false,
                                                        lineHeight: 1.5,
                                                      ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ].addToStart(const SizedBox(height: 24.0)),
                                  ),
                                if (valueOrDefault<String>(
                                          RecipeAppGroup.getRecipeByIdApiCall
                                              .howtocook(
                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                .jsonBody,
                                          ),
                                          'overView',
                                        ) !=
                                        '')
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: Text(
                                          'How to cook',
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: custom_widgets.HtmlConverter(
                                          width: double.infinity,
                                          height: 50.0,
                                          text: RecipeAppGroup
                                              .getRecipeByIdApiCall
                                              .howtocook(
                                            recipeDetailScreenGetRecipeByIdApiResponse
                                                .jsonBody,
                                          ) ?? '',
                                        ),
                                      ),
                                    ].addToStart(const SizedBox(height: 16.0)),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 24.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (FFAppState().isLogin == true) {
                                  context.pushNamed(
                                    'video_step_screen',
                                    queryParameters: {
                                      'recipeDetailId': serializeParam(
                                        RecipeAppGroup.getRecipeByIdApiCall
                                            .recipeId(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        ParamType.String,
                                      ),
                                      'name': serializeParam(
                                        RecipeAppGroup.getRecipeByIdApiCall
                                            .name(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        ParamType.String,
                                      ),
                                      'videoPath': serializeParam(
                                        RecipeAppGroup.getRecipeByIdApiCall
                                            .video(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        ParamType.String,
                                      ),
                                      'urlPath': serializeParam(
                                        RecipeAppGroup.getRecipeByIdApiCall.url(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        ParamType.String,
                                      ),
                                      'overview': serializeParam(
                                        RecipeAppGroup.getRecipeByIdApiCall
                                            .overView(
                                          recipeDetailScreenGetRecipeByIdApiResponse
                                              .jsonBody,
                                        ),
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  FFAppState().recipeId =
                                      widget.recipeDetailId ?? '';
                                  FFAppState().favChange = true;
                                  FFAppState().update(() {});

                                  context.pushNamed('login_screen');
                                }
                              },
                              child: wrapWithModel(
                                model: _model.customAppButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const CustomAppButtonWidget(
                                  tittle: 'Start ',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).lightGrey,
                                  shape: BoxShape.circle,
                                ),
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: SvgPicture.asset(
                                    'assets/images/arrow_back.svg',
                                    width: 22.0,
                                    height: 22.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation3']!),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Lottie.asset(
                            'assets/lottie_animations/No_Wifi.json',
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.contain,
                            animate: true,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
