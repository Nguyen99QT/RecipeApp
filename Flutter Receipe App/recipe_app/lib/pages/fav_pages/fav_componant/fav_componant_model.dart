import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/nofavorite_yet_container/nofavorite_yet_container_widget.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import 'dart:async';
import 'fav_componant_widget.dart' show FavComponantWidget;
import 'package:flutter/material.dart';

class FavComponantModel extends FlutterFlowModel<FavComponantWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for single_appbar component.
  late SingleAppbarModel singleAppbarModel;
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in MainContainer widget.
  ApiCallResponse? popularDelete;
  // Model for nofavorite_yet_container component.
  late NofavoriteYetContainerModel nofavoriteYetContainerModel;

  @override
  void initState(BuildContext context) {
    singleAppbarModel = createModel(context, () => SingleAppbarModel());
    nofavoriteYetContainerModel =
        createModel(context, () => NofavoriteYetContainerModel());
  }

  @override
  void dispose() {
    singleAppbarModel.dispose();
    nofavoriteYetContainerModel.dispose();
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
