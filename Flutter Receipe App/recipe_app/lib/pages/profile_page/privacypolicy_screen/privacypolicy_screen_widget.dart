import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'privacypolicy_screen_model.dart';
export 'privacypolicy_screen_model.dart';

class PrivacypolicyScreenWidget extends StatefulWidget {
  const PrivacypolicyScreenWidget({super.key});

  @override
  State<PrivacypolicyScreenWidget> createState() =>
      _PrivacypolicyScreenWidgetState();
}

class _PrivacypolicyScreenWidgetState extends State<PrivacypolicyScreenWidget> {
  late PrivacypolicyScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacypolicyScreenModel());

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
                  text: 'Privacy policy',
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
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            if (RecipeAppGroup.getPolicyAndTermsApiCall.success(
                                  listViewGetPolicyAndTermsApiResponse.jsonBody,
                                ) ==
                                1)
                              custom_widgets.HtmlConverter(
                                width: double.infinity,
                                height: 50.0,
                                text: RecipeAppGroup.getPolicyAndTermsApiCall
                                    .privatePolicy(
                                  listViewGetPolicyAndTermsApiResponse.jsonBody,
                                )!,
                              ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                decoration: const BoxDecoration(),
                              ),
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
