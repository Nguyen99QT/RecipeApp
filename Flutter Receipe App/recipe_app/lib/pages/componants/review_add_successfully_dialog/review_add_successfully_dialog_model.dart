import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import 'review_add_successfully_dialog_widget.dart'
    show ReviewAddSuccessfullyDialogWidget;
import 'package:flutter/material.dart';

class ReviewAddSuccessfullyDialogModel
    extends FlutterFlowModel<ReviewAddSuccessfullyDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for custom_app_button component.
  late CustomAppButtonModel customAppButtonModel;

  @override
  void initState(BuildContext context) {
    customAppButtonModel = createModel(context, () => CustomAppButtonModel());
  }

  @override
  void dispose() {
    customAppButtonModel.dispose();
  }
}
