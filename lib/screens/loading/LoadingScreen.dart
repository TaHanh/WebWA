import 'dart:async';
import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/screens/home/home_screen.dart';
import 'package:guide_ice_scream/util/IntentAnimation.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var isAdsLoaded = false;
  var heightScreen;
  var isShowLoading = true;
  StreamController loadingStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingStream = new StreamController();
    Admob.initialize(admobAppID);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/bg3.png",
              fit: BoxFit.fill,
              height: heightScreen,
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                child: Image.asset("assets/images/banner_tran.png"),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: isShowBanner
                      ? AdmobBanner(
                          adUnitId: admobBannerID,
                          adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                          listener: (event, arg) {
                            switch (event) {
                              case AdmobAdEvent.loaded:
                                {
                                  loadingStream.sink.add("");

                                  Timer(Duration(seconds: 3), () {
                                    IntentAnimation.intentPushReplacement(
                                        context: context,
                                        screen: HomeScreen(),
                                        option:
                                            IntentAnimationOption.RIGHT_TO_LEFT,
                                        duration: Duration(milliseconds: 800));
                                  });
                                  break;
                                }
                              case AdmobAdEvent.failedToLoad:
                                {
                                  IntentAnimation.intentPushReplacement(
                                      context: context,
                                      screen: HomeScreen(),
                                      option:
                                          IntentAnimationOption.RIGHT_TO_LEFT,
                                      duration: Duration(milliseconds: 800));
                                  break;
                                }
                              case AdmobAdEvent.clicked:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.impression:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.opened:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.leftApplication:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.closed:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.completed:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.rewarded:
                                // TODO: Handle this case.
                                break;
                              case AdmobAdEvent.started:
                                // TODO: Handle this case.
                                break;
                            }
                          },
                        )
                      : Container()),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
          StreamBuilder(
            stream: loadingStream.stream,
            builder: (ctx, snap) => snap.data is BlocLoading
                ? Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/loading_v1.gif",
                            width: 60,
                            height: 60,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: Text(
                            "Loading is Contain Ads...",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      ),
    ));
  }

  void getData() {
    print("get data");
    isAdsLoaded = false;
    loadingStream.sink.add(new BlocLoading());
    http
        .get(
            "https://raw.githubusercontent.com/vandoannguyen/api_ads/master/WebWA.json")
        .then((value) {
      dynamic data = jsonDecode(value.body);
      print("demo");
      print(value.body);
      setState(() {
        isAdsLoaded = true;
        admobInterstitialID = data["ad_inter_id"];
        admobBannerID = data["ad_banner_id"];
        isShowInter = data["is_show_inter"];
        isShowBanner = data["is_show_banner"];
        isShowBanner = false;
        isShowInter = false;
      });
      if (!isShowBanner) {
        loadingStream.sink.add("");
        IntentAnimation.intentPushReplacement(
            context: context,
            screen: HomeScreen(),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 800));
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
