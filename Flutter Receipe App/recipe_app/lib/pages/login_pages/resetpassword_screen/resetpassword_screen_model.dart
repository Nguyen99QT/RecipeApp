import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'resetpassword_screen_widget.dart' show ResetpasswordScreenWidget;
import 'package:flutter/material.dart';

class ResetpasswordScreenModel
    extends FlutterFlowModel<ResetpasswordScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid new password';
    }

    // Comprehensive password validation - collect all missing requirements
    List<String> missingRequirements = [];
    
    if (val.length < 8) {
      missingRequirements.add('8+ chars');
    }
    
    if (!RegExp(r'(?=.*[a-z])').hasMatch(val)) {
      missingRequirements.add('lowercase');
    }
    
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) {
      missingRequirements.add('UPPERCASE');
    }
    
    if (!RegExp(r'(?=.*[0-9])').hasMatch(val)) {
      missingRequirements.add('number');
    }
    
    if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(val)) {
      missingRequirements.add('special char');
    }
    
    if (missingRequirements.isNotEmpty) {
      return 'Missing: ${missingRequirements.join(', ')}';
    }

    return null;
  }  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter confirm password';
    }
    
    if (val.length < 6) {
      return 'Confirm password must be at least 6 characters long';
    }
    
    // Check if passwords match
    if (textController1?.text != null && val != textController1!.text) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;
  // Stores action output result for [Backend Call - API (ResetPasswordApi)] action in custom_app_button widget.
  ApiCallResponse? changePasswordFunction;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
    passwordVisibility1 = false;
    textController1Validator = _textController1Validator;
    passwordVisibility2 = false;
    textController2Validator = _textController2Validator;
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    customAppButtonModel.dispose();
  }
}
