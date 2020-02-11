import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';

AdmobInterstitial interstitialAd;
AdmobBannerSize bannerSize;

void clickAdmob(context, void callBack(), int maxNumber) {
  var rng = new Random();
  if (rng.nextInt(100) <= maxNumber) {
    loadingAds(context);
    interstitialAd = AdmobInterstitial(
      adUnitId: admobInterstitialID,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        // if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEventAdmob(event, args, 'Interstitial', () {
          Navigator.pop(context);
          callBack();
        });
      },
    )..load();
  } else {
    callBack();
  }
}

void handleEventAdmob(AdmobAdEvent event, Map<String, dynamic> args, String adType, Function callBack) async {
  switch (event) {
    case AdmobAdEvent.loaded:
      interstitialAd.show();
      break;
    case AdmobAdEvent.opened:
      break;
    case AdmobAdEvent.closed:
      callBack();
      break;
    case AdmobAdEvent.failedToLoad:
      callBack();
      break;
    case AdmobAdEvent.rewarded:
      break;
    default:
  }
}

void loadingAds(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: new BoxDecoration(),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(padding: EdgeInsets.only(right: 15.0), child: new CircularProgressIndicator()),
              new Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}

void handleEventBanner(AdmobAdEvent event, Map<String, dynamic> args, String adType) async {
  switch (event) {
    case AdmobAdEvent.loaded:
      break;
    case AdmobAdEvent.opened:
      break;
    case AdmobAdEvent.closed:
      break;
    case AdmobAdEvent.failedToLoad:
      break;
    case AdmobAdEvent.rewarded:
      break;
    default:
  }
}

Widget bannerWidget(context, bannerSize) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.bottomCenter,
    child: AdmobBanner(
      adUnitId: admobBannerID,
      adSize: bannerSize,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEventBanner(event, args, 'Banner');
      },
    ),
  );
}
