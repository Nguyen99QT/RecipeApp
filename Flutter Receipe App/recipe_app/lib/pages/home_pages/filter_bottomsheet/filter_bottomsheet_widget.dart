import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'filter_bottomsheet_model.dart';
export 'filter_bottomsheet_model.dart';

class FilterBottomsheetWidget extends StatefulWidget {
  const FilterBottomsheetWidget({super.key});

  @override
  State<FilterBottomsheetWidget> createState() =>
      _FilterBottomsheetWidgetState();
}

class _FilterBottomsheetWidgetState extends State<FilterBottomsheetWidget> {
  late FilterBottomsheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterBottomsheetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 70.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).black20,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 11.0, 16.0, 11.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).backgroundColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      'Filter',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color:
                                FlutterFlowTheme.of(context).primaryTextColor,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: false,
                            lineHeight: 1.5,
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.safePop();
                      },
                      child: Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).lightGrey,
                          shape: BoxShape.circle,
                        ),
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: SvgPicture.asset(
                            'assets/images/close.svg',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).black20,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    16.0,
                    0,
                    16.0,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    if (true /* Warning: Trying to access variable not yet defined. */)
                      FutureBuilder<ApiCallResponse>(
                        future: FFAppState().getAllCategoryCache(
                          requestFn: () =>
                              RecipeAppGroup.getAllCategoryApiCall.call(),
                        ),
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
                          final columnGetAllCategoryApiResponse =
                              snapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Sort by',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ),
                              Container(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                      child: Builder(
                                        builder: (context) {
                                          final categoryList = RecipeAppGroup
                                                  .getAllCategoryApiCall
                                                  .categoryList(
                                                    columnGetAllCategoryApiResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toList() ??
                                              [];

                                          return Wrap(
                                            spacing: 16.0,
                                            runSpacing: 8.0,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            direction: Axis.horizontal,
                                            runAlignment: WrapAlignment.start,
                                            verticalDirection:
                                                VerticalDirection.down,
                                            clipBehavior: Clip.none,
                                            children: List.generate(
                                                categoryList.length,
                                                (categoryListIndex) {
                                              final categoryListItem =
                                                  categoryList[
                                                      categoryListIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  FFAppState().categoryId =
                                                      getJsonField(
                                                    categoryListItem,
                                                    r'''$._id''',
                                                  ).toString();
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FFAppState()
                                                                .categoryId ==
                                                            getJsonField(
                                                              categoryListItem,
                                                              r'''$._id''',
                                                            ).toString()
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryTheme
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color: FFAppState()
                                                                  .categoryId ==
                                                              getJsonField(
                                                                categoryListItem,
                                                                r'''$._id''',
                                                              ).toString()
                                                          ? const Color(0x00000000)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .black20,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 9.0,
                                                                16.0, 9.0),
                                                    child: Text(
                                                      getJsonField(
                                                        categoryListItem,
                                                        r'''$.name''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SF Pro Display',
                                                            color: FFAppState()
                                                                        .categoryId ==
                                                                    getJsonField(
                                                                      categoryListItem,
                                                                      r'''$._id''',
                                                                    ).toString()
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .samewhite
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryTextColor,
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                false,
                                                            lineHeight: 1.2,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    if (true /* Warning: Trying to access variable not yet defined. */)
                      FutureBuilder<ApiCallResponse>(
                        future: FFAppState().cuisinesCche(
                          requestFn: () =>
                              RecipeAppGroup.getAllCuisinesApiCall.call(),
                        ),
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
                          final columnGetAllCuisinesApiResponse =
                              snapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 16.0),
                                child: Text(
                                  'Cuisines',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final cuisinesList =
                                            RecipeAppGroup.getAllCuisinesApiCall
                                                    .cuisinesList(
                                                      columnGetAllCuisinesApiResponse
                                                          .jsonBody,
                                                    )
                                                    ?.toList() ??
                                                [];

                                        return Wrap(
                                          spacing: 16.0,
                                          runSpacing: 8.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children:
                                              List.generate(cuisinesList.length,
                                                  (cuisinesListIndex) {
                                            final cuisinesListItem =
                                                cuisinesList[cuisinesListIndex];
                                            return Container(
                                              width: () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width <
                                                    810.0) {
                                                  return ((MediaQuery.sizeOf(
                                                                  context)
                                                              .width -
                                                          48) *
                                                      1 /
                                                      2);
                                                } else if ((MediaQuery.sizeOf(
                                                                context)
                                                            .width >=
                                                        810.0) &&
                                                    (MediaQuery.sizeOf(context)
                                                            .width <
                                                        1280.0)) {
                                                  return ((MediaQuery.sizeOf(
                                                                  context)
                                                              .width -
                                                          48) *
                                                      1 /
                                                      2);
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width >
                                                    1280.0) {
                                                  return ((MediaQuery.sizeOf(
                                                                  context)
                                                              .width -
                                                          48) *
                                                      1 /
                                                      2);
                                                } else {
                                                  return ((MediaQuery.sizeOf(
                                                                  context)
                                                              .width -
                                                          48) *
                                                      1 /
                                                      2);
                                                }
                                              }(),
                                              decoration: const BoxDecoration(),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (FFAppState()
                                                          .cuisinesId
                                                          .contains(
                                                              getJsonField(
                                                            cuisinesListItem,
                                                            r'''$._id''',
                                                          ).toString()) ==
                                                      true) {
                                                    FFAppState()
                                                        .removeFromCuisinesId(
                                                            getJsonField(
                                                      cuisinesListItem,
                                                      r'''$._id''',
                                                    ).toString());
                                                    FFAppState().update(() {});
                                                  } else {
                                                    FFAppState()
                                                        .addToCuisinesId(
                                                            getJsonField(
                                                      cuisinesListItem,
                                                      r'''$._id''',
                                                    ).toString());
                                                    FFAppState().update(() {});
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Builder(
                                                      builder: (context) {
                                                        if (FFAppState()
                                                                .cuisinesId
                                                                .contains(
                                                                    getJsonField(
                                                                  cuisinesListItem,
                                                                  r'''$._id''',
                                                                ).toString()) ==
                                                            true) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Group_33625.png',
                                                                width: 20.0,
                                                                height: 20.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Rectangle_373.png',
                                                                width: 20.0,
                                                                height: 20.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    Text(
                                                      getJsonField(
                                                        cuisinesListItem,
                                                        r'''$.name''',
                                                      ).toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SF Pro Display',
                                                            color: FFAppState()
                                                                        .cuisinesId
                                                                        .contains(
                                                                            getJsonField(
                                                                          cuisinesListItem,
                                                                          r'''$._id''',
                                                                        )
                                                                                .toString()) ==
                                                                    true
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryTextColor
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .black40,
                                                            fontSize: 17.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts:
                                                                false,
                                                            lineHeight: 1.5,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          FFAppState().filterVariable = false;
                          FFAppState().categoryId = '';
                          FFAppState().cuisinesId = [];
                          FFAppState().update(() {});
                        },
                        text: 'Clear',
                        options: FFButtonOptions(
                          height: 56.0,
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
                                fontSize: 18.0,
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
                          await RecipeAppGroup.filterRecipeApiCall.call(
                            categoryId: FFAppState().categoryId,
                            cuisinesIdList: FFAppState().cuisinesId,
                            userId: FFAppState().userId,
                          );

                          FFAppState().filterVariable = true;
                          FFAppState().update(() {});
                          FFAppState().clearFilterCacheCache();
                          context.safePop();
                        },
                        text: 'Apply',
                        options: FFButtonOptions(
                          height: 56.0,
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
                                fontSize: 18.0,
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
