import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'exit_dialog_model.dart';
export 'exit_dialog_model.dart';

class ExitDialogWidget extends StatefulWidget {
  const ExitDialogWidget({super.key});

  @override
  State<ExitDialogWidget> createState() => _ExitDialogWidgetState();
}

class _ExitDialogWidgetState extends State<ExitDialogWidget> {
  late ExitDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExitDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(26.0, 0.0, 26.0, 0.0),
      child: Container(
        width: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 376;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 476;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 576;
          } else {
            return 576;
          }
        }()
            .toDouble(),
        height: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 155;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 205;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 255;
          } else {
            return 255;
          }
        }()
            .toDouble(),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 21.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  'Are you sure you want to exit?',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: FlutterFlowTheme.of(context).primaryTextColor,
                        fontSize: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 20;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 30;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 35;
                          } else {
                            return 35;
                          }
                        }()
                            .toDouble(),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: false,
                        lineHeight: 1.5,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: 'No',
                        options: FFButtonOptions(
                          height: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 56;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 67;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return 66;
                            } else {
                              return 66;
                            }
                          }()
                              .toDouble(),
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).backgroundColor,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'SF Pro Display',
                                color:
                                    FlutterFlowTheme.of(context).primaryTheme,
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 18;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 22;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 27;
                                  } else {
                                    return 27;
                                  }
                                }()
                                    .toDouble(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryTheme,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          FFAppState().isLogin = false;
                          FFAppState().update(() {});

                          context.goNamed('login_screen');
                        },
                        text: 'Yes',
                        options: FFButtonOptions(
                          height: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 56;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 67;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return 66;
                            } else {
                              return 66;
                            }
                          }()
                              .toDouble(),
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryTheme,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).samewhite,
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 18;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 22;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 27;
                                  } else {
                                    return 27;
                                  }
                                }()
                                    .toDouble(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryTheme,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
