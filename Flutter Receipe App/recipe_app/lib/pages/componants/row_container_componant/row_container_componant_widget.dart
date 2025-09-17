import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'row_container_componant_model.dart';
export 'row_container_componant_model.dart';

class RowContainerComponantWidget extends StatefulWidget {
  const RowContainerComponantWidget({
    super.key,
    required this.image,
    required this.name,
    required this.totalTime,
    required this.averageReview,
    required this.totalReview,
    bool? onfavCondition,
    required this.onFavTap,
    required this.onMainTap,
  }) : onfavCondition = onfavCondition ?? false;

  final String? image;
  final String? name;
  final String? totalTime;
  final double? averageReview;
  final double? totalReview;
  final bool onfavCondition;
  final Future Function()? onFavTap;
  final Future Function()? onMainTap;

  @override
  State<RowContainerComponantWidget> createState() =>
      _RowContainerComponantWidgetState();
}

class _RowContainerComponantWidgetState
    extends State<RowContainerComponantWidget> {
  late RowContainerComponantModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RowContainerComponantModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await widget.onMainTap?.call();
        },
        child: Container(
          width: double.infinity,
          height: 114.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).samewhite,
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(0.0),
                ),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 200),
                  imageUrl: widget.image!,
                  width: 114.0,
                  height: 114.0,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, 0.0),
                  errorWidget: (context, error, stackTrace) => Container(
                    width: 114.0,
                    height: 114.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        topLeft: Radius.circular(12.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              valueOrDefault<String>(
                                widget.name,
                                'Name',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: widget.averageReview == 0.0 ? 2 : 1,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color:
                                        FlutterFlowTheme.of(context).sameBlack,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(
                            'assets/images/clock.svg',
                            width: 18.0,
                            height: 18.0,
                            fit: BoxFit.contain,
                          ),
                          Expanded(
                            child: Text(
                              valueOrDefault<String>(
                                widget.totalTime,
                                '1',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color:
                                        FlutterFlowTheme.of(context).sameBlack,
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                    lineHeight: 1.2,
                                  ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 8.0)),
                      ),
                      if (widget.averageReview != 0.0)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 0.0),
                              child: SvgPicture.asset(
                                'assets/images/star_yellow.svg',
                                width: 18.0,
                                height: 18.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget.averageReview?.toString(),
                                '1',
                              ),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color:
                                        FlutterFlowTheme.of(context).sameBlack,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                    lineHeight: 1.2,
                                  ),
                            ),
                            Expanded(
                              child: Text(
                                '(${functions.numberFormatters(widget.totalReview!.toString())} reviews)',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FlutterFlowTheme.of(context)
                                          .sameBlack,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                      lineHeight: 1.2,
                                    ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
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
                      color: FlutterFlowTheme.of(context).lightGrey,
                      shape: BoxShape.circle,
                    ),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (widget.onfavCondition == true) {
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
      ),
    );
  }
}
