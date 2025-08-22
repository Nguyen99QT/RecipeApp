import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'splash_screen_model.dart';
export 'splash_screen_model.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      print('Splash screen callback started');
      await Future.delayed(const Duration(milliseconds: 1000));
      print('Delay completed, getting device ID');
      _model.id = await actions.getDeviceId();
      print('Device ID: ${_model.id}');
      await actions.getCountryCode();
      print('Country code retrieved');
      
      print('Calling getAdmobApi...');
      _model.getMobApi = await RecipeAppGroup.getAdmobApiCall.call();
      print('AdMob API response: ${_model.getMobApi?.jsonBody}');

      FFAppState().anbanner = RecipeAppGroup.getAdmobApiCall.androidbanneradid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().iobanner = RecipeAppGroup.getAdmobApiCall.iosbanneradid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().anInterstitial =
          RecipeAppGroup.getAdmobApiCall.androidinterstitialadid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().ioInterstitial =
          RecipeAppGroup.getAdmobApiCall.iosinterstitialadid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().AndroidAdmobId =
          'ca-app-pub-3940256099942544~${RecipeAppGroup.getAdmobApiCall.androidappadid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? ''}';
      FFAppState().IosAdmobId =
          ' ca-app-pub-3940256099942544~${RecipeAppGroup.getAdmobApiCall.iosappadid(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? ''}';
      FFAppState().rewardedVideoAndroidId =
          RecipeAppGroup.getAdmobApiCall.androidrewardedads(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().rewardedVideoIOSId =
          RecipeAppGroup.getAdmobApiCall.iosrewardedads(
        (_model.getMobApi?.jsonBody ?? ''),
      ) ?? '';
      FFAppState().update(() {});
      try {
        print('Navigation check: intro=${FFAppState().intro}, isLogin=${FFAppState().isLogin}');
        if (FFAppState().intro == true) {
          if (FFAppState().isLogin == true) {
            print('Navigating to HomePage');
            context.goNamed('HomePage');
          } else {
            print('Navigating to login_screen');
            context.goNamed('login_screen');
          }
        } else {
          print('Navigating to intro_screen');
          context.goNamed('intro_screen');
        }
      } catch (e) {
        print('Navigation error: $e');
        // Fallback navigation
        context.goNamed('intro_screen');
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryTheme,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryTheme,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 98.0,
                    height: 98.0,
                    fit: BoxFit.contain,
                  ),
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              ),
              Text(
                'Recipe',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).primaryTheme,
                      fontSize: 34.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts: false,
                      lineHeight: 1.5,
                    ),
              ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
            ],
          ),
        ),
      ),
    );
  }
}
