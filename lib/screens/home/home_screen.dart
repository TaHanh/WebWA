import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/main.dart';
import 'package:guide_ice_scream/screens/about/about_screen.dart';
import 'package:guide_ice_scream/screens/open_wa/open_wa_screen.dart';
import 'package:guide_ice_scream/screens/web/web_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AdmobInterstitial interstitialAd;
  // AdmobBannerSize bannerSize;
  String appId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _children = [WebScreen(), OpenWAScreen()];
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    // bannerSize = AdmobBannerSize.BANNER;
    _pageController = PageController(initialPage: _currentIndex, keepPage: true, viewportFraction: 1.0);
    getAppID();
  }

  void onTabTapped(int index) {
    print(_currentIndex);
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();

    // if (interstitialAd != null) {
    //   interstitialAd.dispose();
    // }
  }

  @override
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
        MyApp.platform.invokeMethod("rateManual");
        break;
      case "ABOUT":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutScreen()),
        );

        break;
      default:
    }
  }

  getAppID() async {
    appId = await MyApp.platform.invokeMethod("getAppId");
    setState(() {
      appId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(nameApp),
        backgroundColor: Color(0xFF075e54),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[WebScreen(), OpenWAScreen()],
        onPageChanged: (page) {},
      ),
      // body: _children[_currentIndex],
      drawer: Drawer(
        elevation: 1000,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 50.0, 0, 30.0),
              decoration: BoxDecoration(
                color: Color(0xFF075e54),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      nameApp,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Share app'),
              leading: Icon(Icons.share),
              onTap: () {
                callBack("SHARE", "");
              },
            ),
            ListTile(
              title: Text('Rate app'),
              leading: Icon(Icons.star_border),
              onTap: () {
                callBack("RATE", "");
              },
            ),
            ListTile(
              title: Text('Feedback to us'),
              leading: Icon(Icons.feedback),
              onTap: () {
                callBack("FEEDBACK", "");
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              leading: Icon(Icons.info_outline),
              onTap: () {
                callBack("ABOUT", "");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30.0,
        selectedItemColor: Color(0xFF075e54),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.chat_bubble_outline,
            ),
            title: new Text(''),
          ),
        ],
      ),
    );
  }
}
