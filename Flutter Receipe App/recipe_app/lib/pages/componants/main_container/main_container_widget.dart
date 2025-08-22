import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main_container_model.dart';
export 'main_container_model.dart';

class MainContainerWidget extends StatefulWidget {
  const MainContainerWidget({
    super.key,
    required this.image,
    required this.name,
    required this.avreragerating,
    required this.totalReview,
    required this.totaltime,
    required this.onFavTap,
    required this.mainTap,
    bool? favCondition,
  }) : favCondition = favCondition ?? false;

  final String? image;
  final String? name;
  final double? avreragerating;
  final double? totalReview;
  final String? totaltime;
  final Future Function()? onFavTap;
  final Future Function()? mainTap;
  final bool favCondition;

  @override
  State<MainContainerWidget> createState() => _MainContainerWidgetState();
}

class _MainContainerWidgetState extends State<MainContainerWidget> {
  late MainContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainContainerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.mainTap?.call();
      },
      child: Container(
        width: () {
          if (MediaQuery.sizeOf(context).width < 810.0) {
            return ((MediaQuery.sizeOf(context).width - 48) * 1 / 2);
          } else if ((MediaQuery.sizeOf(context).width >= 810.0) &&
              (MediaQuery.sizeOf(context).width < 1280.0)) {
            return ((MediaQuery.sizeOf(context).width - 80) * 1 / 4);
          } else if (MediaQuery.sizeOf(context).width >= 1280.0) {
            return ((MediaQuery.sizeOf(context).width - 112) * 1 / 6);
          } else {
            return ((MediaQuery.sizeOf(context).width - 144) * 1 / 8);
          }
        }(),
        height: 220.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              color: FlutterFlowTheme.of(context).shadowcolor,
              offset: const Offset(
                0.0,
                4.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: const AlignmentDirectional(1.0, -1.0),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(milliseconds: 200),
                      fadeOutDuration: const Duration(milliseconds: 200),
                      imageUrl: widget.image!,
                      width: double.infinity,
                      height: 128.0,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.0, 0.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await widget.onFavTap?.call();
                      },
                      child: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).samewhite,
                          shape: BoxShape.circle,
                        ),
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            if (widget.favCondition == true) {
                              return SvgPicture.asset(
                                'assets/images/Heart_fill.svg',
                                width: 16.0,
                                height: 16.0,
                                fit: BoxFit.contain,
                              );
                            } else {
                              return SvgPicture.asset(
                                'assets/images/Heart.svg',
                                width: 16.0,
                                height: 16.0,
                                fit: BoxFit.contain,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.name,
                        'Name',
                      ),
                      textAlign: TextAlign.start,
                      maxLines: widget.avreragerating == 0.0 ? 2 : 1,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: false,
                            lineHeight: 1.5,
                          ),
                    ),
                    if (valueOrDefault<double>(
                          widget.avreragerating,
                          5.0,
                        ) !=
                        0.0)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: SvgPicture.asset(
                                'assets/images/star_yellow.svg',
                                width: 18.0,
                                height: 18.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              widget.avreragerating?.toString(),
                              '5',
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryTextColor,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                  lineHeight: 1.2,
                                ),
                          ),
                          Text(
                            '(${functions.numberFormatters(widget.totalReview!.toString())} reviews)',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryTextColor,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                  lineHeight: 1.2,
                                ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: SvgPicture.asset(
                              'assets/images/clock_orange.svg',
                              width: 18.0,
                              height: 18.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget.totaltime,
                            '1',
                          ),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryTextColor,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                    lineHeight: 1.2,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
