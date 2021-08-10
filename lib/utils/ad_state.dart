import 'dart:io';
import 'package:moyori/app_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);
      
  BannerAd banner() { 
    return BannerAd(
      adUnitId: Platform.isAndroid ? 
          const String.fromEnvironment("GOOGLE_ADMOB_ID_ANDROID") : 
          const String.fromEnvironment("GOOGLE_ADMOB_ID_IOS"),
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print(""),
        onAdFailedToLoad: (Ad ad, LoadAdError error) { ad.dispose(); },
        onAdOpened: (Ad ad) => print(""),
        onAdClosed: (Ad ad) => print(""),
        onAdImpression: (Ad ad) => print(""),
      )
    );
  }
}

Widget adMobBanner(BuildContext context) {
  return firebaseRemoteConfig.getBool('admob_banner_enabled') ? Container(
    height: 60,
    decoration: BoxDecoration(
      border: const Border(
        bottom: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
    ),
    child: AdWidget(ad: AdState(MobileAds.instance.initialize()).banner()..load()),
  ) : Container();
}