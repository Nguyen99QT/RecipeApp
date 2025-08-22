// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_html/flutter_html.dart';

class ReadMoreHtml extends StatefulWidget {
  const ReadMoreHtml({
    super.key,
    this.width,
    this.height,
    this.htmlContent,
    this.maxLength,
  });

  final double? width;
  final double? height;
  final String? htmlContent;
  final int? maxLength;

  @override
  State<ReadMoreHtml> createState() => _ReadMoreHtmlState();
}

class _ReadMoreHtmlState extends State<ReadMoreHtml> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final content = widget.htmlContent ?? '';
    final maxLength = widget.maxLength ?? 100;
    final needsReadMore = content.length > maxLength;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Html(
          onLinkTap: (url, attributes, element) {
            if (url != null) {
              launchURL(url);
              print(url);
            }
          },
          data: _isExpanded
              ? content
              : (needsReadMore
                  ? '${content.substring(0, maxLength)}...'
                  : content),
        ),
        if (needsReadMore)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                _isExpanded ? 'Read less' : 'Read more',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).primaryTheme,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      useGoogleFonts: false,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
