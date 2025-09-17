import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/single_appbar/single_appbar_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'my_ai_recipes_model.dart';
export 'my_ai_recipes_model.dart';

class MyAiRecipesWidget extends StatefulWidget {
  const MyAiRecipesWidget({super.key});

  @override
  State<MyAiRecipesWidget> createState() => _MyAiRecipesWidgetState();
}

class _MyAiRecipesWidgetState extends State<MyAiRecipesWidget> {
  late MyAiRecipesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyAiRecipesModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // App Bar
        const SingleAppbarWidget(
          key: ValueKey('MyAiRecipesAppBar'),
          text: 'My Recipe AI',
        ),

        // Main Content
        Expanded(
          child: Builder(
            builder: (context) {
              if (FFAppState().connected == true) {
                return FutureBuilder<ApiCallResponse>(
                  future: RecipeAppGroup.getUserAiRecipesApiCall.call(
                    token: FFAppState().token,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFFF6B35),
                            ),
                          ),
                        ),
                      );
                    }
                    final listViewGetUserAiRecipesApiResponse = snapshot.data!;

                    return RefreshIndicator(
                      color: FlutterFlowTheme.of(context).tertiary,
                      onRefresh: () async {
                        safeSetState(() {});
                      },
                      child: Builder(
                        builder: (context) {
                          final aiRecipesList =
                              (RecipeAppGroup.getUserAiRecipesApiCall
                                      .aiRecipesList(
                                        listViewGetUserAiRecipesApiResponse
                                            .jsonBody,
                                      )
                                      ?.toList() ??
                                  []);

                          if (aiRecipesList.isEmpty) {
                            return Center(
                              child: SizedBox(
                                width: 250.0,
                                height: 300.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.auto_awesome_outlined,
                                      size: 80.0,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      'No AI Recipes Yet',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Create your first AI recipe using our AI Recipe Creator!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        context.pushNamed('AiRecipeSearch');
                                      },
                                      icon: const Icon(Icons.auto_awesome),
                                      label: const Text('Create AI Recipe'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 12.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              16.0,
                            ),
                            itemCount: aiRecipesList.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16.0),
                            itemBuilder: (context, aiRecipesListIndex) {
                              final aiRecipesListItem =
                                  aiRecipesList[aiRecipesListIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // Navigate to AI recipe detail
                                  context.pushNamed(
                                    'AiRecipeDetailScreen',
                                    queryParameters: {
                                      'aiRecipeId': serializeParam(
                                        getJsonField(
                                          aiRecipesListItem,
                                          r'''$._id''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x0D000000),
                                        offset: Offset(0.0, 2.0),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Header with AI badge
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                getJsonField(
                                                  aiRecipesListItem,
                                                  r'''$.recipeName''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              'SF Pro Display',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.auto_awesome,
                                                    color: Colors.white,
                                                    size: 14.0,
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  Text(
                                                    'AI',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              'SF Pro Display',
                                                          color: Colors.white,
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12.0),

                                        // Recipe Content Preview
                                        Text(
                                          getJsonField(
                                            aiRecipesListItem,
                                            r'''$.recipeContent''',
                                          ).toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        const SizedBox(height: 12.0),

                                        // Recipe Info Row
                                        Row(
                                          children: [
                                            // Cooking Time
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  '${getJsonField(
                                                    aiRecipesListItem,
                                                    r'''$.cookingTime''',
                                                  )} min',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 16.0),

                                            // Serving Size
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.people_outline,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  '${getJsonField(
                                                    aiRecipesListItem,
                                                    r'''$.servingSize''',
                                                  )} servings',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 16.0),

                                            // Difficulty Level
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.signal_cellular_alt,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  getJsonField(
                                                    aiRecipesListItem,
                                                    r'''$.difficultyLevel''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ],
                                            ),

                                            const Spacer(),

                                            // Delete Button
                                            InkWell(
                                              onTap: () async {
                                                // Show confirmation dialog
                                                final shouldDelete =
                                                    await showDialog<bool>(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                        'Delete Recipe'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this AI recipe?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true),
                                                        child: const Text(
                                                            'Delete'),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                if (shouldDelete == true) {
                                                  // Delete the recipe
                                                  final deleteResponse =
                                                      await RecipeAppGroup
                                                          .deleteAiRecipeApiCall
                                                          .call(
                                                    recipeId: getJsonField(
                                                      aiRecipesListItem,
                                                      r'''$._id''',
                                                    ).toString(),
                                                    token: FFAppState().token,
                                                  );

                                                  if (deleteResponse
                                                      .succeeded) {
                                                    await actions
                                                        .showCustomToastBottom(
                                                            'AI Recipe deleted successfully');
                                                    safeSetState(() {});
                                                  } else {
                                                    await actions
                                                        .showCustomToastBottom(
                                                            'Failed to delete AI Recipe');
                                                  }
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
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
    );
  }
}
