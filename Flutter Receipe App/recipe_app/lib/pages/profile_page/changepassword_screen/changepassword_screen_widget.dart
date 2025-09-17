import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/change_password_dialog/change_password_dialog_widget.dart';
import '/pages/componants/custom_app_button/custom_app_button_widget.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'changepassword_screen_model.dart';
export 'changepassword_screen_model.dart';

class ChangepasswordScreenWidget extends StatefulWidget {
  const ChangepasswordScreenWidget({super.key});

  @override
  State<ChangepasswordScreenWidget> createState() =>
      _ChangepasswordScreenWidgetState();
}

class _ChangepasswordScreenWidgetState
    extends State<ChangepasswordScreenWidget> {
  late ChangepasswordScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangepasswordScreenModel());

    _model.textController0 ??= TextEditingController();
    _model.textFieldFocusNode0 ??= FocusNode();

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.customAppbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomAppbarWidget(
                  text: 'Change password',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      16.0,
                      0,
                      16.0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: Text(
                          'Change your password today it\'s time to take back control of your online security',
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
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 4.0),
                              child: Text(
                                'Current password',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.textController0,
                                focusNode: _model.textFieldFocusNode0,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                obscureText: !_model.passwordVisibility0,
                                onChanged: (value) {
                                  // Clear current password error when user types
                                  if (_model.currentPasswordError != null) {
                                    _model.clearCurrentPasswordError();
                                    safeSetState(() {});
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter your current password',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .black40,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  errorStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .errorColor,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).black20,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTheme,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .backgroundColor,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 15.0, 16.0, 15.0),
                                  suffixIcon: InkWell(
                                    onTap: () => safeSetState(
                                      () => _model.passwordVisibility0 =
                                          !_model.passwordVisibility0,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      _model.passwordVisibility0
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTextColor,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController0Validator
                                    .asValidator(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 4.0),
                              child: Text(
                                'New password',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 8.0),
                              child: Text(
                                'Must have 8+ chars, UPPERCASE, lowercase, number, special char',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context).black40,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                obscureText: !_model.passwordVisibility1,
                                decoration: InputDecoration(
                                  hintText: 'Enter your new password',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .black40,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  errorStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .errorColor,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).black20,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTheme,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .backgroundColor,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 15.0, 16.0, 15.0),
                                  suffixIcon: InkWell(
                                    onTap: () => safeSetState(
                                      () => _model.passwordVisibility1 =
                                          !_model.passwordVisibility1,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      _model.passwordVisibility1
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTextColor,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 4.0),
                              child: Text(
                                'Confirm password',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.textController2,
                                focusNode: _model.textFieldFocusNode2,
                                autofocus: false,
                                textInputAction: TextInputAction.done,
                                obscureText: !_model.passwordVisibility2,
                                decoration: InputDecoration(
                                  hintText: 'Enter your confirm password',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .black40,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  errorStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .errorColor,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).black20,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTheme,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .errorColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .backgroundColor,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 15.0, 16.0, 15.0),
                                  suffixIcon: InkWell(
                                    onTap: () => safeSetState(
                                      () => _model.passwordVisibility2 =
                                          !_model.passwordVisibility2,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      _model.passwordVisibility2
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryTextColor,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController2Validator
                                    .asValidator(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Forgot Password Link
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your current password? ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color: FlutterFlowTheme.of(context).primaryTextColor,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: false,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('forgot_screen');
                          },
                          child: Text(
                            'Reset it here',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SF Pro Display',
                              color: FlutterFlowTheme.of(context).primaryTheme,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        'You\'ll receive an email to reset your password',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).black40,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 40.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      
                      // Clear any previous errors
                      _model.clearCurrentPasswordError();
                      
                      _model.changePasswordFunction =
                          await RecipeAppGroup.changePasswordCall.call(
                        currentPassword: _model.textController0.text,
                        newPassword: _model.textController1.text,
                        confirmPassword: _model.textController2.text,
                        token: FFAppState().token,
                      );

                      // Debug API response
                      print('API Response: ${_model.changePasswordFunction?.jsonBody}');
                      print('Success value: ${RecipeAppGroup.changePasswordCall.success((_model.changePasswordFunction?.jsonBody ?? ''))}');

                      // Check success condition - API returns boolean true, not integer 1
                      var successValue = RecipeAppGroup.changePasswordCall.success(
                        (_model.changePasswordFunction?.jsonBody ?? ''),
                      );
                      
                      if (successValue == true || successValue == 1) {
                        // Success case - show success message and dialog
                        print('PASSWORD CHANGE SUCCESS - Showing dialog');
                        
                        print('About to show dialog');
                        
                        await showDialog<bool>(
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: const AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: WebViewAware(
                                child: GestureDetector(
                                  onTap: () =>
                                      FocusScope.of(dialogContext).unfocus(),
                                  child: const ChangePasswordDialogWidget(),
                                ),
                              ),
                            );
                          },
                        ).catchError((error) {
                          // If dialog fails, just log the error
                          print('Dialog failed: $error');
                          return false;
                        });
                        
                        print('Dialog completed');
                        
                        // Navigate back to profile/settings after dialog closes
                        if (context.mounted) {
                          print('Navigating back');
                          context.safePop();
                        }
                      } else {
                        // Handle specific error types
                        print('PASSWORD CHANGE FAILED - Processing error');
                        String errorMessage = RecipeAppGroup.changePasswordCall.message(
                          (_model.changePasswordFunction?.jsonBody ?? ''),
                        ) ?? 'Failed to change password. Please try again.';
                        
                        print('Error message: $errorMessage');
                        
                        // Check if it's a current password error
                        if (errorMessage.toLowerCase().contains('current password') || 
                            errorMessage.toLowerCase().contains('incorrect')) {
                          // Set inline error for current password field
                          _model.setCurrentPasswordError(errorMessage);
                          safeSetState(() {});
                          
                          // Validate form to show the error
                          _model.formKey.currentState?.validate();
                        } else {
                          // For other errors, show toast
                          await actions.showCustomToastBottom(errorMessage);
                        }
                      }

                      safeSetState(() {});
                    },
                    child: wrapWithModel(
                      model: _model.customAppButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: const CustomAppButtonWidget(
                        tittle: 'Change password',
                      ),
                    ),
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
