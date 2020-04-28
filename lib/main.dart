import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/screens/home/home_screen.dart';

import 'config/env.dart';

void main() {
  Admob.initialize(nameApp);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static MethodChannel platform = const MethodChannel('my_module');
  // bannerSize = AdmobBannerSize.BANNER;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            platform.invokeMethod("getIdBanner").then((value) {
              print(value);
              if (value != null) admobBannerID = value as String;
            });
            platform.invokeMethod("getIdInter").then((value) {
              if (value != null) {
                admobInterstitialID = value as String;
              }
            });
            return HomeScreen();
          },
        });
  }
}
