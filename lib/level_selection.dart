import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Dashboard_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class level_selection extends StatefulWidget {
  @override
  _level_selectionState createState() => _level_selectionState();
}

class _level_selectionState extends State<level_selection> {
  bool beginner = true;
  bool medium = false;
  bool expert = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          height: query.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(""),
              Image.asset(
                "Assets/Images/logo.png",
                height: 15.h,
              ),
              Text(
                "Choose the level of ski",
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: header),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expert = false;
                    medium = false;
                    beginner = true;
                  });
                },
                child: Container(
                  height: query.height / 7,
                  width: query.width / 1.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Icons/green.png")),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          "Beginner",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 24),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: beginner ? 1 : 0,
                        duration: Duration(milliseconds: 250),
                        child: Visibility(
                          visible: beginner,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "Assets/Icons/select.png",
                                height: query.height * 0.05,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expert = false;
                    medium = true;
                    beginner = false;
                  });
                },
                child: Container(
                    height: query.height / 7,
                    width: query.width / 1.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Icons/blue.png")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "Medium",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 24),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: medium ? 1 : 0,
                          duration: Duration(milliseconds: 250),
                          child: Visibility(
                            visible: medium,
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  "Assets/Icons/select.png",
                                  height: query.height * 0.05,
                                )),
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  if (expert == false) {
                    setState(() {
                      expert = true;
                      medium = false;
                      beginner = false;
                    });
                  }
                },
                child: Container(
                  height: query.height / 7,
                  width: query.width / 1.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Icons/red.png")),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          "Expert",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 24),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: expert ? 1 : 0,
                        duration: Duration(milliseconds: 250),
                        child: Visibility(
                          visible: expert,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "Assets/Icons/select.png",
                                height: query.height * 0.04.sp,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          child: dashboard_page()));
                },
                child: Container(
                  height: query.height / 7.sp,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Icons/next.png"))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
