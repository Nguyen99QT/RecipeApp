import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'video_step_screen_widget.dart' show VideoStepScreenWidget;
import 'package:flutter/material.dart';

class VideoStepScreenModel extends FlutterFlowModel<VideoStepScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetUserApi)] action in video_step_screen widget.
  ApiCallResponse? getUser;
  // Stores action output result for [Backend Call - API (isVerifyAccountApi)] action in video_step_screen widget.
  ApiCallResponse? isVerifiedCheck;
  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;
  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    customAppButtonModel.dispose();
  }
}
