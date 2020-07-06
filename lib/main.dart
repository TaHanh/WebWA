import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guide_ice_scream/screens/loading/LoadingScreen.dart';

MethodChannel platform =const MethodChannel('my_module');

void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  // bannerSize = AdmobBannerSize.BANNER;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Color(0xFF108661)),
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
        routes: {'/': (context) => LoadingScreen()});
  }
}
