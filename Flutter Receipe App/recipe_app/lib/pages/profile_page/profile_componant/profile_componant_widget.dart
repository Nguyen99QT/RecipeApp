import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/blank_componant/blank_componant_widget.dart';
import '/pages/componants/logout_dialog/logout_dialog_widget.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'profile_componant_model.dart';
export 'profile_componant_model.dart';

class ProfileComponantWidget extends StatefulWidget {
  const ProfileComponantWidget({super.key});

  @override
  State<ProfileComponantWidget> createState() => _ProfileComponantWidgetState();
}

class _ProfileComponantWidgetState extends State<ProfileComponantWidget> {
  late ProfileComponantModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileComponantModel());

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        wrapWithModel(
          model: _model.singleAppbarModel,
          updateCallback: () => safeSetState(() {}),
          child: const SingleAppbarWidget(
            text: 'Profile',
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (FFAppState().connected) {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: FFAppState().getUserCache(
                      uniqueQueryKey: FFAppState().userId,
                      requestFn: () => RecipeAppGroup.getUserApiCall.call(
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
                      final listViewGetUserApiResponse = snapshot.data!;

                      return ListView(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          16.0,
                          0,
                          16.0,
                        ),
                        scrollDirection: Axis.vertical,
                        children: [
                          if (FFAppState().isLogin == true)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, -1.0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            const Duration(milliseconds: 200),
                                        fadeOutDuration:
                                            const Duration(milliseconds: 200),
                                        imageUrl:
                                            '${FFAppConstants.imageUrl}${RecipeAppGroup.getUserApiCall.avatar(
                                          listViewGetUserApiResponse.jsonBody,
                                        )}',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                        errorWidget:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/error_image.png',
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (RecipeAppGroup.getUserApiCall.firstname(
                                            listViewGetUserApiResponse.jsonBody,
                                          ) !=
                                          null &&
                                      RecipeAppGroup.getUserApiCall.firstname(
                                            listViewGetUserApiResponse.jsonBody,
                                          ) !=
                                          '')
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 14.0, 0.0, 4.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            '${RecipeAppGroup.getUserApiCall.firstname(
                                              listViewGetUserApiResponse
                                                  .jsonBody,
                                            )}${RecipeAppGroup.getUserApiCall.lastname(
                                              listViewGetUserApiResponse
                                                  .jsonBody,
                                            )}',
                                            'WelCome',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryTextColor,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ),
                                    ),
                                  if (RecipeAppGroup.getUserApiCall.email(
                                            listViewGetUserApiResponse.jsonBody,
                                          ) !=
                                          null &&
                                      RecipeAppGroup.getUserApiCall.email(
                                            listViewGetUserApiResponse.jsonBody,
                                          ) !=
                                          '')
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          RecipeAppGroup.getUserApiCall.email(
                                            listViewGetUserApiResponse.jsonBody,
                                          ),
                                          'email',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SF Pro Display',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .black40,
                                              fontSize: 17.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: false,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 24.0, 0.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed('MyProfileScreen');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8.0, 8.0, 16.0, 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .samewhite,
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  child: SvgPicture.asset(
                                                    Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? 'assets/images/My_profile.svg'
                                                        : 'assets/images/My_profile.svg',
                                                    width: 24.0,
                                                    height: 24.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'My profile',
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
                                                                .sameBlack,
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: false,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: SvgPicture.asset(
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? 'assets/images/arrow_right.svg'
                                                      : 'assets/images/arrow_right.svg',
                                                  width: 20.0,
                                                  height: 20.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ].divide(
                                                const SizedBox(width: 16.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('settings_screen');
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).lightGrey,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 48.0,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .samewhite,
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: const AlignmentDirectional(
                                            0.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: SvgPicture.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? 'assets/images/Settings.svg'
                                                : 'assets/images/Settings.svg',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Settings',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .sameBlack,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: false,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        child: SvgPicture.asset(
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? 'assets/images/arrow_right.svg'
                                              : 'assets/images/arrow_right.svg',
                                          width: 20.0,
                                          height: 20.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ].divide(const SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) => Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (FFAppState().isLogin == true) {
                                    await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: const AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: const WebViewAware(
                                            child: LogoutDialogWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    context.pushNamed('login_screen');
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).lightGrey,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 16.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .samewhite,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: SvgPicture.asset(
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? 'assets/images/logout.svg'
                                                  : 'assets/images/logout.svg',
                                              width: 24.0,
                                              height: 24.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            FFAppState().isLogin == true
                                                ? 'Log out'
                                                : 'Log in',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'SF Pro Display',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .sameBlack,
                                                  fontSize: 17.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: false,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: SvgPicture.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? 'assets/images/arrow_right.svg'
                                                : 'assets/images/arrow_right.svg',
                                            width: 20.0,
                                            height: 20.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 16.0)),
                                    ),
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
                return Lottie.asset(
                  'assets/lottie_animations/No_Wifi.json',
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.contain,
                  animate: true,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
