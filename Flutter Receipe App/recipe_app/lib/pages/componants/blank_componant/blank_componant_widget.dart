import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'blank_componant_model.dart';
export 'blank_componant_model.dart';

class BlankComponantWidget extends StatefulWidget {
  const BlankComponantWidget({super.key});

  @override
  State<BlankComponantWidget> createState() => _BlankComponantWidgetState();
}

class _BlankComponantWidgetState extends State<BlankComponantWidget> {
  late BlankComponantModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlankComponantModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
