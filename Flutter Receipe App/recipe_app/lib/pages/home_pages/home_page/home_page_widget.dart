import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/verified_email_dialog/verified_email_dialog_widget.dart';
import '/pages/fav_pages/fav_componant/fav_componant_widget.dart';
import '/pages/home_pages/home_page_componant/home_page_componant_widget.dart';
import '/pages/profile_page/profile_componant/profile_componant_widget.dart';
import '/pages/recipe_pages/recipe_componant/recipe_componant_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      print('[DEBUG] HomePage initState - postFrameCallback started');
      print('[DEBUG] isLogin: ${FFAppState().isLogin}');
      print('[DEBUG] token: ${FFAppState().token}');

      if (FFAppState().isLogin == true) {
        print('[DEBUG] Calling getUserApiCall...');
        _model.getUser = await RecipeAppGroup.getUserApiCall.call(
          token: FFAppState().token,
        );

        print('[DEBUG] getUserApiCall response:');
        print('[DEBUG] statusCode: ${_model.getUser?.statusCode}');
        print('[DEBUG] succeeded: ${_model.getUser?.succeeded}');
        print('[DEBUG] bodyText: ${_model.getUser?.bodyText}');

        FFAppState().countryCodeEdit =
            RecipeAppGroup.getUserApiCall.countryCode(
                  (_model.getUser?.jsonBody ?? ''),
                ) ??
                '';
        FFAppState().phone = RecipeAppGroup.getUserApiCall.phone(
              (_model.getUser?.jsonBody ?? ''),
            ) ??
            '';
        print('[DEBUG] Updated FFAppState with user data');
        FFAppState().update(() {});

        print('[DEBUG] Calling isVerifyAccountApiCall...');
        _model.isVerifiedCheck =
            await RecipeAppGroup.isVerifyAccountApiCall.call(
          email: RecipeAppGroup.getUserApiCall.email(
            (_model.getUser?.jsonBody ?? ''),
          ),
        );

        print('[DEBUG] isVerifyAccountApiCall response:');
        print('[DEBUG] statusCode: ${_model.isVerifiedCheck?.statusCode}');
        print('[DEBUG] succeeded: ${_model.isVerifiedCheck?.succeeded}');

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
                          ) ??
                          '',
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
                  ) ??
                  '';
          FFAppState().phone = RecipeAppGroup.getUserApiCall.phone(
                (_model.getUser?.jsonBody ?? ''),
              ) ??
              '';
          FFAppState().update(() {});
        }
      }
      await actions.rewardedVideoAdInitAction();
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
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('AIRecipeDebug');
            },
            backgroundColor: const Color(0xFF4CAF50),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 28,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (_model.selectIndex == 0) {
                        return SizedBox(
                          height: 200.0,
                          child: wrapWithModel(
                            model: _model.homePageComponantModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const HomePageComponantWidget(),
                          ),
                        );
                      } else if (_model.selectIndex == 1) {
                        return SizedBox(
                          height: 200.0,
                          child: wrapWithModel(
                            model: _model.favComponantModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const FavComponantWidget(),
                          ),
                        );
                      } else if (_model.selectIndex == 2) {
                        return SizedBox(
                          height: 200.0,
                          child: wrapWithModel(
                            model: _model.recipeComponantModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const RecipeComponantWidget(),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 200.0,
                          child: wrapWithModel(
                            model: _model.profileComponantModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const ProfileComponantWidget(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 26.0,
                        color: Color(0x14959595),
                        offset: Offset(
                          0.0,
                          -4.0,
                        ),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectIndex = 0;
                            safeSetState(() {});
                          },
                          child: Builder(
                            builder: (context) {
                              if (_model.selectIndex == 0) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/home_fill_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Home',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryTheme,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/home_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Home',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .black40,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectIndex = 1;
                            safeSetState(() {});
                          },
                          child: Builder(
                            builder: (context) {
                              if (_model.selectIndex == 1) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/Favorite_fill_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Favourite',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryTheme,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/Favorite_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Favourite',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .black40,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectIndex = 2;
                            safeSetState(() {});
                          },
                          child: Builder(
                            builder: (context) {
                              if (_model.selectIndex == 2) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/Recipev_fill_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Recipe',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryTheme,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/Recipe_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Recipe',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .black40,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectIndex = 3;
                            safeSetState(() {});
                          },
                          child: Builder(
                            builder: (context) {
                              if (_model.selectIndex == 3) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/profile_fill_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Profile',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryTheme,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: SvgPicture.asset(
                                        'assets/images/profile_img.svg',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Profile',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .black40,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
