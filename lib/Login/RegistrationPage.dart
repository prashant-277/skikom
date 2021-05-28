import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/emailRegistration.dart';
import 'package:skicom/Login/login_Screen.dart';
import 'package:skicom/Login/termsOfservice.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Login/privacy_policy.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
          Image.asset("Assets/Images/logo.png",
              fit: BoxFit.fill, height: query.height * 0.18),
          Container(
            width: query.width / 1.1,
            height: query.height * 0.09,
            child: primarybutton("Continue with google", () {}, Swhite,
                "Assets/Icons/Google.png", SBlack),
          ),
          Container(
            width: query.width / 1.1,
            height: query.height * 0.09,
            child: primarybutton("Continue with Facebook", () {}, SFacebook,
                "Assets/Icons/facebook.png", Swhite),
          ),
          Container(
            width: query.width / 1.1,
            height: query.height * 0.09,
            child: primarybutton("Continue with Apple", () {}, Swhite,
                "Assets/Icons/apple.png", SBlack),
          ),
          Container(
            width: query.width / 1.1,
            height: query.height * 0.09,
            child: primarybutton("Register with Email", () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.bottomCenter,
                      duration: Duration(milliseconds: 300),
                      child: emailRegistration()));
            }, SRed,
                "Assets/Icons/email_white.png", Swhite),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(
                      color: SBlack, fontSize: 16, fontFamily: "SFPro"),
                  text: "Already have an account?",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      color: SRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "Login",
                  recognizer: TapGestureRecognizer()..onTap = () async {
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
                      fontSize: 14,
                      fontFamily: "SFPro"),
                  text: "By registering, you agree to our",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "\nTerms of service",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: termsOfservice()));
                    },
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: 14,
                      fontFamily: "SFPro"),
                  text: "and",
                ),
                WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      color: SBlack,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFPro"),
                  text: "Privacy policy",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
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
}
