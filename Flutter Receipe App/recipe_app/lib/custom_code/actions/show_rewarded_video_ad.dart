// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/rewarded_video_ad_init_action.dart';
import '/flutter_flow/admob_util.dart';

Future showRewardedVideoAd(
  Future Function() failedAction,
  Future Function() successAction,
) async {
  // Add your function code here!
  if (rewardedAd == null) {
    print('Rewarded Video Ad is not loaded yet.');
    return;
  }

  // Assign callbacks before showing the ad
  rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      rewardedVideoAdInitAction();
      successAction();

      // Reinitialize the ad after it's dismissed
    },
    onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print('Failed to show full-screen content: ${error.message}');
      rewardedVideoAdInitAction(); // Reinitialize the ad after a failure
      failedAction();
    },
  );

  // Show the ad and reward the user
  rewardedAd!.show(onUserEarnedReward: (ad, reward) {
    // FFAppState().overAllPoints += points;
    //  print('User rewarded with $points points.');
  });

  rewardedAd = null; // Reset the ad after showing it
}
