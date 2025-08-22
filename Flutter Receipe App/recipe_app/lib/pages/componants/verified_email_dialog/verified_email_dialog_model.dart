import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'verified_email_dialog_widget.dart' show VerifiedEmailDialogWidget;
import 'package:flutter/material.dart';

class VerifiedEmailDialogModel
    extends FlutterFlowModel<VerifiedEmailDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;
  // Stores action output result for [Backend Call - API (resendOtp)] action in custom_app_button widget.
  ApiCallResponse? resetOtpFunction;

  @override
  void initState(BuildContext context) {
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppButtonModel.dispose();
  }
}
