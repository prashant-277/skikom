import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/RegistrationPage.dart';
import 'package:skicom/constants.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Swhite,
      body: AnimatedSplashScreen(
        splashIconSize: MediaQuery.of(context).size.width / 2.5,
        splash: Image.asset(
          "Assets/Images/logo.png",
        ),
        nextScreen: RegistrationPage(),
        duration: 1000,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
