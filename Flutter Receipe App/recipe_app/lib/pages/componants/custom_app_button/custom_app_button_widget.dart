import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'custom_app_button_model.dart';
export 'custom_app_button_model.dart';

class CustomAppButtonWidget extends StatefulWidget {
  const CustomAppButtonWidget({
    super.key,
    String? tittle,
  }) : tittle = tittle ?? 'tittle';

  final String tittle;

  @override
  State<CustomAppButtonWidget> createState() => _CustomAppButtonWidgetState();
}

class _CustomAppButtonWidgetState extends State<CustomAppButtonWidget> {
  late CustomAppButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAppButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryTheme,
        borderRadius: BorderRadius.circular(16.0),
      ),
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Text(
          widget.tittle,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'SF Pro Display',
                color: FlutterFlowTheme.of(context).samewhite,
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                useGoogleFonts: false,
                lineHeight: 1.2,
              ),
        ),
      ),
    );
  }
}
