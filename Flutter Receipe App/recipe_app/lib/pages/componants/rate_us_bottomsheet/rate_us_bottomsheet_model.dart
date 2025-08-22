import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'rate_us_bottomsheet_widget.dart' show RateUsBottomsheetWidget;
import 'package:flutter/material.dart';

class RateUsBottomsheetModel extends FlutterFlowModel<RateUsBottomsheetWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please write feedback';
    }

    return null;
  }

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;
  // Stores action output result for [Backend Call - API (AddReviewApi)] action in custom_app_button widget.
  ApiCallResponse? addReviewFunction;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    customAppButtonModel.dispose();
  }
}
