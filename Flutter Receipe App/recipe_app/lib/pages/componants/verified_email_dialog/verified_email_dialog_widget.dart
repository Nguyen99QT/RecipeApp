import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/verified_email_otp_componant/verified_email_otp_componant_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'verified_email_dialog_model.dart';
export 'verified_email_dialog_model.dart';

class VerifiedEmailDialogWidget extends StatefulWidget {
  const VerifiedEmailDialogWidget({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  State<VerifiedEmailDialogWidget> createState() =>
      _VerifiedEmailDialogWidgetState();
}

class _VerifiedEmailDialogWidgetState extends State<VerifiedEmailDialogWidget> {
  late VerifiedEmailDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifiedEmailDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Container(
          width: () {
            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
              return (MediaQuery.sizeOf(context).width - 40);
            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
              return 395.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
              return 395.0;
            } else {
              return 395.0;
            }
          }(),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Text(
                    'Verify your email',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).primaryTextColor,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                          lineHeight: 1.5,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Code sent to ',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryTextColor,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                    lineHeight: 1.5,
                                  ),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.email,
                            'Email',
                          ),
                          style: TextStyle(
                            color:
                                FlutterFlowTheme.of(context).primaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            height: 1.5,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color:
                                FlutterFlowTheme.of(context).primaryTextColor,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: false,
                            lineHeight: 1.5,
                          ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(43.0, 0.0, 43.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.resetOtpFunction =
                            await RecipeAppGroup.resendOtpCall.call(
                          email: widget.email,
                        );

                        if (RecipeAppGroup.resendOtpCall.success(
                              (_model.resetOtpFunction?.jsonBody ?? ''),
                            ) ==
                            1) {
                          Navigator.pop(context);
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: const AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: WebViewAware(
                                  child: VerifiedEmailOtpComponantWidget(
                                    email: valueOrDefault<String>(
                                      widget.email,
                                      'Email',
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          await actions.showCustomToastBottom(
                            RecipeAppGroup.resendOtpCall.message(
                              (_model.resetOtpFunction?.jsonBody ?? ''),
                            )!,
                          );
                          Navigator.pop(context);
                        }

                        safeSetState(() {});
                      },
                      child: wrapWithModel(
                        model: _model.customAppButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const CustomAppButtonWidget(
                          tittle: 'Send OTP',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
