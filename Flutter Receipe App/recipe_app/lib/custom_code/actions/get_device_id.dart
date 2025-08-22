// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math';

Future<String> getDeviceId() async {
  // Add your function code here!
  String deviceId = "Unknown device ID";

  // Generate a random device ID since device_info_plus is not available
  var random = Random();
  var randomId = random.nextInt(999999).toString().padLeft(6, '0');

  if (Platform.isIOS) {
    deviceId = "iOS_$randomId";
    FFAppState().deviceId = deviceId;
    return deviceId;
  } else if (Platform.isAndroid) {
    deviceId = "Android_$randomId";
    FFAppState().deviceId = deviceId;
    return deviceId;
  }

  // Handle other platforms if needed
  deviceId = "Unknown_$randomId";
  FFAppState().deviceId = deviceId;
  return deviceId;
}
