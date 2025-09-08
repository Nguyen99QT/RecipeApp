import 'package:flutter/material.dart';
import '/pages/home_pages/ai_recipe_search/ai_recipe_search_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class AiRecipeIntegrationExample extends StatelessWidget {
  const AiRecipeIntegrationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text(
          'AI Recipe Integration',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AI Recipe Search Button
            FFButtonWidget(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AiRecipeSearchWidget(),
                  ),
                );
              },
              text: 'AI Recipe Search',
              icon: const Icon(
                Icons.smart_toy,
                size: 24.0,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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

            const SizedBox(height: 24.0),

            // Description
            Text(
              'Generate AI-powered recipes using ingredients or images!',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),

            const SizedBox(height: 16.0),

            // Features List
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
                      'AI Recipe Features:',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                              ),
                    ),
                    const SizedBox(height: 12.0),
                    _buildFeatureItem(
                        context, '📷', 'Multi-image upload support'),
                    _buildFeatureItem(
                        context, '📝', 'Text-based ingredient input'),
                    _buildFeatureItem(
                        context, '👥', 'Customizable serving sizes'),
                    _buildFeatureItem(context, '⏰', 'Cooking time preferences'),
                    _buildFeatureItem(
                        context, '🥗', 'Dietary restrictions support'),
                    _buildFeatureItem(
                        context, '🌍', 'Vietnamese & English language'),
                    _buildFeatureItem(context, '💾', 'Save favorite recipes'),
                  ],
                ),
              ),
            ),
          ],
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
