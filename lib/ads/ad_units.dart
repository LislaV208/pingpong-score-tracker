import 'dart:io';

import 'package:pingpong_score_tracker/main.dart';

class AdUnits {
  static const androidTestBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
  static const iosTestBannerId = 'ca-app-pub-3940256099942544/2934735716';

  static const androidBannerAdId = 'ca-app-pub-4623610003844927/5306433506';
  static const iosBannerAdId = 'ca-app-pub-4623610003844927/5534460372';

  static final banner = Platform.isAndroid
      ? isAdTestMode
          ? androidTestBannerAdId
          : androidBannerAdId
      : isAdTestMode
          ? iosTestBannerId
          : iosBannerAdId;

  static const androidTestInterstitialAdId =
      'ca-app-pub-3940256099942544/1033173712';
  static const iosTestInterstitialAdId =
      'ca-app-pub-3940256099942544/4411468910';

  static const androidInterstitialAdId =
      'ca-app-pub-4623610003844927/3632622707';
  static const iosInterstitialAdId = 'ca-app-pub-4623610003844927/3064850330';

  static final interstitial = Platform.isAndroid
      ? isAdTestMode
          ? androidTestInterstitialAdId
          : androidInterstitialAdId
      : isAdTestMode
          ? iosTestInterstitialAdId
          : iosInterstitialAdId;
}
