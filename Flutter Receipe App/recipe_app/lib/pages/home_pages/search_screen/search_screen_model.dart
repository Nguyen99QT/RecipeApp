import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/pages/componants/no_receipe_filter_yet_container/no_receipe_filter_yet_container_widget.dart';
import 'dart:async';
import 'search_screen_widget.dart' show SearchScreenWidget;
import 'package:flutter/material.dart';

class SearchScreenModel extends FlutterFlowModel<SearchScreenWidget> {
  ///  Local state fields for this page.

  bool focus = false;

  ///  State fields for stateful widgets in this page.

  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  Completer<ApiCallResponse>? apiRequestCompleter2;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? popularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? popularAdd;
  // Model for no_receipe_filter_yet_container component.
  late NoReceipeFilterYetContainerModel noReceipeFilterYetContainerModel1;
  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? filterPopularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? filterPopularAdd;
  // Model for no_receipe_filter_yet_container component.
  late NoReceipeFilterYetContainerModel noReceipeFilterYetContainerModel2;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    noReceipeFilterYetContainerModel1 =
        createModel(context, () => NoReceipeFilterYetContainerModel());
    noReceipeFilterYetContainerModel2 =
        createModel(context, () => NoReceipeFilterYetContainerModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    noReceipeFilterYetContainerModel1.dispose();
    noReceipeFilterYetContainerModel2.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted1;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
