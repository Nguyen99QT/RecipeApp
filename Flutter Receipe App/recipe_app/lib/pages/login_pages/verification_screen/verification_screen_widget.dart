import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'verification_screen_model.dart';
export 'verification_screen_model.dart';

class VerificationScreenWidget extends StatefulWidget {
  const VerificationScreenWidget({
    super.key,
    this.email,
    this.password,
    required this.deviceId,
    required this.registrationToken,
    required this.firstName,
    required this.lastName,
  });

  final String? email;
  final String? password;
  final String? deviceId;
  final String? registrationToken;
  final String? firstName;
  final String? lastName;

  @override
  State<VerificationScreenWidget> createState() =>
      _VerificationScreenWidgetState();
}

class _VerificationScreenWidgetState extends State<VerificationScreenWidget> {
  late VerificationScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerificationScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            40.0, 16.0, 40.0, 0.0),
                        child: Text(
                          'Please enter the 4 digit code sent to ',
                          textAlign: TextAlign.center,
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
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.email,
                            'Email',
                          ),
                          textAlign: TextAlign.center,
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
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: PinCodeTextField(
                              autoDisposeControllers: false,
                              appContext: context,
                              length: 4,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
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
                                activeColor: FlutterFlowTheme.of(context)
                                    .primaryTextColor,
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
                          _model.verifyOtpFunction =
                              await RecipeAppGroup.verifyOtpApiCall.call(
                            email: widget.email,
                            otp: int.tryParse(_model.pinCodeController!.text),
                            deviceId: widget.deviceId,
                            registrationToken: FFAppState().fcmToken,
                          );

                          if (RecipeAppGroup.verifyOtpApiCall.success(
                                (_model.verifyOtpFunction?.jsonBody ?? ''),
                              ) ==
                              1) {
                            await actions.showCustomToastBottom(
                              RecipeAppGroup.verifyOtpApiCall.message(
                                (_model.verifyOtpFunction?.jsonBody ?? ''),
                              )!,
                            );
                            FFAppState().isVerified = true;
                            FFAppState().update(() {});
                            _model.loginApiFunction =
                                await RecipeAppGroup.signInApiCall.call(
                              email: widget.email,
                              password: widget.password,
                              deviceId: widget.deviceId,
                              registrationToken: widget.registrationToken,
                              token: FFAppState().token,
                            );

                            if (RecipeAppGroup.signInApiCall.success(
                                  (_model.loginApiFunction?.jsonBody ?? ''),
                                ) ==
                                1) {
                              await actions.showCustomToastBottom(
                                RecipeAppGroup.signInApiCall.message(
                                  (_model.loginApiFunction?.jsonBody ?? ''),
                                )!,
                              );
                              FFAppState().isLogin = true;
                              FFAppState().token =
                                  RecipeAppGroup.signInApiCall.token(
                                (_model.loginApiFunction?.jsonBody ?? ''),
                              )!;
                              FFAppState().userDetail =
                                  RecipeAppGroup.signInApiCall.userDetail(
                                (_model.loginApiFunction?.jsonBody ?? ''),
                              );
                              FFAppState().userId =
                                  RecipeAppGroup.signInApiCall.useId(
                                (_model.loginApiFunction?.jsonBody ?? ''),
                              )!;
                              FFAppState().phone =
                                  RecipeAppGroup.signInApiCall.phone(
                                (_model.loginApiFunction?.jsonBody ?? ''),
                              )!;
                              FFAppState().countryCodeEdit =
                                  RecipeAppGroup.signInApiCall.countryCode(
                                (_model.loginApiFunction?.jsonBody ?? ''),
                              )!;
                              FFAppState().currentPassword = widget.password!;
                              FFAppState().update(() {});
                              if (FFAppState().favChange == true) {
                                _model.getFavourite = await RecipeAppGroup
                                    .getAllFavouriteRecipesApiCall
                                    .call(
                                  token: FFAppState().token,
                                );

                                if (functions.checkFavOrNot(
                                        RecipeAppGroup
                                            .getAllFavouriteRecipesApiCall
                                            .favouriteRecipeList(
                                              (_model.getFavourite?.jsonBody ??
                                                  ''),
                                            )
                                            ?.toList(),
                                        FFAppState().recipeId) ==
                                    true) {
                                  _model.removeFavouriteFunction =
                                      await RecipeAppGroup
                                          .deleteFavouriteRecipeApiCall
                                          .call(
                                    recipeId: FFAppState().recipeId,
                                    token: FFAppState().token,
                                  );
                                } else {
                                  _model.addFavouriteFunction =
                                      await RecipeAppGroup
                                          .addFavouriteRecipeCall
                                          .call(
                                    recipeId: FFAppState().recipeId,
                                    token: FFAppState().token,
                                  );
                                }

                                FFAppState().clearGetrFavouriteCacheCache();
                                FFAppState().favChange = false;
                                FFAppState().recipeId = '';
                                FFAppState().update(() {});

                                context.goNamed('HomePage');
                              } else {
                                FFAppState().clearGetrFavouriteCacheCache();
                                FFAppState().favChange = false;
                                FFAppState().recipeId = '';
                                FFAppState().update(() {});

                                context.goNamed('HomePage');
                              }
                            } else {
                              await actions.showCustomToastBottom(
                                RecipeAppGroup.signInApiCall.message(
                                  (_model.loginApiFunction?.jsonBody ?? ''),
                                )!,
                              );
                            }
                          } else {
                            await actions.showCustomToastBottom(
                              RecipeAppGroup.verifyOtpApiCall.message(
                                (_model.verifyOtpFunction?.jsonBody ?? ''),
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
                        child: custom_widgets.TimerWidget(
                          width: double.infinity,
                          height: 18.0,
                          firstname: widget.firstName,
                          lastname: widget.lastName,
                          email: widget.email,
                          password: widget.password,
                          phone: FFAppState().phone,
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
