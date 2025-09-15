import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/pages/home_pages/ai_recipe_search/ai_recipe_search_simple_widget.dart';
import '/pages/ai_recipe_pages/my_ai_recipes/my_ai_recipes_widget.dart';
import '/ai_recipe_debug_page.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/introScreen',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => const IntroScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => const IntroScreenWidget(),
        ),
        FFRoute(
          name: 'HomePage',
          path: '/homePage',
          builder: (context, params) => const HomePageWidget(),
        ),
        FFRoute(
          name: 'AiRecipeSearch',
          path: '/aiRecipeSearch',
          builder: (context, params) => const AiRecipeSearchWidget(),
        ),
        FFRoute(
          name: 'MyAiRecipes',
          path: '/myAiRecipes',
          builder: (context, params) => const MyAiRecipesWidget(),
        ),
        FFRoute(
          name: 'AIRecipeDebug',
          path: '/aiRecipeDebug',
          builder: (context, params) => const AIRecipeDebugPage(),
        ),
        FFRoute(
          name: 'Splash_screen',
          path: '/splashScreen',
          builder: (context, params) => const SplashScreenWidget(),
        ),
        FFRoute(
          name: 'intro_screen',
          path: '/introScreen',
          builder: (context, params) => const IntroScreenWidget(),
        ),
        FFRoute(
          name: 'login_screen',
          path: '/loginScreen',
          builder: (context, params) => const LoginScreenWidget(),
        ),
        FFRoute(
          name: 'signup_screen',
          path: '/signupScreen',
          builder: (context, params) => const SignupScreenWidget(),
        ),
        FFRoute(
          name: 'forgot_screen',
          path: '/forgotScreen',
          builder: (context, params) => const ForgotScreenWidget(),
        ),
        FFRoute(
          name: 'verification_screen',
          path: '/verificationScreen',
          builder: (context, params) => VerificationScreenWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
            password: params.getParam(
              'password',
              ParamType.String,
            ),
            deviceId: params.getParam(
              'deviceId',
              ParamType.String,
            ),
            registrationToken: params.getParam(
              'registrationToken',
              ParamType.String,
            ),
            firstName: params.getParam(
              'firstName',
              ParamType.String,
            ),
            lastName: params.getParam(
              'lastName',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'resetpassword_screen',
          path: '/resetpasswordScreen',
          builder: (context, params) => ResetpasswordScreenWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'search_screen',
          path: '/searchScreen',
          builder: (context, params) => const SearchScreenWidget(),
        ),
        FFRoute(
          name: 'editprofile_screen',
          path: '/editprofileScreen',
          builder: (context, params) => const EditprofileScreenWidget(),
        ),
        FFRoute(
          name: 'MyProfileScreen',
          path: '/myProfileScreen',
          builder: (context, params) => const MyProfileScreenWidget(),
        ),
        FFRoute(
          name: 'privacypolicy_screen',
          path: '/privacypolicyScreen',
          builder: (context, params) => const PrivacypolicyScreenWidget(),
        ),
        FFRoute(
          name: 'settings_screen',
          path: '/settingsScreen',
          builder: (context, params) => const SettingsScreenWidget(),
        ),
        FFRoute(
          name: 'terms_conditions_screen',
          path: '/termsConditionsScreen',
          builder: (context, params) => const TermsConditionsScreenWidget(),
        ),
        FFRoute(
          name: 'changepassword_screen',
          path: '/changepasswordScreen',
          builder: (context, params) => const ChangepasswordScreenWidget(),
        ),
        FFRoute(
          name: 'FAQSPage',
          path: '/fAQSPage',
          builder: (context, params) => const FAQSPageWidget(),
        ),
        FFRoute(
          name: 'recipe_detail_screen',
          path: '/recipeDetailScreen',
          builder: (context, params) => RecipeDetailScreenWidget(
            recipeDetailId: params.getParam(
              'recipeDetailId',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'popularrecipe_screen',
          path: '/popularrecipeScreen',
          builder: (context, params) => const PopularrecipeScreenWidget(),
        ),
        FFRoute(
          name: 'recommended_for_you_screen',
          path: '/recommendedForYouScreen',
          builder: (context, params) => const RecommendedForYouScreenWidget(),
        ),
        FFRoute(
          name: 'video_step_screen',
          path: '/videoStepScreen',
          builder: (context, params) => VideoStepScreenWidget(
            recipeDetailId: params.getParam(
              'recipeDetailId',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            videoPath: params.getParam(
              'videoPath',
              ParamType.String,
            ),
            urlPath: params.getParam(
              'urlPath',
              ParamType.String,
            ),
            overview: params.getParam(
              'overview',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'forgot_password_verification_screen',
          path: '/forgotPasswordVerificationScreen',
          builder: (context, params) => ForgotPasswordVerificationScreenWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'NotificationPage',
          path: '/notificationPage',
          builder: (context, params) => const NotificationPageWidget(),
        ),
        FFRoute(
          name: 'HomePageCopy',
          path: '/homePageCopy',
          builder: (context, params) => const HomePageCopyWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
