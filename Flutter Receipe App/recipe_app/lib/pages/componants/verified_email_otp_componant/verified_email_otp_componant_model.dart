import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'verified_email_otp_componant_widget.dart'
    show VerifiedEmailOtpComponantWidget;
import 'package:flutter/material.dart';

class VerifiedEmailOtpComponantModel
    extends FlutterFlowModel<VerifiedEmailOtpComponantWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid OTP';
    }
    if (val.length < 4) {
      return 'Requires 4 characters.';
    }
    return null;
  }

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;
  // Stores action output result for [Backend Call - API (VerifyOtpApi)] action in custom_app_button widget.
  ApiCallResponse? otpVerificationFunction;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
    customAppButtonModel.dispose();
  }
}
