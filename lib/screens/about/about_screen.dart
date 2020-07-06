import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/screens/procy/procy.dart';
import 'package:guide_ice_scream/util/IntentAnimation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class AboutScren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                IntentAnimation.intentNomal(
                    context: context,
                    screen: ProcyScreen(),
                    option: IntentAnimationOption.RIGHT_TO_LEFT,
                    duration: Duration(milliseconds: 800));
              },
              child: ItemButton(
                  image: "assets/images/ic_privacy.png",
                  title: "Privacy Policy"),
            ),
            GestureDetector(
              onTap: () {
                launchURL(
                    "mailto:${mailFeedback}?subject=FeedBack ${nameApp}&body=");
              },
              child: ItemButton(
                  image: "assets/images/ic_feedback.png",
                  title: "Feedback to Us"),
            ),
            GestureDetector(
              onTap: () {
                platform.invokeMethod("rateManual");
              },
              child: ItemButton(
                  image: "assets/images/ic_rate.png", title: "Rate Us"),
            ),
            Expanded(
              child: Container(),
            ),
            isShowBanner
                ? AdmobBanner(
                    adUnitId: admobBannerID,
                    adSize: AdmobBannerSize.LARGE_BANNER,
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  ItemButton({String image, String title}) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Card(
                    elevation: 4,
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        image,
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(title),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
