import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'terms_conditions_screen_model.dart';
export 'terms_conditions_screen_model.dart';

class TermsConditionsScreenWidget extends StatefulWidget {
  const TermsConditionsScreenWidget({super.key});

  @override
  State<TermsConditionsScreenWidget> createState() =>
      _TermsConditionsScreenWidgetState();
}

class _TermsConditionsScreenWidgetState
    extends State<TermsConditionsScreenWidget> {
  late TermsConditionsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsConditionsScreenModel());

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.customAppbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomAppbarWidget(
                  text: 'Terms & conditions',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: FFAppState()
                        .termsAndConditionsCache(
                      requestFn: () =>
                          RecipeAppGroup.getPolicyAndTermsApiCall.call(),
                    )
                        .then((result) {
                      _model.apiRequestCompleted = true;
                      return result;
                    }),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primaryTheme,
                              ),
                            ),
                          ),
                        );
                      }
                      final listViewGetPolicyAndTermsApiResponse =
                          snapshot.data!;

                      return RefreshIndicator(
                        color: FlutterFlowTheme.of(context).tertiary,
                        onRefresh: () async {
                          safeSetState(() {
                            FFAppState().clearTermsAndConditionsCacheCache();
                            _model.apiRequestCompleted = false;
                          });
                          await _model.waitForApiRequestCompleted();
                        },
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            16.0,
                            0,
                            16.0,
                          ),
                          scrollDirection: Axis.vertical,
                          children: [
                            if (RecipeAppGroup.getPolicyAndTermsApiCall.success(
                                  listViewGetPolicyAndTermsApiResponse.jsonBody,
                                ) ==
                                true)
                              custom_widgets.HtmlConverter(
                                width: double.infinity,
                                height: 1000.0,
                                text: RecipeAppGroup.getPolicyAndTermsApiCall
                                    .termsAndConditions(
                                  listViewGetPolicyAndTermsApiResponse.jsonBody,
                                )!,
                              ),
                          ],
                        ),
                      );
                    },
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
