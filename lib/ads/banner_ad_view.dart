import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pingpong_score_tracker/main.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  static const androidTestAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const iosTestAdUnitId = 'ca-app-pub-3940256099942544/2934735716';

  static const androidAdUnitId = 'ca-app-pub-4623610003844927/5306433506';
  static const iosAdUnitId = 'ca-app-pub-4623610003844927/5534460372';

  final bannerAd = BannerAd(
    size: AdSize.fluid,
    adUnitId: Platform.isAndroid
        ? isAdTestMode
            ? androidTestAdUnitId
            : androidAdUnitId
        : isAdTestMode
            ? iosTestAdUnitId
            : iosAdUnitId,
    listener: const BannerAdListener(),
    // listener: BannerAdListener(
    //   // Called when an ad is successfully received.
    //   onAdLoaded: (Ad ad) => print('Ad loaded.'),
    //   // Called when an ad request failed.
    //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //     // Dispose the ad here to free resources.
    //     ad.dispose();
    //     print('Ad failed to load: $error');
    //   },
    //   // Called when an ad opens an overlay that covers the screen.
    //   onAdOpened: (Ad ad) => print('Ad opened.'),
    //   // Called when an ad removes an overlay that covers the screen.
    //   onAdClosed: (Ad ad) => print('Ad closed.'),
    //   // Called when an impression occurs on the ad.
    //   onAdImpression: (Ad ad) => print('Ad impression.'),
    // ),
    request: const AdRequest(),
  );

  late Future<void> adLoadFuture;

  @override
  void initState() {
    super.initState();

    if (isFreeVersion) {
      adLoadFuture = bannerAd.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isFreeVersion) return widget.child;

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return widget.child;
        }
        return Row(
          children: _buildLandscapeWidgets(),
        );
      },
    );
  }

  List<Widget> _buildLandscapeWidgets() {
    final padding =
        Platform.isAndroid ? MediaQuery.of(context).viewPadding.right : 0.0;
    return [
      Padding(
        padding: EdgeInsets.only(left: padding),
        child: const SizedBox(width: 50),
      ),
      Expanded(
        child: widget.child,
      ),
      FutureBuilder(
        future: adLoadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(color: Colors.white, width: 50);
          }

          return Padding(
            padding: EdgeInsets.only(right: padding),
            child: Container(
              color: Colors.transparent,
              height: 320,
              width: 50,
              child: RotatedBox(
                quarterTurns: 3,
                child: AdWidget(ad: bannerAd),
              ),
            ),
          );
        },
      ),
    ];
  }
}
