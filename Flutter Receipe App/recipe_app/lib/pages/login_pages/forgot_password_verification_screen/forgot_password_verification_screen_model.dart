import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'forgot_password_verification_screen_widget.dart'
    show ForgotPasswordVerificationScreenWidget;
import 'package:flutter/material.dart';

class ForgotPasswordVerificationScreenModel
    extends FlutterFlowModel<ForgotPasswordVerificationScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the correct OTP';
    }
    if (val.length < 4) {
      return 'Requires 4 characters.';
    }
    return null;
  }

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;
  // Stores action output result for [Backend Call - API (ForgotPasswordVerificationApi)] action in custom_app_button widget.
  ApiCallResponse? forgotPasswordVerificationFunction;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    pinCodeController?.dispose();
    customAppButtonModel.dispose();
  }
}
