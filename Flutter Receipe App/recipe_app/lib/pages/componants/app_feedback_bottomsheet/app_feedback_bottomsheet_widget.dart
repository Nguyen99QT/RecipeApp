import 'package:flutter/material.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/review_add_successfully_dialog/review_add_successfully_dialog_widget.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppFeedbackBottomsheetWidget extends StatefulWidget {
  const AppFeedbackBottomsheetWidget({super.key});

  @override
  State<AppFeedbackBottomsheetWidget> createState() =>
      _AppFeedbackBottomsheetWidgetState();
}

class _AppFeedbackBottomsheetWidgetState extends State<AppFeedbackBottomsheetWidget> {
  late TextEditingController _textController;
  late FocusNode _textFieldFocusNode;
  final _formKey = GlobalKey<FormState>();
  double _ratingBarValue = 5.0;
  
  @override
  void initState() {
    super.initState();
    print('[DEBUG] AppFeedbackBottomsheetWidget initState called!');
    _textController = TextEditingController();
    _textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Container(
              width: 80.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).black20,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Feedback',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'SF Pro Display',
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: false,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 32.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).black20,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 12.0),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Text(
                        'Your overall rating of this app',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: false,
                          lineHeight: 1.5,
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      onRatingUpdate: (newValue) => setState(() => _ratingBarValue = newValue),
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: FlutterFlowTheme.of(context).rating,
                      ),
                      direction: Axis.horizontal,
                      initialRating: _ratingBarValue,
                      unratedColor: FlutterFlowTheme.of(context).black20,
                      itemCount: 5,
                      itemSize: 40.0,
                      glowColor: FlutterFlowTheme.of(context).rating,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Text(
                        'Add detailed feedback',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: false,
                          lineHeight: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: _textController,
                        focusNode: _textFieldFocusNode,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'SF Pro Display',
                            letterSpacing: 0.0,
                            useGoogleFonts: false,
                          ),
                          hintText: 'Share your experience with the app...',
                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'SF Pro Display',
                            letterSpacing: 0.0,
                            useGoogleFonts: false,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).black20,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          letterSpacing: 0.0,
                          useGoogleFonts: false,
                        ),
                        maxLines: 4,
                        minLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 32.0),
            child: FFButtonWidget(
              onPressed: () async {
                print('[DEBUG] Submit app feedback button pressed');
                print('[DEBUG] Rating: ${_ratingBarValue.round()}');
                print('[DEBUG] Comment: ${_textController.text}');
                print('[DEBUG] Token: ${FFAppState().token}');
                
                // Call app feedback API
                final appFeedbackResponse = await RecipeAppGroup.addAppFeedbackApiCall.call(
                  rating: _ratingBarValue.round(),
                  comment: _textController.text,
                  token: FFAppState().token,
                );

                print('[DEBUG] App feedback API completed');
                print('[DEBUG] Response status: ${appFeedbackResponse.statusCode}');
                print('[DEBUG] Response body: ${appFeedbackResponse.jsonBody}');

                if (RecipeAppGroup.addAppFeedbackApiCall.success(
                      (appFeedbackResponse.jsonBody ?? ''),
                    ) == true) {
                  print('[DEBUG] App feedback success - showing dialog');
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: const AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                        child: const ReviewAddSuccessfullyDialogWidget(),
                      );
                    },
                  );
                } else {
                  print('[DEBUG] App feedback failed - showing error');
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        RecipeAppGroup.addAppFeedbackApiCall.message(
                          (appFeedbackResponse.jsonBody ?? ''),
                        ) ?? 'Failed to submit feedback',
                      ),
                    ),
                  );
                }
              },
              text: 'Submit Feedback',
              options: FFButtonOptions(
                width: double.infinity,
                height: 48.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'SF Pro Display',
                  color: Colors.white,
                  letterSpacing: 0.0,
                  useGoogleFonts: false,
                ),
                elevation: 0.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
