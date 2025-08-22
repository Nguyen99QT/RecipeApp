import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'settings_screen_widget.dart' show SettingsScreenWidget;
import 'package:flutter/material.dart';

class SettingsScreenModel extends FlutterFlowModel<SettingsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for custom_appbar component.
  late CustomAppbarModel customAppbarModel;

  @override
  void initState(BuildContext context) {
    customAppbarModel = createModel(context, () => CustomAppbarModel());
  }

  @override
  void dispose() {
    customAppbarModel.dispose();
  }
}
