import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Login/emailRegistration.dart';
import 'package:skicom/Login/gender_selection.dart';
import 'package:skicom/Login/login_Screen.dart';
import 'package:skicom/Login/termsOfservice.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Login/privacy_policy.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:skicom/level_selection.dart';
import 'package:skicom/url.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final url1 = url.basicUrl;
  final token = url.token;

  var device_token;
  var device_id;

  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/Images/background.png"),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(""),
          Image.asset("Assets/Images/logo.png", fit: BoxFit.fill, height: 15.h),
          Container(
            width: 90.w,
            height: 8.5.h,
            child: primarybutton("Continue with google", () {
              _handleSignIn().then((FirebaseUser user) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                var url = "$url1/google-login";

                Map<String, String> header = {
                  "_token": token
                };

                var map = new Map<String, dynamic>();
                map["f_name"] = user.displayName.toString();
                map["l_name"] = user.displayName.toString();
                map["email"] = user.email.toString();
                map["userId"] = user.uid.toString();
                map["imageUrl"] = user.photoUrl.toString();
                map["gender"] = "";

                final response =
                    await http.post(url, body: map, headers: header);

                final responseJson = json.decode(response.body);
                print(responseJson.toString());
                if (responseJson["success"].toString() == "Success") {
                  prefs.setString("googlePhoto", user.photoUrl.toString());

                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          child: gender_selection(responseJson, "google")));
                }
              }).catchError((e) => print(e));
            }, Swhite, "Assets/Icons/Google.png", SBlack),
          ),
          Container(
            width: 90.w,
            height: 8.5.h,
            child: primarybutton("Continue with Facebook", () {
              initiateFacebookLogin();
            }, SFacebook, "Assets/Icons/facebook.png", Swhite),
          ),
          Container(
            width: 90.w,
            height: 8.5.h,
            child: primarybutton("Continue with Apple", () {}, Swhite,
                "Assets/Icons/apple.png", SBlack),
          ),
          Container(
            width: 90.w,
            height: 8.5.h,
            child: primarybutton("Register with Email", () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.bottomCenter,
                      duration: Duration(milliseconds: 300),
                      child: emailRegistration()));
            }, SRed, "Assets/Icons/email_white.png", Swhite),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(
                      color: SBlack, fontSize: medium, fontFamily: "SFPro"),
                  text: "Already have an account?",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      color: SRed,
                      fontSize: medium,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "Login",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: login_Screen()));
                    },
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: small,
                      fontFamily: "SFPro"),
                  text: "By registering, you agree to our",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: small,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "\nTerms of service",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 200),
                              child: termsOfservice()));
                    },
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: small,
                      fontFamily: "SFPro"),
                  text: "and",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: small,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "Privacy policy",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 200),
                              child: privacy_policy()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initiateFacebookLogin() async {
    final facebookLoginResult = await facebookSignIn.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);

        print("profile******* " + profile.toString());
        print("user Id +++++ " + profile["id"].toString());
        onLoginStatusChanged(true, profileData: profile);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        var url = "$url1/facebook-login";

        Map<String, String> header = {
          "_token": token
        };

        var map = new Map<String, dynamic>();
        map["f_name"] = profile["first_name"].toString();
        map["l_name"] = profile["last_name"].toString();
        map["email"] = profile["email"].toString();
        map["imageUrl"] = profile["picture"]["data"]["url"].toString();
        map["gender"] = "";
        map["fb_id"] = profile["id"].toString();

        final response = await http.post(url, body: map, headers: header);

        final responseJson = json.decode(response.body);
        print(responseJson.toString());
        print(responseJson["data"]["api_token"].toString());

        if (responseJson["status"].toString() == "Success") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  child: gender_selection(responseJson, "facebook")));
        }
        break;
    }
  }

  Future<FirebaseUser> _handleSignIn() async {
    _auth.app.options.catchError((error) {
      print("error---->$error");
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    //await _googleSignIn.disconnect();
    return user;
  }

  Future<void> checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userEmail") != null) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 300),
              child: level_selection()));
    } else {}
  }
}
