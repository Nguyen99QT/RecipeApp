import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'home_page_componant_widget.dart' show HomePageComponantWidget;
import 'package:flutter/material.dart';

class HomePageComponantModel extends FlutterFlowModel<HomePageComponantWidget> {
  ///  Local state fields for this component.

  bool isSelectcategory = true;

  String? categoryId;

  ///  State fields for stateful widgets in this component.

  bool apiRequestCompleted3 = false;
  String? apiRequestLastUniqueKey3;
  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? popularDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in MainContainer widget.
  ApiCallResponse? popularAdd;
  // Stores action output result for [Backend Call - API (GetAllRecipeApi)] action in Container widget.
  ApiCallResponse? allListApi;
  // Stores action output result for [Backend Call - API (GetRecipeByCategoryIdApi)] action in Container widget.
  ApiCallResponse? getRecipeByCategoryId;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in RowContainerComponant widget.
  ApiCallResponse? recommendedDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in RowContainerComponant widget.
  ApiCallResponse? recommendedAdd;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in RowContainerComponant widget.
  ApiCallResponse? recommendedFilterDelete;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in RowContainerComponant widget.
  ApiCallResponse? recommendedFilterAdd;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted3;
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
