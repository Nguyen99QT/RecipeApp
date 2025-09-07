import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/pages/componants/no_notifications_yet_container/no_notifications_yet_container_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  late NotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customAppbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomAppbarWidget(
                  text: 'Notifications',
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
                          future: FFAppState().getAllNotificationCache(
                            requestFn: () =>
                                RecipeAppGroup.getAllNotificationApiCall.call(),
                          ),
                          builder: (context, snapshot) {
                            // Debug logging
                            print('[DEBUG] NotificationPage FutureBuilder state:');
                            print('  - hasData: ${snapshot.hasData}');
                            print('  - hasError: ${snapshot.hasError}');
                            print('  - connectionState: ${snapshot.connectionState}');
                            
                            if (snapshot.hasError) {
                              print('  - Error: ${snapshot.error}');
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 64,
                                      color: FlutterFlowTheme.of(context).error,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Failed to load notifications',
                                      style: FlutterFlowTheme.of(context).headlineSmall,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please check your internet connection',
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                  ],
                                ),
                              );
                            }
                            
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              print('  - Loading data...');
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
                            
                            final listViewGetAllNotificationApiResponse = snapshot.data!;
                            
                            // Debug API response
                            print('  - API Response received:');
                            print('    statusCode: ${listViewGetAllNotificationApiResponse.statusCode}');
                            print('    succeeded: ${listViewGetAllNotificationApiResponse.succeeded}');
                            print('    bodyText: ${listViewGetAllNotificationApiResponse.bodyText}');

                            return Builder(
                              builder: (context) {
                                final notificationList =
                                    RecipeAppGroup.getAllNotificationApiCall
                                            .notificationList(
                                              listViewGetAllNotificationApiResponse
                                                  .jsonBody,
                                            )
                                            ?.toList() ??
                                        [];
                                
                                // Debug notification data
                                print('  - Notification list length: ${notificationList.length}');
                                if (notificationList.isNotEmpty) {
                                  print('  - First notification sample:');
                                  final first = notificationList.first;
                                  print('    title: ${getJsonField(first, r'''$.title''')}');
                                  print('    description: ${getJsonField(first, r'''$.description''')}');
                                  print('    date: ${getJsonField(first, r'''$.date''')}');
                                }
                                
                                if (notificationList.isEmpty) {
                                  print('  - No notifications found, showing empty state');
                                  return const Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child:
                                          NoNotificationsYetContainerWidget(),
                                    ),
                                  );
                                }

                                return RefreshIndicator(
                                  key: const Key('RefreshIndicator_u6xvpywm'),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  onRefresh: () async {},
                                  child: ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      16.0,
                                      0,
                                      16.0,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: notificationList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 16.0),
                                    itemBuilder:
                                        (context, notificationListIndex) {
                                      final notificationListItem =
                                          notificationList[
                                              notificationListIndex];
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .samewhite,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/notification_themeColor.svg',
                                                      width: 24.0,
                                                      height: 24.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          14.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        getJsonField(
                                                          notificationListItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'SF Pro Display',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .sameBlack,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              useGoogleFonts:
                                                                  false,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Html(
                                                        data: getJsonField(
                                                          notificationListItem,
                                                          r'''$.description''',
                                                        ).toString(),
                                                        onLinkTap:
                                                            (url, _, __) =>
                                                                launchURL(url!),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          functions
                                                              .dateDifferenceBetween(
                                                                  getJsonField(
                                                            notificationListItem,
                                                            r'''$.date''',
                                                          ).toString()),
                                                          'date',
                                                        ),
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
                                                      // Show "View Details" button for new_recipe notifications
                                                      if (getJsonField(
                                                        notificationListItem,
                                                        r'''$.type''',
                                                      ) == 'new_recipe' && getJsonField(
                                                        notificationListItem,
                                                        r'''$.recipeId._id''',
                                                      ) != null)
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 8.0),
                                                          child: ElevatedButton(
                                                            onPressed: () async {
                                                              final recipeId = getJsonField(
                                                                notificationListItem,
                                                                r'''$.recipeId._id''',
                                                              ).toString();
                                                              
                                                              final recipeName = getJsonField(
                                                                notificationListItem,
                                                                r'''$.recipeId.name''',
                                                              ).toString();
                                                              
                                                              // Navigate to recipe detail page
                                                              context.pushNamed(
                                                                'recipe_detail_screen',
                                                                queryParameters: {
                                                                  'recipeDetailId': serializeParam(
                                                                    recipeId,
                                                                    ParamType.String,
                                                                  ),
                                                                  'name': serializeParam(
                                                                    recipeName,
                                                                    ParamType.String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: FlutterFlowTheme.of(context).primaryTheme,
                                                              foregroundColor: FlutterFlowTheme.of(context).samewhite,
                                                              padding: const EdgeInsets.symmetric(
                                                                horizontal: 16.0,
                                                                vertical: 8.0,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Icon(
                                                                  Icons.visibility,
                                                                  size: 16.0,
                                                                  color: FlutterFlowTheme.of(context).samewhite,
                                                                ),
                                                                const SizedBox(width: 6.0),
                                                                Text(
                                                                  'Xem chi tiết',
                                                                  style: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily: 'SF Pro Display',
                                                                        color: FlutterFlowTheme.of(context).samewhite,
                                                                        fontSize: 14.0,
                                                                        fontWeight: FontWeight.w600,
                                                                        useGoogleFonts: false,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ].divide(
                                                        const SizedBox(height: 4.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
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
