import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'dart:async';
import 'terms_conditions_screen_widget.dart' show TermsConditionsScreenWidget;
import 'package:flutter/material.dart';

class TermsConditionsScreenModel
    extends FlutterFlowModel<TermsConditionsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
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
