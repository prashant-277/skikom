import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Dashboard_page.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class level_selection extends StatefulWidget {
  @override
  _level_selectionState createState() => _level_selectionState();
}

class _level_selectionState extends State<level_selection>
    with TickerProviderStateMixin {
  bool beginner = true;
  bool medium = false;
  bool expert = false;
  final url1 = url.basicUrl;
  final token = url.token;
  List level = [];
  bool _isloading = true;
  int level_id = 1;

  @override
  void initState() {
    super.initState();
    getLevel();
    checkconnection();
  }

  void checkconnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("wifi");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No internet!',
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w600,
                  color: SBlack,
                  fontSize: 14.sp)),
          content: Text('Please check your internet connection!',
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w600,
                  color: SBlack,
                  fontSize: 14.sp)),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Ok',
                  style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w600,
                      color: SBlack,
                      fontSize: 14.sp)),
            ),
          ],
        ),
      );
    }
  }

  Future<void> getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-level";

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, headers: headers);
    final responseJson = json.decode(response.body);
    print("res level selection " + responseJson.toString());
    setState(() {
      level = responseJson["data"];
      _isloading = false;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an app?',
            style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Swhite,
        body: _isloading == true
            ? SpinKitRipple(
                color: SLightBlue,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              )
            : SingleChildScrollView(
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
                            level_id = level[0]["id"];
                            print(level_id.toString());
                          });
                        },
                        child: Container(
                          height: query.height / 7,
                          width: query.width / 1.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Assets/Icons/green.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  level[0]["type"].toString(),
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
                            level_id = level[1]["id"];
                            print(level_id.toString());
                          });
                        },
                        child: Container(
                            height: query.height / 7,
                            width: query.width / 1.4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("Assets/Icons/blue.png")),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    level[1]["type"].toString(),
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
                              level_id = level[2]["id"];
                              print(level_id.toString());
                            });
                          }
                        },
                        child: Container(
                          height: query.height / 7,
                          width: query.width / 1.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Assets/Icons/red.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  level[2]["type"].toString(),
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
                                  child: dashboard_page(level_id)));
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
      ),
    );
  }
}
