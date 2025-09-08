import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'ai_recipe_search_model.dart';

export 'ai_recipe_search_model.dart';

class AiRecipeSearchWidget extends StatefulWidget {
  const AiRecipeSearchWidget({super.key});

  @override
  State<AiRecipeSearchWidget> createState() => _AiRecipeSearchWidgetState();
}

class _AiRecipeSearchWidgetState extends State<AiRecipeSearchWidget> {
  late AiRecipeSearchModel _model;

  @override
  void initState() {
    super.initState();
    _model = AiRecipeSearchModel()..initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Text(
            'AI Recipe Search',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.smart_toy,
                  size: 80,
                  color: FlutterFlowTheme.of(context).primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'AI Recipe Generator',
                  style: FlutterFlowTheme.of(context).headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Generate personalized recipes using AI technology',
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FFButtonWidget(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('AI Recipe generation coming soon!'),
                      ),
                    );
                  },
                  text: 'Generate Recipe',
                  icon: const Icon(
                    Icons.auto_awesome,
                    size: 24.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 60.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 0.0, 24.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 3.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features Coming Soon:',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildFeatureItem(
                            context, '🥗', 'Ingredient-based recipes'),
                        _buildFeatureItem(context, '📷', 'Image recognition'),
                        _buildFeatureItem(
                            context, '⏱️', 'Custom cooking times'),
                        _buildFeatureItem(
                            context, '👥', 'Serving size adjustment'),
                        _buildFeatureItem(
                            context, '🚫', 'Dietary restrictions'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16.0)),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              text,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
