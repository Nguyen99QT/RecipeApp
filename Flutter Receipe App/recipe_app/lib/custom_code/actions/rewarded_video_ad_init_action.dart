// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import for AdMob

RewardedAd? rewardedAd;

Future rewardedVideoAdInitAction() async {
  // Add your function code here!
  final adUnitId = Platform.isAndroid
      ? FFAppState().rewardedVideoAndroidId
      : FFAppState().rewardedVideoIOSId;

  RewardedAd.load(
    adUnitId: adUnitId,
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        rewardedAd = ad;
        print('Rewarded video ad loaded.');
      },
      onAdFailedToLoad: (err) {
        print('Failed to load a rewarded video ad: ${err.message}');
      },
    ),
  );
}
