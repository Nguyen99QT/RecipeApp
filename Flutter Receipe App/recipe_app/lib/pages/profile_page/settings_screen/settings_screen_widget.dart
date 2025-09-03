import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/componants/custom_appbar/custom_appbar_widget.dart';
import '/pages/componants/rate_us_bottomsheet/rate_us_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'settings_screen_model.dart';
export 'settings_screen_model.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({super.key});

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreenWidget> {
  late SettingsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsScreenModel());

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
                  text: 'Settings',
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 0.0),
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
                        // Change Password - Only show when logged in
                        if (FFAppState().isLogin == true)
                          _buildSettingsItem(
                            context,
                            'Change password',
                            'assets/images/Change_password_img.svg',
                            () => context.pushNamed('changepassword_screen'),
                          ),
                        
                        // Terms & Conditions - Always available  
                        _buildSettingsItem(
                          context,
                          'Terms & condition',
                          'assets/images/stickynote.svg',
                          () => context.pushNamed('terms_conditions_screen'),
                        ),
                        
                        // FAQ - Always available
                        _buildSettingsItem(
                          context,
                          'FAQ\'s',
                          'assets/images/message-question.svg',
                          () => context.pushNamed('FAQSPage'),
                        ),
                        
                        // Privacy Policy - Always available
                        _buildSettingsItem(
                          context,
                          'Privacy policy',
                          'assets/images/security.svg',
                          () => context.pushNamed('privacypolicy_screen'),
                        ),
                        
                        // Feedback - Always available
                        _buildSettingsItem(
                          context,
                          'Feedback',
                          'assets/images/Review_add_successfully.svg',
                          () => _showFeedbackBottomSheet(context),
                        ),
                      ],
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

  void _showFeedbackBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: const RateUsBottomsheetWidget(),
        );
      },
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    String iconPath,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lightGrey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 16.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).samewhite,
                    shape: BoxShape.circle,
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).sameBlack,
                      fontSize: 17.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts: false,
                      lineHeight: 1.5,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: SvgPicture.asset(
                    'assets/images/arrow_right.svg',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ].divide(const SizedBox(width: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
