import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/no_receipe_filter_yet_container/no_receipe_filter_yet_container_widget.dart';
import '/pages/componants/no_receipe_yet_container/no_receipe_yet_container_widget.dart';
import 'dart:async';
import 'popularrecipe_screen_widget.dart' show PopularrecipeScreenWidget;
import 'package:flutter/material.dart';

class PopularrecipeScreenModel
    extends FlutterFlowModel<PopularrecipeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? popularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? popularAdd;
  // Model for no_receipe_yet_container component.
  late NoReceipeYetContainerModel noReceipeYetContainerModel;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? filterPopularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? filterPopularAdd;
  // Model for no_receipe_filter_yet_container component.
  late NoReceipeFilterYetContainerModel noReceipeFilterYetContainerModel;

  @override
  void initState(BuildContext context) {
    noReceipeYetContainerModel =
        createModel(context, () => NoReceipeYetContainerModel());
    noReceipeFilterYetContainerModel =
        createModel(context, () => NoReceipeFilterYetContainerModel());
  }

  @override
  void dispose() {
    noReceipeYetContainerModel.dispose();
    noReceipeFilterYetContainerModel.dispose();
  }

  /// Additional helper methods.
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

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted2;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
