import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/flutter_flow/request_manager.dart';

import 'intro_screen_widget.dart' show IntroScreenWidget;
import 'package:flutter/material.dart';

class IntroScreenModel extends FlutterFlowModel<IntroScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;

  /// Query cache managers for this widget.

  final _introCacheManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> introCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _introCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIntroCacheCache() => _introCacheManager.clear();
  void clearIntroCacheCacheKey(String? uniqueKey) =>
      _introCacheManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppButtonModel.dispose();

    /// Dispose query cache managers for this widget.

    clearIntroCacheCache();
  }
}
