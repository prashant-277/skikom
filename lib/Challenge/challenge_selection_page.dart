import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/challenge/chalengeHome_page.dart';
import 'package:skicom/Challenge/challenge/challenge_groupList.dart';
import 'package:skicom/Challenge/competition/competition_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class challenge_page extends StatefulWidget {

  @override
  _challenge_pageState createState() => _challenge_pageState();
}

class _challenge_pageState extends State<challenge_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      body: Container(
        width: query.width,
        height: query.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.sp),
            Image.asset(
              "Assets/Images/logo.png",
              height: 80.sp,
            ),
            /*GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    duration: Duration(milliseconds: 300),
                    child: competition_page()));
              },
              child: Container(
                height: 150.sp,
                width: query.width / 1.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/compitition.png")),
                ),
                child: Center(
                  child: Text(
                    "Competition",
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: Swhite,
                        fontSize: header),
                  ),
                ),
              ),
            ),*/

            GestureDetector(
              onTap: () {
                /*Navigator.of(context, rootNavigator: true).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    duration: Duration(milliseconds: 300),
                    child: challengeHome_page()));*/

                Navigator.of(context, rootNavigator: true).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    duration: Duration(milliseconds: 300),
                    child: challenge_groupList()));
              },
              child: Container(
                  height: 150.sp,
                  width: query.width / 1.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Assets/Images/challeng_1.png")),
                  ),
                  child: Center(
                    child: Text(
                      "Challenge",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: Swhite,
                          fontSize: header),
                    ),
                  )),
            ),
            Container(height: query.height*0.2)
          ],
        ),
      ),
    );
  }
}
