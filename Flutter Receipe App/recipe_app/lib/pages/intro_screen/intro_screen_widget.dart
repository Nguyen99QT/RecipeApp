import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'intro_screen_model.dart';
export 'intro_screen_model.dart';

class IntroScreenWidget extends StatefulWidget {
  const IntroScreenWidget({super.key});

  @override
  State<IntroScreenWidget> createState() => _IntroScreenWidgetState();
}

class _IntroScreenWidgetState extends State<IntroScreenWidget> {
  late IntroScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IntroScreenModel());

    // Initialize AdMob data if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeAdMob();
      safeSetState(() {});
    });
  }

  Future<void> _initializeAdMob() async {
    try {
      print('Loading AdMob configuration...');
      final admobResponse = await RecipeAppGroup.getAdmobApiCall.call();
      
      if (admobResponse.succeeded) {
        FFAppState().anbanner = RecipeAppGroup.getAdmobApiCall.androidbanneradid(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().iobanner = RecipeAppGroup.getAdmobApiCall.iosbanneradid(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().anInterstitial =
            RecipeAppGroup.getAdmobApiCall.androidinterstitialadid(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().ioInterstitial =
            RecipeAppGroup.getAdmobApiCall.iosinterstitialadid(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().AndroidAdmobId =
            'ca-app-pub-3940256099942544~${RecipeAppGroup.getAdmobApiCall.androidappadid(
          admobResponse.jsonBody,
        ) ?? ''}';
        FFAppState().IosAdmobId =
            'ca-app-pub-3940256099942544~${RecipeAppGroup.getAdmobApiCall.iosappadid(
          admobResponse.jsonBody,
        ) ?? ''}';
        FFAppState().rewardedVideoAndroidId =
            RecipeAppGroup.getAdmobApiCall.androidrewardedads(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().rewardedVideoIOSId =
            RecipeAppGroup.getAdmobApiCall.iosrewardedads(
          admobResponse.jsonBody,
        ) ?? '';
        FFAppState().update(() {});
        print('AdMob configuration loaded successfully');
      } else {
        print('Failed to load AdMob configuration');
      }
    } catch (e) {
      print('Error loading AdMob configuration: $e');
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    print('[DEBUG] IntroScreenWidget build() called');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (FFAppState().connected) {
                return Visibility(
                  visible:
                      true /* Warning: Trying to access variable not yet defined. */,
                  child: FutureBuilder<ApiCallResponse>(
                    future: _model.introCache(
                      requestFn: () => RecipeAppGroup.getAllIntroApiCall.call(),
                    ),
                    builder: (context, snapshot) {
                      // Debug logs
                      print('[DEBUG] FutureBuilder state:');
                      print('  - hasData: ${snapshot.hasData}');
                      print('  - hasError: ${snapshot.hasError}');
                      print('  - connectionState: ${snapshot.connectionState}');
                      
                      if (snapshot.hasError) {
                        print('  - error: ${snapshot.error}');
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        print('  - Loading data...');
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
                      final stackGetAllIntroApiResponse = snapshot.data!;
                      print('  - API Response received:');
                      print('    statusCode: ${stackGetAllIntroApiResponse.statusCode}');
                      print('    succeeded: ${stackGetAllIntroApiResponse.succeeded}');
                      print('    bodyText: ${stackGetAllIntroApiResponse.bodyText}');

                      return Stack(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        children: [
                          Builder(
                            builder: (context) {
                              final introList =
                                  RecipeAppGroup.getAllIntroApiCall
                                          .introList(
                                            stackGetAllIntroApiResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                              return SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      controller: _model.pageViewController ??=
                                          PageController(
                                              initialPage: max(
                                                  0,
                                                  min(0,
                                                      introList.length - 1))),
                                      onPageChanged: (_) async {
                                        FFAppState().introIndex =
                                            _model.pageViewCurrentIndex;
                                        safeSetState(() {});
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: introList.length,
                                      itemBuilder: (context, introListIndex) {
                                        final introListItem =
                                            introList[introListIndex];
                                        return Stack(
                                          alignment:
                                              const AlignmentDirectional(0.0, 1.0),
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: CachedNetworkImage(
                                                  fadeInDuration: const Duration(
                                                      milliseconds: 200),
                                                  fadeOutDuration: const Duration(
                                                      milliseconds: 200),
                                                  imageUrl:
                                                      '${FFAppConstants.imageUrl}${getJsonField(
                                                    introListItem,
                                                    r'''$.image''',
                                                  ).toString()}',
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.65,
                                                  fit: BoxFit.fill,
                                                  alignment:
                                                      const Alignment(0.0, -1.0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Container(
                                                width: double.infinity,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.42,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    bottomRight:
                                                        Radius.circular(0.0),
                                                    topLeft:
                                                        Radius.circular(24.0),
                                                    topRight:
                                                        Radius.circular(24.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(20.0, 24.0,
                                                          20.0, 150.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              introListItem,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 22.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 26.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return 26.0;
                                                                    } else {
                                                                      return 28.0;
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      false,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.39),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              introListItem,
                                                              r'''$.description''',
                                                            ).toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SF Pro Display',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      false,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        const SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 135.0),
                                        child: smooth_page_indicator
                                            .SmoothPageIndicator(
                                          controller:
                                              _model.pageViewController ??=
                                                  PageController(
                                                      initialPage: max(
                                                          0,
                                                          min(
                                                              0,
                                                              introList.length -
                                                                  1))),
                                          count: introList.length,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) async {
                                            await _model.pageViewController!
                                                .animateToPage(
                                              i,
                                              duration:
                                                  const Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                            safeSetState(() {});
                                          },
                                          effect: smooth_page_indicator
                                              .ExpandingDotsEffect(
                                            expansionFactor: 3.0,
                                            spacing: 6.0,
                                            radius: 16.0,
                                            dotWidth: 7.0,
                                            dotHeight: 7.0,
                                            dotColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryTheme,
                                            activeDotColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryTheme,
                                            paintStyle: PaintingStyle.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 60.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (FFAppState().introIndex ==
                                    (RecipeAppGroup.getAllIntroApiCall
                                            .introList(
                                              stackGetAllIntroApiResponse
                                                  .jsonBody,
                                            )!
                                            .length -
                                        1)) {
                                  FFAppState().intro = true;
                                  FFAppState().update(() {});

                                  context.goNamed('login_screen');
                                } else {
                                  await _model.pageViewController?.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              child: wrapWithModel(
                                model: _model.customAppButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: CustomAppButtonWidget(
                                  tittle: FFAppState().introIndex ==
                                          (RecipeAppGroup.getAllIntroApiCall
                                                  .introList(
                                                    stackGetAllIntroApiResponse
                                                        .jsonBody,
                                                  )!
                                                  .length -
                                              1)
                                      ? 'Get started'
                                      : 'Next',
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: FFAppState().introIndex ==
                                    (RecipeAppGroup.getAllIntroApiCall
                                            .introList(
                                              stackGetAllIntroApiResponse
                                                  .jsonBody,
                                            )!
                                            .length -
                                        1)
                                ? 0.0
                                : 1.0,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().intro = true;
                                  FFAppState().update(() {});

                                  context.goNamed('login_screen');
                                },
                                child: Text(
                                  'Skip',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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
      ),
    );
  }
}
