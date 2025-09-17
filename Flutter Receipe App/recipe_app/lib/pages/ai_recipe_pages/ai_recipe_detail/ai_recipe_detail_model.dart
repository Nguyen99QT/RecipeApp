import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ai_recipe_detail_widget.dart' show AiRecipeDetailWidget;
import 'package:flutter/material.dart';

class AiRecipeDetailModel extends FlutterFlowModel<AiRecipeDetailWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetUserAiRecipes)] action in AiRecipeDetail widget.
  ApiCallResponse? getAiRecipeResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForAiRecipeRequest({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = getAiRecipeResponse != null;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
