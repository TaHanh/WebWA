import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart' as webview;
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  WebScreen({Key key}) : super(key: key);
  @override
  _WebScreenState createState() => new _WebScreenState();
}

class _WebScreenState extends State<WebScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
//   AdmobInterstitial interstitialAd;
  String newUA;
  String phone = "";
  webview.FlutterWebviewPlugin flutterWebviewP = webview.FlutterWebviewPlugin();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();

    // newUA =
    //     "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36";
    // newUA =
    //     "Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36";
  }

  JavascriptChannel snackbarJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'SnackbarJSChannel',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message.message),
        ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // flutterWebviewP.close();
    // flutterWebviewP.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    String newUA = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/53.1";
//    String newUA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36";
//    String newUA = "Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36";
    String newUA =
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36";
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
        centerTitle: true,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: new DecorationImage(
        //     image: new ExactAssetImage('assets/images/banner.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: new WebView(
          // key: UniqueKey(),
//             initialUrl: "https://www.facebook.com/",
          initialUrl: "https://web.whatsapp.com/",
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: newUA,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // javascriptChannels: <JavascriptChannel>[
          //   snackbarJavascriptChannel(context),
          // ].toSet(),
          // navigationDelegate: (NavigationRequest request) {
          //   return NavigationDecision.navigate;
          // },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://flutter.dev/docs')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: webview.WebviewScaffold(
          url: "https://web.whatsapp.com/",
          // mediaPlaybackRequiresUserGesture: true,
          // withZoom: true,
          // withLocalStorage: true,
          // hidden: true,
          withJavascript: true,
          scrollBar: true,
          // enableAppScheme: true,
          userAgent: newUA,
          // clearCookies: false,
          // clearCache: false,
          initialChild: Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: new CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFF075e54)),
                    )),
                Text('Waiting.....'),
              ],
            )),
          ),
          // bottomNavigationBar: BottomAppBar(
          //   child: Row(
          //     children: <Widget>[
          //       IconButton(
          //         icon: const Icon(Icons.arrow_back_ios),
          //         onPressed: () {
          //           flutterWebviewP.goBack();
          //         },
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.arrow_forward_ios),
          //         onPressed: () {
          //           flutterWebviewP.goForward();
          //         },
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.autorenew),
          //         onPressed: () {
          //           flutterWebviewP.reload();
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
