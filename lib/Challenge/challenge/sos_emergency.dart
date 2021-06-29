import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Challenge/challenge/messageSuccess.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:skicom/url.dart';
class sos_emergency extends StatefulWidget {
  @override
  _sos_emergencyState createState() => _sos_emergencyState();
}

class _sos_emergencyState extends State<sos_emergency> {
  final url1 = url.basicUrl;
  final token = url.token;
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "SOS",
        colorImage: Swhite,
        imageBack: true,
        fontsize: medium,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          height: query.height/1.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Are you in Emergency?",
                      style: TextStyle(
                          fontSize: header,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w700,
                          color: SBlack),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Press the button below and we send emergency message to your saved contacts.",
                      style: TextStyle(
                          fontSize: medium,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack),
                    ),
                  ],
                ),


                InkWell(onTap: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  var url = "$url1/send-help";

                  var map = new Map<String, dynamic>();
                  map["user_id"] = prefs.getString("userId").toString();

                  Map<String, String> headers = {"_token": token};


                  final response = await http.post(url, body:map, headers: headers);
                  final responseJson = json.decode(response.body);
                  print("res get-request-list  " + responseJson.toString());
                  if(responseJson["status"].toString()=="success"){
                    displayToast(responseJson["message"].toString());
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: messageSuccess()));
                  }
                },
                    child: Image.asset("Assets/Icons/help_me.png",height: query.height*0.4,)),
                Container(
                  width: query.width / 1.2,
                  height: 45.sp,
                  decoration: BoxDecoration(
                      border: Border.all(color: SBlack, width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.transparent,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: SBlack),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
