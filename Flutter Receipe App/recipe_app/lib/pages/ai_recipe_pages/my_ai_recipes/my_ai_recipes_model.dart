import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_ai_recipes_widget.dart' show MyAiRecipesWidget;
import 'package:flutter/material.dart';

class MyAiRecipesModel extends FlutterFlowModel<MyAiRecipesWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetUserAiRecipes)] action in MyAiRecipes widget.
  ApiCallResponse? getUserAiRecipesResponse;

  // State field(s) for refreshing
  bool isRefreshing = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForUserAiRecipesRequest({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = getUserAiRecipesResponse != null;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
