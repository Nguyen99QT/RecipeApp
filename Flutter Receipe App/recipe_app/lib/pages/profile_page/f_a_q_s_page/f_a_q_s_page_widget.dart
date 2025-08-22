import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import 'dart:async';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'f_a_q_s_page_model.dart';
export 'f_a_q_s_page_model.dart';

class FAQSPageWidget extends StatefulWidget {
  const FAQSPageWidget({super.key});

  @override
  State<FAQSPageWidget> createState() => _FAQSPageWidgetState();
}

class _FAQSPageWidgetState extends State<FAQSPageWidget> {
  late FAQSPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FAQSPageModel());

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
                  text: 'FAQ\'s',
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (FFAppState().connected) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: (_model.apiRequestCompleter ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(
                                        RecipeAppGroup.getAllFaqApiCall.call()))
                              .future,
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
                            final listViewGetAllFaqApiResponse = snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final faqsList = RecipeAppGroup.getAllFaqApiCall
                                        .faqList(
                                          listViewGetAllFaqApiResponse.jsonBody,
                                        )
                                        ?.toList() ??
                                    [];

                                return RefreshIndicator(
                                  key: const Key('RefreshIndicator_y8m058iw'),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  onRefresh: () async {
                                    safeSetState(() =>
                                        _model.apiRequestCompleter = null);
                                    await _model.waitForApiRequestCompleted();
                                  },
                                  child: ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      16.0,
                                      0,
                                      16.0,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: faqsList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 16.0),
                                    itemBuilder: (context, faqsListIndex) {
                                      final faqsListItem =
                                          faqsList[faqsListIndex];
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 16.0, 16.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            color: FlutterFlowTheme.of(context)
                                                .lightGrey,
                                            child: ExpandableNotifier(
                                              initialExpanded: false,
                                              child: ExpandablePanel(
                                                header: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 16.0),
                                                  child: Text(
                                                    getJsonField(
                                                      faqsListItem,
                                                      r'''$.question''',
                                                    ).toString(),
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SF Pro Display',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .sameBlack,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: false,
                                                          lineHeight: 1.2,
                                                        ),
                                                  ),
                                                ),
                                                collapsed: Container(
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(),
                                                ),
                                                expanded: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  16.0),
                                                      child: Text(
                                                        getJsonField(
                                                          faqsListItem,
                                                          r'''$.answer''',
                                                        ).toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'SF Pro Display',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .sameBlack40,
                                                              fontSize: 17.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              useGoogleFonts:
                                                                  false,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                theme: ExpandableThemeData(
                                                  tapHeaderToExpand: true,
                                                  tapBodyToExpand: false,
                                                  tapBodyToCollapse: false,
                                                  headerAlignment:
                                                      ExpandablePanelHeaderAlignment
                                                          .top,
                                                  hasIcon: true,
                                                  expandIcon:
                                                      Icons.keyboard_arrow_down,
                                                  collapseIcon:
                                                      Icons.keyboard_arrow_up,
                                                  iconSize: 24.0,
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .sameBlack,
                                                  iconPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Lottie.asset(
                          'assets/lottie_animations/No_Wifi.json',
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
