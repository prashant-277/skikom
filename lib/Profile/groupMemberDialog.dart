import 'dart:convert';

import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class groupMemberDialog extends StatefulWidget {
  var user_id;

  var group_id;

  groupMemberDialog(this.user_id, this.group_id);

  @override
  _groupMemberDialogState createState() => _groupMemberDialogState();
}

class _groupMemberDialogState extends State<groupMemberDialog>
    with TickerProviderStateMixin {
  bool _isloading = true;
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;

  var userdata;

  var distance;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    var url = "$url1/get-single-user";

    var map = new Map<String, dynamic>();
    map["user_id"] = widget.user_id.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-single-user  " + responseJson.toString());
    setState(() {
      userdata = responseJson["data"];
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    var query = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: _isloading == true
          ? SpinKitRipple(
              color: SLightBlue,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Swhite, borderRadius: BorderRadius.circular(40.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          "Assets/Icons/cancel_dark.png",
                          height: query.height * 0.02,
                        ),
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FadeInImage(
                          image: NetworkImage(
                              imageurl + userdata["profile"].toString()),
                          fit: BoxFit.fill,
                          width: 80.sp,
                          height: 80.sp,
                          placeholder: AssetImage("Assets/Images/giphy.gif"))),
                  SizedBox(height: 10.sp),
                  Text(
                    userdata["username"].toString(),
                    style: TextStyle(
                        fontSize: header,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack),
                  ),
                  SizedBox(height: 10.sp),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text("Challenge for : ",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: medium)),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomRadioButton(
                    width: query.width * 0.22,
                    height: query.height * 0.05,
                    padding: 0,
                    autoWidth: false,
                    enableButtonWrap: true,
                    unSelectedBorderColor: Colors.transparent,
                    selectedBorderColor: Colors.transparent,
                    elevation: 0,
                    absoluteZeroSpacing: false,
                    unSelectedColor: kGray,
                    buttonLables: [
                      '10 km',
                      '20 km',
                      '30 km',
                      '40 km',
                      '50 km',
                    ],
                    buttonValues: [
                      '10 km',
                      '20 km',
                      '30 km',
                      '40 km',
                      '50 km',
                    ],
                    buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: small,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                        )),
                    radioButtonValue: (value) {
                      setState(() {
                        distance = value;
                        print(distance);
                      });
                    },
                    selectedColor: SBlue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 10),
                    child: Container(
                        height: 45.sp,
                        width: query.width,
                        child: basicButton(Swhite, () async {
                          if (distance.toString() == "null") {
                            displayToast("Please select distance...");
                          } else {
                            await pr.show();

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var url = "$url1/request-to-challenge";

                            print(widget.group_id.toString());
                            print(prefs.getString("userId").toString());
                            print(userdata["id"].toString());
                            print(distance.toString());

                            var map = new Map<String, dynamic>();
                            map["group_id"] = widget.group_id.toString();
                            map["from_user"] =
                                prefs.getString("userId").toString();
                            map["to_user"] = userdata["id"].toString();
                            map["for_km"] = distance.toString();

                            Map<String, String> headers = {"_token": token};

                            final response = await http.post(url,
                                body: map, headers: headers);
                            final responseJson = json.decode(response.body);
                            print("res request-to-challenge  " +
                                responseJson.toString());

                            if (responseJson["status"].toString() ==
                                "success") {
                              displayToast(responseJson["message"].toString());
                              Navigator.pop(context);
                              pr.hide();
                            }
                          }
                        }, "Challenge Now!")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Container(
                      height: 45.sp,
                      width: query.width,
                      decoration: BoxDecoration(
                          color: SRed,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: SRed,
                        child: Text("Remove from my group",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite)),
                        onPressed: () async {
                          pr.show();
                          var url = "$url1/remove-group-member";

                          var map = new Map<String, dynamic>();
                          map["group_id"] = widget.group_id.toString();
                          map["user_id"] = userdata["id"].toString();

                          Map<String, String> headers = {"_token": token};

                          final response =
                              await http.post(url, body: map, headers: headers);
                          final responseJson = json.decode(response.body);
                          print("res remove-group-member  " +
                              responseJson.toString());
                          if (responseJson["status"].toString() == "success") {
                            displayToast(responseJson["message"].toString());
                            Navigator.pop(context);
                            pr.hide();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
