import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Login/RegistrationPage.dart';
import 'package:skicom/Profile/changeLanguage.dart';
import 'package:skicom/Profile/editProfile_dialog.dart';
import 'package:skicom/Profile/myChallengeGroup.dart';
import 'package:skicom/Profile/sosContacts.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'changepassword.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
class profile_page extends StatefulWidget {
  @override
  _profile_pageState createState() => _profile_pageState();
}



class _profile_pageState extends State<profile_page> with TickerProviderStateMixin{
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final url1 = url.basicUrl;
  final token = url.token;
  var  data;
  final imageurl = url.imageUrl;
  bool isloading = true;

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an app?',style: TextStyle(
            fontFamily: "SFPro",
            fontWeight: FontWeight.w600,
            color: SBlack,
            fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
        ],
      ),
    ) ;
  }

  @override
  void initState() {
    super.initState();
    getUserdetail();
  }
  Future<void> getUserdetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-single-user";

    var map = new Map<String, dynamic>();

    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-single-user  " + responseJson.toString());
    if(responseJson["status"].toString()=="success"){
      setState(() {
        data = responseJson["data"];
        isloading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Swhite,
        appBar: commanAppBar(
          appBar: AppBar(),
          appbartext: "Profile",
          fontsize: 16.sp,
          imageBack: false,
          widgets: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 13, bottom: 12),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          contentPadding: EdgeInsets.only(
                              left: 0, right: 0, bottom: 15, top: 0),
                          backgroundColor: Swhite,
                          content: editProfile_dialog(data))).then((value) {
                            setState(() {getUserdetail();});
                  });
                },
                child: Container(
                  width: query.width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Swhite, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Swhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text("Edit Profile",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlue,
                              fontSize: 10.sp)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: isloading == true
            ? SpinKitRipple(
          color: SLightBlue,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        ) :SingleChildScrollView(
          child: Container(
            width: query.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FadeInImage(
                                    image: NetworkImage(data["profile"].toString() == "null" ?
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"
                                        :imageurl +
                                        data["profile"].toString().toString()),
                                    fit: BoxFit.fill,
                                    width: 60.sp,
                                    height: 60.sp,
                                    placeholder: AssetImage(
                                        "Assets/Images/giphy.gif"))
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 125.sp,
                                  child: Text(
                                    data["username"].toString(),
                                    style: TextStyle(
                                        height: 1.5,
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w600,
                                        color: SBlack,
                                        fontSize: medium),
                                  ),
                                ),
                                Text(
                                  data["email"].toString(),
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                SizedBox(height: 10.sp,),
                              ],
                            )
                          ],
                        ),

                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "Assets/Icons/cup.png",
                                  height: 50.sp,
                                ),
                                Text(
                                  "Competition",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium),
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
                                  height: 50.sp,
                                ),
                                Text(
                                  "Competition",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium),
                                ),
                              ],
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),
                  Container(
                    height: query.height / 2.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 300),
                                    child: myChallengeGroup()));
                          },
                          child: Container(
                            width: query.width / 1.1,
                            height: 40.sp,
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
                                      "My Challenge group",
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: SBlack,
                                          fontSize: small),
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
                                    child: sosContacts()));
                          },
                          child: Container(
                            width: query.width / 1.1,
                            height: 40.sp,
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
                                          fontSize: small),
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
                        /*InkWell(
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
                            height: 40.sp,
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
                                          fontSize: small),
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
                        ),*/
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
                            height: 40.sp,
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
                                          fontSize: small),
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
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("userEmail", null);
                            prefs.setString("api_token", null);
                            prefs.setString("userId", null);
                            prefs.setString("username", null);
                            facebookSignIn.logOut();
                            _googleSignIn.disconnect();
                            _auth.signOut();
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacement(PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.bottomCenter,
                                duration:
                                Duration(milliseconds: 300),
                                child: RegistrationPage()));
                          },
                          child: Container(
                            height: 32.sp,
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
                                        fontWeight: FontWeight.w500,
                                        color: Swhite,
                                        fontSize: medium)),
                              ),
                            ),
                          ),
                        ),
                        Container(height: 30.sp,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
