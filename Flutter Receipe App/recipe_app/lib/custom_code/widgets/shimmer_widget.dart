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

import 'package:shimmer/shimmer.dart';

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: double.infinity,
        height: 600,
      ),
    );
  }
}

// class BannerPlaceholder extends StatelessWidget {
//   const BannerPlaceholder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 200.0,
//         margin: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//         ));
//   }
// }

// class TitlePlaceholder extends StatelessWidget {
//   final double width;
//   const TitlePlaceholder({super.key, required this.width});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: width,
//             height: 12.0,
//             color: Colors.white,
//           ),
//           SizedBox(height: 8.0),
//           Container(
//             width: width,
//             height: 12.0,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum ContentLineType {
//   twoLines,
//   threeLines,
// }

// class ContentPlaceholder extends StatelessWidget {
//   final ContentLineType lineType;
//   const ContentPlaceholder({super.key, required this.lineType});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               width: 96.0,
//               height: 72.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               )),
//           SizedBox(height: 12.0),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 10.0,
//                   color: Colors.white,
//                   margin: const EdgeInsets.only(bottom: 8.0),
//                 ),
//                 if (lineType == ContentLineType.threeLines)
//                   Container(
//                     width: double.infinity,
//                     height: 10.0,
//                     color: Colors.white,
//                     margin: const EdgeInsets.only(bottom: 8.0),
//                   ),
//                 Container(
//                   width: 100.0,
//                   height: 10.0,
//                   color: Colors.white,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class ShimmerWidget extends StatefulWidget {
//   const ShimmerWidget({super.key, this.width, this.height});
//   final double? width;
//   final double? height;

//   @override
//   State<ShimmerWidget> createState() => _ShimmerWidgetState();
// }

// class _ShimmerWidgetState extends State<ShimmerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       enabled: true,
//       child: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             BannerPlaceholder(),
//             TitlePlaceholder(width: double.infinity),
//             SizedBox(height: 16.0),
//             ContentPlaceholder(
//               lineType: ContentLineType.threeLines,
//             ),
//             SizedBox(height: 16.0),
//             TitlePlaceholder(width: 200.0),
//             SizedBox(height: 16.0),
//             ContentPlaceholder(
//               lineType: ContentLineType.twoLines,
//             ),
//             SizedBox(height: 16.0),
//             TitlePlaceholder(width: 200.0),
//             SizedBox(height: 16.0),
//             ContentPlaceholder(
//               lineType: ContentLineType.twoLines,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BannerPlaceholder extends StatelessWidget {
//   const BannerPlaceholder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 200.0,
//         margin: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//         ));
//   }
// }

// class TitlePlaceholder extends StatelessWidget {
//   final double width;
//   const TitlePlaceholder({super.key, required this.width});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: width,
//             height: 12.0,
//             color: Colors.white,
//           ),
//           SizedBox(height: 8.0),
//           Container(
//             width: width,
//             height: 12.0,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum ContentLineType {
//   twoLines,
//   threeLines,
// }

// class ContentPlaceholder extends StatelessWidget {
//   final ContentLineType lineType;
//   const ContentPlaceholder({super.key, required this.lineType});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               width: 96.0,
//               height: 72.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               )),
//           SizedBox(height: 12.0),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 10.0,
//                   color: Colors.white,
//                   margin: const EdgeInsets.only(bottom: 8.0),
//                 ),
//                 if (lineType == ContentLineType.threeLines)
//                   Container(
//                     width: double.infinity,
//                     height: 10.0,
//                     color: Colors.white,
//                     margin: const EdgeInsets.only(bottom: 8.0),
//                   ),
//                 Container(
//                   width: 100.0,
//                   height: 10.0,
//                   color: Colors.white,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
