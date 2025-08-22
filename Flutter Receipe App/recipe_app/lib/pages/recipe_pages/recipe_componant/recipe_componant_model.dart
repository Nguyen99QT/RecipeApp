import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/no_receipe_yet_container/no_receipe_yet_container_widget.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import 'dart:async';
import 'recipe_componant_widget.dart' show RecipeComponantWidget;
import 'package:flutter/material.dart';

class RecipeComponantModel extends FlutterFlowModel<RecipeComponantWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for single_appbar component.
  late SingleAppbarModel singleAppbarModel;
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? popularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? popularAdd;
  // Model for no_receipe_yet_container component.
  late NoReceipeYetContainerModel noReceipeYetContainerModel;

  @override
  void initState(BuildContext context) {
    singleAppbarModel = createModel(context, () => SingleAppbarModel());
    noReceipeYetContainerModel =
        createModel(context, () => NoReceipeYetContainerModel());
  }

  @override
  void dispose() {
    singleAppbarModel.dispose();
    noReceipeYetContainerModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
