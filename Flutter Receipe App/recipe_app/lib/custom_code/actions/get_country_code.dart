// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:devicelocale/devicelocale.dart';

Future getCountryCode() async {
  // Add your function code here!
  try {
    String? locale = await Devicelocale.currentLocale;
    if (locale != null) {
      String countryCode = locale.split('-').last;
      FFAppState().update(() {
        FFAppState().countryName = countryCode;
      });
      return countryCode;
    }
    return 'Unknown';
  } catch (e) {
    return 'Error';
  }
}
