import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:guide_ice_scream/config/env.dart';

class ProcyScreen extends StatefulWidget {
  ProcyScreen({Key key, this.number}) : super(key: key);

  final int number;
  @override
  _ProcyScreenState createState() => new _ProcyScreenState();
}

class _ProcyScreenState extends State<ProcyScreen> {
  var heightScreen=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: Container(
        // height: h,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: """ <div>
        <h4> <b>Privacy Policy</b></h4>
            <p>This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.</p>
            <p>We use your data to provide and improve the Service. By using the Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.</p>
        <h5><b>Information Collection And Use</b></h5>
            <p>We collect several different types of information for various purposes to provide and improve our Service to you.</p>
            <i>Types of Data Collected</i>
            <b>Personal Data</b>
            <p>While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). Personally identifiable information may include, but is not limited to: Cookies and Usage Data</p>
            <b>Usage Data</b>
            <p>When you access the Service by or through a mobile device, we may collect certain information automatically, including, but not limited to, the type of mobile device you use, your mobile device unique ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browser you use, unique device identifiers and other diagnostic data</p>
            <b>Tracking & Cookies Data</b>
            <p>We use cookies and similar tracking technologies to track the activity on our Service and hold certain information.
                Cookies are files with small amount of data which may include an anonymous unique identifier. Cookies are sent to your browser from a website and stored on your device. Tracking technologies also used are beacons, tags, and scripts to collect and track information and to improve and analyze our Service.</p>
            <p>You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.</p>
        <h5><b>Use of Data</b></h5>
            <p>App Whatscan uses the collected data for various purposes:</p>
            <ul>
                <li>To provide and maintain the Service</li>
                <li>To notify you about changes to our Service</li>
                <li>To allow you to participate in interactive features of our Service when you choose to do so</li>
                <li>To provide customer care and support</li>
                <li>To provide analysis or valuable information so that we can improve the Service</li>
                <li>To monitor the usage of the Service</li>
                <li>To detect, prevent and address technical issues</li>
                <li>To show relevant ads</li>
            </ul>
        <h5><b>Transfer Of Data</b></h5>
            <p>Your information, including Personal Data, may be transferred to — and maintained on — computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from your jurisdiction.</p>
            <p>If you are located outside Your Current Country and choose to provide information to us, please note that we transfer the data, including Personal Data, to Your Current Country and process it there.
                Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.</p>
        <h5><b>Disclosure Of Data</b></h5>
            <b>Legal Requirements</b>
            <p>App Whatscan may disclose your Personal Data in the good faith belief that such action is necessary to:</p>
            <ul>
                <li>To comply with a legal obligation</li>
                <li>To prevent or investigate possible wrongdoing in connection with the Service</li>
                <li>To protect the personal safety of users of the Service or the public</li>
                <li>To protect against legal liability</li>
            </ul>
            <h5><b>Security of Data</b></h5>  
            <p>The security of your data is important to us, but remembers that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.</p>
            <h5><b>Service Providers</b></h5>
            <p>We may employ third party companies and individuals to facilitate our Service ("Service Providers"), to provide the Service on our behalf, to perform Service-related services or to assist us in analyzing how our Service is used.
                These third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.</p>
            <h5><b>Links To Other Sites</b></h5>
            <p>Our Service may contain links to other sites that are not operated by us. If you click on a third party link, you will be directed to that third party's site. We strongly advise you to review the Privacy Policy of every site you visit.
                We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.</p>
            <h5><b>Children's Privacy</b></h5>
            <p>Our Service does not address anyone under the age of 18 ("Children").
                We do not knowingly collect personally identifiable information from anyone under the age of 18. If you are a parent or guardian and you are aware that your Children has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from children without verification of parental consent, we take steps to remove that information from our servers.</p>
            <h5><b>Changes To This Privacy Policy</b></h5>
            <p>We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.
                We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update the "effective date" at the top of this Privacy Policy.
                You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.</p>
    </div>
                        """,
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 25.0),
                ),
              ),
            ),
            SizedBox(height: 5,),
            isShowBanner
                ? AdmobBanner(
              adSize: heightScreen > 600
                  ? AdmobBannerSize.LARGE_BANNER
                  : AdmobBannerSize.BANNER,
              adUnitId: admobBannerID,
            )
                : Container(),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
