import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/pages/componants/rate_us_bottomsheet/rate_us_bottomsheet_widget.dart';
import '/pages/componants/verified_email_dialog/verified_email_dialog_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'video_step_screen_model.dart';
export 'video_step_screen_model.dart';

class VideoStepScreenWidget extends StatefulWidget {
  const VideoStepScreenWidget({
    super.key,
    this.recipeDetailId,
    this.name,
    this.videoPath,
    this.urlPath,
    this.overview,
  });

  final String? recipeDetailId;
  final String? name;
  final String? videoPath;
  final String? urlPath;
  final String? overview;

  @override
  State<VideoStepScreenWidget> createState() => _VideoStepScreenWidgetState();
}

class _VideoStepScreenWidgetState extends State<VideoStepScreenWidget>
    with TickerProviderStateMixin {
  late VideoStepScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoStepScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.interstiaslAds();
      _model.getUser = await RecipeAppGroup.getUserApiCall.call(
        token: FFAppState().token,
      );

      FFAppState().countryCodeEdit = RecipeAppGroup.getUserApiCall.countryCode(
        (_model.getUser?.jsonBody ?? ''),
      )!;
      FFAppState().phone = RecipeAppGroup.getUserApiCall.phone(
        (_model.getUser?.jsonBody ?? ''),
      )!;
      FFAppState().update(() {});
      _model.isVerifiedCheck = await RecipeAppGroup.isVerifyAccountApiCall.call(
        email: RecipeAppGroup.getUserApiCall.email(
          (_model.getUser?.jsonBody ?? ''),
        ),
      );

      if (RecipeAppGroup.isVerifyAccountApiCall.success(
            (_model.isVerifiedCheck?.jsonBody ?? ''),
          ) ==
          0) {
        await showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: const AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: WebViewAware(
                child: GestureDetector(
                  onTap: () => FocusScope.of(dialogContext).unfocus(),
                  child: VerifiedEmailDialogWidget(
                    email: RecipeAppGroup.getUserApiCall.email(
                      (_model.getUser?.jsonBody ?? ''),
                    )!,
                  ),
                ),
              ),
            );
          },
        );
      } else {
        FFAppState().countryCodeEdit =
            RecipeAppGroup.getUserApiCall.countryCode(
          (_model.getUser?.jsonBody ?? ''),
        )!;
        FFAppState().phone = RecipeAppGroup.getUserApiCall.phone(
          (_model.getUser?.jsonBody ?? ''),
        )!;
        FFAppState().update(() {});
      }
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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

    return Builder(
      builder: (context) => YoutubeFullScreenWrapper(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  if (FFAppState().connected) {
                    return FutureBuilder<ApiCallResponse>(
                      future: RecipeAppGroup.getAdmobApiCall.call(),
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
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wrapWithModel(
                                model: _model.customAppbarModel,
                                updateCallback: () => safeSetState(() {}),
                                child: CustomAppbarWidget(
                                  text: widget.name,
                                ),
                              ),
                              Expanded(
                                child: FutureBuilder<ApiCallResponse>(
                                  future: FFAppState().recipeDetailCache(
                                    uniqueQueryKey: FFAppState().recipeId,
                                    requestFn: () => RecipeAppGroup
                                        .getRecipeByIdApiCall
                                        .call(
                                      userId: FFAppState().userId,
                                      recipeId: widget.recipeDetailId,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primaryTheme,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: ListView(
                                                padding: const EdgeInsets.fromLTRB(
                                                  0,
                                                  16.0,
                                                  0,
                                                  16.0,
                                                ),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (widget.videoPath ==
                                                              null ||
                                                          widget.videoPath ==
                                                              '') {
                                                        // Build proper YouTube URL from urlPath
                                                        String youtubeUrl = '';
                                                        if (widget.urlPath != null && widget.urlPath!.isNotEmpty) {
                                                          // Check if it's already a full URL
                                                          if (widget.urlPath!.startsWith('http')) {
                                                            youtubeUrl = widget.urlPath!;
                                                          } else {
                                                            // Extract video ID and create proper URL
                                                            String videoId = widget.urlPath!;
                                                            if (videoId.contains('&')) {
                                                              videoId = videoId.split('&')[0];
                                                            }
                                                            youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
                                                          }
                                                        }
                                                        
                                                        print('[DEBUG] YouTube URL for player: $youtubeUrl');
                                                        
                                                        return FlutterFlowYoutubePlayer(
                                                          url: youtubeUrl,
                                                          width:
                                                              double.infinity,
                                                          height: 269.0,
                                                          autoPlay: false,
                                                          looping: false,
                                                          mute: false,
                                                          showControls: true,
                                                          showFullScreen: true,
                                                          strictRelatedVideos:
                                                              false,
                                                        );
                                                      } else {
                                                        return FlutterFlowVideoPlayer(
                                                          path:
                                                              '${FFAppConstants.videoUrl}${widget.videoPath}',
                                                          videoType:
                                                              VideoType.network,
                                                          width:
                                                              double.infinity,
                                                          height: 269.0,
                                                          autoPlay: false,
                                                          looping: true,
                                                          showControls: true,
                                                          allowFullScreen: true,
                                                          allowPlaybackSpeedMenu:
                                                              false,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  if (widget.overview !=
                                                          null &&
                                                      widget.overview != '')
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      16.0,
                                                                      0.0,
                                                                      16.0),
                                                          child: Text(
                                                            'How to cook',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryTextColor,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      false,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                        custom_widgets
                                                            .HtmlConverter(
                                                          width:
                                                              double.infinity,
                                                          height: 50.0,
                                                          text: valueOrDefault<
                                                              String>(
                                                            widget.overview,
                                                            'overView',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 12.0, 16.0, 24.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                print('[DEBUG] Review button tapped! Showing Review bottomsheet directly...');
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child:
                                                          GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: SizedBox(
                                                            height: 552.0,
                                                            child:
                                                                RateUsBottomsheetWidget(
                                                              rateId: widget
                                                                  .recipeDetailId,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: wrapWithModel(
                                                model:
                                                    _model.customAppButtonModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: const CustomAppButtonWidget(
                                                  tittle: 'Review',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                    color:
                                        FlutterFlowTheme.of(context).lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        7.0, 7.0, 7.0, 7.0),
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
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
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
          ),
        ),
      ),
    );
  }
}
