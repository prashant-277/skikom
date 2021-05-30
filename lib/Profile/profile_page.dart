import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Profile/changeLanguage.dart';
import 'package:skicom/Profile/editProfile_dialog.dart';
import 'package:skicom/Profile/sosContacts.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

import 'changepassword.dart';

class profile_page extends StatefulWidget {
  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Profile",
        fontsize: 20,
        imageBack: false,
        widgets: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 13, bottom: 12),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.only(
                            left: 0, right: 0, bottom: 15, top: 0),
                        backgroundColor: Swhite,
                        content: editProfile_dialog()));
              },
              child: Container(
                width: query.width * 0.25,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Swhite, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Swhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("Edit Profile",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlue,
                            fontSize: 12)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: query.height,
        width: query.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/Images/2.png",
                    height: query.height * 0.1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "William Myre",
                        style: TextStyle(
                            height: 1.5,
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: 16),
                      ),
                      Text(
                        "williammyre@gmail.com",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: SBlack,
                            fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "Assets/Icons/cup.png",
                        height: query.height * 0.06,
                      ),
                      Text(
                        "Competition",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: SBlack,
                            fontSize: 14),
                      ),
                      Text(
                        "5",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: query.height * 0.1,
                    color: kGray,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "Assets/Icons/cup.png",
                        height: query.height * 0.06,
                      ),
                      Text(
                        "Competition",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: SBlack,
                            fontSize: 14),
                      ),
                      Text(
                        "5",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          child: sosContacts()));
                },
                child: Container(
                  width: query.width / 1.1,
                  height: query.height * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SOS Emergency",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: 14),
                          ),
                          Image.asset(
                            "Assets/Icons/right.png",
                            height: query.height * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          child: changeLanguage()));
                },
                child: Container(
                  width: query.width / 1.1,
                  height: query.height * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Language",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: 14),
                          ),
                          Image.asset(
                            "Assets/Icons/right.png",
                            height: query.height * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.bottomCenter,
                          duration: Duration(milliseconds: 300),
                          child: changepassword()));
                },
                child: Container(
                  width: query.width / 1.1,
                  height: query.height * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change password",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: 14),
                          ),
                          Image.asset(
                            "Assets/Icons/right.png",
                            height: query.height * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: query.width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Swhite, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: SRed,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Logout",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
