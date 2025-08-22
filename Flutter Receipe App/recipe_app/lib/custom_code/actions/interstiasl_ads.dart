// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../../flutter_flow/admob_util.dart' as admob;

Future<bool> interstiaslAds() async {
  // Add your function code here!
  bool success = false;
  admob.loadInterstitialAd(
    FFAppState().anInterstitial,
    FFAppState().ioInterstitial,
    false,
  );

  success = await admob.showInterstitialAd();

  return success;
}
