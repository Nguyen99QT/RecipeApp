import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'forgot_password_verification_screen_model.dart';
export 'forgot_password_verification_screen_model.dart';

class ForgotPasswordVerificationScreenWidget extends StatefulWidget {
  const ForgotPasswordVerificationScreenWidget({
    super.key,
    this.email,
  });

  final String? email;

  @override
  State<ForgotPasswordVerificationScreenWidget> createState() =>
      _ForgotPasswordVerificationScreenWidgetState();
}

class _ForgotPasswordVerificationScreenWidgetState
    extends State<ForgotPasswordVerificationScreenWidget> {
  late ForgotPasswordVerificationScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => ForgotPasswordVerificationScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).backgroundColor,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customAppbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomAppbarWidget(
                  text: 'Verification',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          'Please enter the 4 digit code sent to',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryTextColor,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: false,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.email,
                            'email',
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryTextColor,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: false,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 15.0),
                          child: PinCodeTextField(
                            autoDisposeControllers: false,
                            appContext: context,
                            length: 4,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTextColor,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            enableActiveFill: false,
                            autoFocus: false,
                            enablePinAutofill: false,
                            errorTextSpace: 16.0,
                            showCursor: true,
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryTheme,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            pinTheme: PinTheme(
                              fieldHeight: 50.0,
                              fieldWidth: 50.0,
                              borderWidth: 1.0,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              shape: PinCodeFieldShape.box,
                              activeColor:
                                  FlutterFlowTheme.of(context).primaryTextColor,
                              inactiveColor:
                                  FlutterFlowTheme.of(context).black20,
                              selectedColor:
                                  FlutterFlowTheme.of(context).primaryTheme,
                            ),
                            controller: _model.pinCodeController,
                            onChanged: (_) {},
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: _model.pinCodeControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          _model.forgotPasswordVerificationFunction =
                              await RecipeAppGroup
                                  .forgotPasswordVerificationApiCall
                                  .call(
                            email: widget.email,
                            otp: int.tryParse(_model.pinCodeController!.text),
                          );

                          if (RecipeAppGroup.forgotPasswordVerificationApiCall
                                  .success(
                                (_model.forgotPasswordVerificationFunction
                                        ?.jsonBody ??
                                    ''),
                              ) ==
                              true) {
                            await actions.showCustomToastBottom(
                              RecipeAppGroup.forgotPasswordVerificationApiCall
                                  .message(
                                (_model.forgotPasswordVerificationFunction
                                        ?.jsonBody ??
                                    ''),
                              )!,
                            );

                            context.pushNamed(
                              'resetpassword_screen',
                              queryParameters: {
                                'email': serializeParam(
                                  widget.email,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          } else {
                            await actions.showCustomToastBottom(
                              RecipeAppGroup.forgotPasswordVerificationApiCall
                                  .message(
                                (_model.forgotPasswordVerificationFunction
                                        ?.jsonBody ??
                                    ''),
                              )!,
                            );
                          }

                          safeSetState(() {});
                        },
                        child: wrapWithModel(
                          model: _model.customAppButtonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const CustomAppButtonWidget(
                            tittle: 'Verify',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        child: custom_widgets.ForgotTimerWidget(
                          width: double.infinity,
                          height: 18.0,
                          email: widget.email,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
