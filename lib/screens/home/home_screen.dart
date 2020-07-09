import 'dart:async';
import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/main.dart';
import 'package:guide_ice_scream/screens/about/about_screen.dart';
import 'package:guide_ice_scream/screens/open_wa/open_wa_screen.dart';
import 'package:guide_ice_scream/screens/web/web_screen.dart';
import 'package:guide_ice_scream/util/IntentAnimation.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdmobInterstitial interstitialAd;
  StreamController loadingStream;
  AdmobBannerSize bannerSize;

  String appId;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  double heightScreen = 0;

  PageController _pageController;

  bool isLoading = false;

  @override
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingStream = new StreamController();
  }

  @override
  void callBack(key, data) {
    switch (key) {
      case "SHARE":
        String link = urlApp + appId;
        Share.share(link);
        break;
      case "FEEDBACK":
        launchURL("mailto:${mailFeedback}?subject=FeedBack ${nameApp}&body=");
        break;
      case "RATE":
        platform.invokeMethod("rateManual");
        break;
//      case "ABOUT":
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => ProcyScreen()),
//        );

        break;
      default:
    }
  }

  getAppID() async {
    appId = await platform.invokeMethod("getAppId");
//    setState(() {
//      appId;
//    });
  }

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    getAppID();
    print("$heightScreen   3213131321");
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/bg3.png",
              fit: BoxFit.fill,
              height: heightScreen,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset("assets/images/banner_tran.png"),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          intentToScreen(context, WebScreen());
                        },
                        child: Container(
                          width: 120,
                          child: Image.asset("assets/images/scan.png"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          intentToScreen(context, OpenWAScreen());
                        },
                        child: Container(
                          width: 120,
                          child: Image.asset("assets/images/chat.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          String link = urlApp + appId;
                          Share.share(link);
                        },
                        child: Container(
                          width: 120,
                          child: Image.asset("assets/images/more.png"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          intentToScreen(context, AboutScren());
                        },
                        child: Container(
                          width: 120,
                          child: Image.asset("assets/images/about.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                isShowBanner
                    ? AdmobBanner(
                        adSize: heightScreen > 600
                            ? AdmobBannerSize.LARGE_BANNER
                            : AdmobBannerSize.BANNER,
                        adUnitId: admobBannerID,
                      )
                    : Container()
              ],
            ),
          ),
          StreamBuilder(
            stream: loadingStream.stream,
            builder: (ctx, snap) => snap.data is BlocLoading
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 80),
                      alignment: Alignment.center,
                      color: Colors.white12,
                      child: Image.asset(
                        "assets/images/loading_v1.gif",
                        height: 70,
                        width: 70,
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  void intentToScreen(BuildContext context, Widget screen) {
    int ran = new Random().nextInt(100);
    if (ran < 70
//        && isShowInter
        ) {
      loadingStream.sink.add(new BlocLoading());
      platform.invokeMethod("showInter").then((value) {
        IntentAnimation.intentNomal(
            context: context,
            screen: screen,
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 800));
        loadingStream.sink.add("");
      });
//      interstitialAd = new AdmobInterstitial(
//          adUnitId: admobInterstitialID,
//          listener: (event, args) {
//            switch (event) {
//              case AdmobAdEvent.loaded:
//                interstitialAd.show();
//                break;
//              case AdmobAdEvent.closed:
//                loadingStream.sink.add("");
//                IntentAnimation.intentNomal(
//                    context: context,
//                    screen: screen,
//                    option: IntentAnimationOption.RIGHT_TO_LEFT,
//                    duration: Duration(milliseconds: 800));
//                break;
//              case AdmobAdEvent.failedToLoad:
//                loadingStream.sink.add("");
//                IntentAnimation.intentNomal(
//                    context: context,
//                    screen: screen,
//                    option: IntentAnimationOption.RIGHT_TO_LEFT,
//                    duration: Duration(milliseconds: 800));
//                break;
//              default:
//            }
//          });
//      interstitialAd.load();
    } else
      IntentAnimation.intentNomal(
          context: context,
          screen: screen,
          option: IntentAnimationOption.RIGHT_TO_LEFT,
          duration: Duration(milliseconds: 800));
  }
}

class BlocLoading {}
