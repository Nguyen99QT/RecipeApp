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

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlConverter extends StatefulWidget {
  const HtmlConverter({
    super.key,
    this.width,
    this.height,
    required this.text,
  });

  final double? width;
  final double? height;
  final String text;

  @override
  State<HtmlConverter> createState() => _HtmlConverterState();
}

class _HtmlConverterState extends State<HtmlConverter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Html(
          data: widget.text,
          onLinkTap: (url, attributes, element) {
            // widget.isMail == true ? () {} :
            launchURL(url!);
            // widget.isMail == true
            //     ? launchUrl(Uri(
            //         scheme: 'mailto',
            //         path: widget.mail,
            //       ))
            //     : () {};
          },
          // onLinkTap: (url, context, Map attributes, element) async {
          //   // launchURL(url);
          //   // widget.isMail == true
          //   //     ? launchUrl(Uri(
          //   //         scheme: 'mailto',
          //   //         path: widget.mail,
          //   //       ))
          //   //     : () {};
          //   // return true;
          // },
          style: {
            "body": Style(
              fontSize: FontSize(16),
              color: FlutterFlowTheme.of(context).primaryText,
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.17,
              fontWeight: FontWeight.w400,
            ),
            "p": Style(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: FontSize(16),
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.17,
              fontWeight: FontWeight.w400,
            ),
            "li": Style(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: FontSize(16),
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.17,
              fontWeight: FontWeight.w400,
            ),
            // FlutterFlowTheme.of(context).bodyMedium.override(
            //       fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            //       fontSize: 17,
            //       letterSpacing: 0.17,
            //       fontWeight: FontWeight.w500,
            //       useGoogleFonts: GoogleFonts.asMap().containsKey(
            //           FlutterFlowTheme.of(context).bodyMediumFamily),
            //     ),
            // "p":
            // : FlutterFlowTheme.of(context).bodyMedium.override(
            //       fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            //       fontSize: 17,
            //       letterSpacing: 0.17,
            //       fontWeight: FontWeight.w500,
            //       useGoogleFonts: GoogleFonts.asMap().containsKey(
            //           FlutterFlowTheme.of(context).bodyMediumFamily),
            //     ),
            // "h3" : FlutterFlowTheme.of(context).bodyMedium.override(
            //       fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            //       fontSize: 18,
            //       letterSpacing: 0,
            //       fontWeight: FontWeight.bold,
            //       useGoogleFonts: GoogleFonts.asMap().containsKey(
            //           FlutterFlowTheme.of(context).bodyMediumFamily),
            //     ),
          },
        ),
        // MarkdownBody(
        //   data: widget.text,
        //   styleSheet: MarkdownStyleSheet(
        //     p: FlutterFlowTheme.of(context).bodyMedium.override(
        //           fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
        //           fontSize: 17,
        //           letterSpacing: 0.17,
        //           fontWeight: FontWeight.w500,
        //           useGoogleFonts: GoogleFonts.asMap().containsKey(
        //               FlutterFlowTheme.of(context).bodyMediumFamily),
        //         ),
        //     h3: FlutterFlowTheme.of(context).bodyMedium.override(
        //           fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
        //           fontSize: 18,
        //           letterSpacing: 0,
        //           fontWeight: FontWeight.bold,
        //           useGoogleFonts: GoogleFonts.asMap().containsKey(
        //               FlutterFlowTheme.of(context).bodyMediumFamily),
        //         ),
        //   ),
        // ),
        // HtmlWidget(
        //   widget.text,
        //   baseUrl: Uri.parse(widget.url),
        //   onTapUrl: (url) {
        //     launchURL(url);
        //     return true;
        //   },
        //   customStylesBuilder: (element) {
        //     if (element.localName == 'p') {
        //       return {
        //         'font-family': 'Ivy Mode',
        //         'font-size': '17px',
        //         'letter-spacing': '0.17px',
        //         'font-weight': '500',
        //       };
        //     }
        //     if (element.localName == 'h3') {
        //       return {
        //         'font-family': 'Ivy Mode',
        //         'font-size': '18px',
        //         'letter-spacing': '0px',
        //         'font-weight': '500',
        //       };
        //     }
        //     return null;
        //   },

        // onLoadingBuilder: (context, element, loadingProgress) {
        //   return SizedBox(

        //     height: MediaQuery.of(context).size.height * 0.67,
        //     child: SpinKitCircle(
        //       color: FlutterFlowTheme.of(context).primary,
        //       size: 50.0,
        //     ),
        //   );
        // },
        // ),
      ],
    );
  }
}

Future<void> _handleURLTap(String? url) async {
  if (url != null) {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
