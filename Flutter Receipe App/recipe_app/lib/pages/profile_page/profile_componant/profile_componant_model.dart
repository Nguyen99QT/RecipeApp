import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import 'profile_componant_widget.dart' show ProfileComponantWidget;
import 'package:flutter/material.dart';

class ProfileComponantModel extends FlutterFlowModel<ProfileComponantWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for single_appbar component.
  late SingleAppbarModel singleAppbarModel;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {
    singleAppbarModel = createModel(context, () => SingleAppbarModel());
  }

  @override
  void dispose() {
    singleAppbarModel.dispose();
  }
}
