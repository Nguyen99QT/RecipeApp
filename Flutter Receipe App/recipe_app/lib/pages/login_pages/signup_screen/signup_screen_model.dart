import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'signup_screen_widget.dart' show SignupScreenWidget;
import 'package:flutter/material.dart';

class SignupScreenModel extends FlutterFlowModel<SignupScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid first name';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid last name';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  String? _textController3Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController4Validator;
  String? _textController4Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a valid password';
    }

    // Comprehensive password validation - collect all missing requirements
    List<String> missingRequirements = [];
    
    if (val.length < 8) {
      missingRequirements.add('8+ chars');
    }
    
    if (!RegExp(r'[a-z]').hasMatch(val)) {
      missingRequirements.add('lowercase');
    }
    
    if (!RegExp(r'[A-Z]').hasMatch(val)) {
      missingRequirements.add('UPPERCASE');
    }
    
    if (!RegExp(r'[0-9]').hasMatch(val)) {
      missingRequirements.add('number');
    }
    
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) {
      missingRequirements.add('special char');
    }
    
    if (missingRequirements.isNotEmpty) {
      return 'Missing: ${missingRequirements.join(', ')}';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (CheckRegisterUserApi)] action in Button widget.
  ApiCallResponse? checkUserFunction;
  // Stores action output result for [Backend Call - API (SignupApi)] action in Button widget.
  ApiCallResponse? singupFunction;

  @override
  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
    textController2Validator = _textController2Validator;
    textController3Validator = _textController3Validator;
    passwordVisibility = false;
    textController4Validator = _textController4Validator;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
