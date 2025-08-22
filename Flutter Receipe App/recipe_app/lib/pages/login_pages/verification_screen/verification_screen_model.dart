import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'verification_screen_widget.dart' show VerificationScreenWidget;
import 'package:flutter/material.dart';

class VerificationScreenModel
    extends FlutterFlowModel<VerificationScreenWidget> {
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
  // Stores action output result for [Backend Call - API (VerifyOtpApi)] action in custom_app_button widget.
  ApiCallResponse? verifyOtpFunction;
  // Stores action output result for [Backend Call - API (SignInApi)] action in custom_app_button widget.
  ApiCallResponse? loginApiFunction;
  // Stores action output result for [Backend Call - API (GetAllFavouriteRecipesApi)] action in custom_app_button widget.
  ApiCallResponse? getFavourite;
  // Stores action output result for [Backend Call - API (DeleteFavouriteRecipeApi)] action in custom_app_button widget.
  ApiCallResponse? removeFavouriteFunction;
  // Stores action output result for [Backend Call - API (AddFavouriteRecipe)] action in custom_app_button widget.
  ApiCallResponse? addFavouriteFunction;

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
