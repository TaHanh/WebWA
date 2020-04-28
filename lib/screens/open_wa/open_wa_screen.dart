import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/env.dart';

class OpenWAScreen extends StatefulWidget {
  OpenWAScreen({Key key}) : super(key: key);
  @override
  _OpenWAScreenState createState() => new _OpenWAScreenState();
}

class _OpenWAScreenState extends State<OpenWAScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController phoneTxtController = new TextEditingController();
  TextEditingController nameTxtController = new TextEditingController();
  TextEditingController messageTxtController = new TextEditingController();
  List<dynamic> numbers = [];
  bool isSaveNumber = false;
  String code = "+1";
  @override
  void initState() {
    super.initState();
    getNumver("NumberWA");
  }

  @override
  void openNewWA(key) async {
    if (phoneTxtController.text != "") {
      FocusScope.of(context).requestFocus(FocusNode());
      String phone = code + phoneTxtController.text;
      // print(phone);
      // print(messageTxtController.text);
      var whatsappUrl =
          "whatsapp://send?phone=$phone&text=${messageTxtController.text}";
      await canLaunch(whatsappUrl)
          ? launch(whatsappUrl)
          : scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text("Whatsapp is not installed!"),
              duration: Duration(seconds: 1),
              backgroundColor: Color(0xFF009688).withOpacity(0.5),
            ));
      // if (key) {
      // FlutterOpenWhatsapp.sendSingleMessage(phone, messageTxtController.text);
      // } else {
      // FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
      // }
      if (isSaveNumber) {
        this.numbers.add(
          {"name": nameTxtController.text, "phone": phone},
        );
        setState(() {
          this.numbers;
        });
        setNumber("NumberWA", this.numbers);
      }
    } else {
      scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Please enter phone number !"),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF009688).withOpacity(0.5),
      ));
    }
  }

  @override
  void openWA(phone) {
    FlutterOpenWhatsapp.sendSingleMessage(phone, messageTxtController.text);
  }

  @override
  void removeNumber(index) {
    this.numbers.removeAt(index);
    setState(() {
      this.numbers;
    });
    setNumber("NumberWA", this.numbers);
  }

  @override
  Future<void> setNumber(key, ls) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(ls));
  }

  @override
  Future<void> getNumver(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String list = prefs.getString(key) ?? null;
    print(list);
    if (list != null) {
      print(jsonDecode(prefs.getString(key)));
      setState(() {
        this.numbers = jsonDecode(prefs.getString(key));
      });
    }
  }

  @override
  Future<void> removeKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  void dispose() {
    super.dispose();
    // if (interstitialAd != null) {
    //   interstitialAd.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/banner.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                padding: EdgeInsets.fromLTRB(0, 5.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        3.0,
                        3.0,
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: CountryCodePicker(
                              initialSelection: 'US',
                              onChanged: (code) {
                                setState(() {
                                  this.code = code.dialCode;
                                });
                              },
                              alignLeft: true,
                              onInit: (code) {
                                // print("${code.name} ${code.dialCode}");
                              },
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: phoneTxtController,
                              decoration: InputDecoration(
                                  hintText: 'Phone number - require'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                      child: TextField(
                        controller: nameTxtController,
                        decoration:
                            InputDecoration(hintText: 'Name - optional'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: TextField(
                        controller: messageTxtController,
                        decoration:
                            InputDecoration(hintText: 'Message - optional'),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: isSaveNumber,
                            activeColor: Color(0xFF075e54),
                            onChanged: (bool value) {
                              setState(() {
                                isSaveNumber = value;
                                print(isSaveNumber.toString());
                              });
                              print(isSaveNumber.toString());
                            },
                          ),
                          Text("Save number for later use"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              openNewWA(true);
                            },
                            color: Color(0xFF075e54),
                            child: Text(
                              "WHATSAPP",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          // FlatButton(
                          //   onPressed: () {
                          //     openNewWA(false);
                          //   },
                          //   color: Color(0xFF075e54),
                          //   child: Text(
                          //     "WHATSAPP BUSINESS",
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: numbers.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            3.0,
                            3.0,
                          ),
                        )
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                numbers[(numbers.length - 1) - index]["phone"],
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(numbers[(numbers.length - 1) - index]
                                  ["name"]),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            openWA(
                                numbers[(numbers.length - 1) - index]["phone"]);
                          },
                          child: Image.asset(
                            "assets/images/ic_wa.png",
                            width: 25.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/ic_wab.png",
                            width: 35.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            removeNumber((numbers.length - 1) - index);
                          },
                          child: Icon(
                            Icons.delete_outline,
                            size: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//              SizedBox(
//                height: 5,
//              ),
//              AdmobBanner(
//                adUnitId: admobBannerID,
//                adSize: AdmobBannerSize.BANNER,
//              ),
//              SizedBox(
//                height: 5,
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
