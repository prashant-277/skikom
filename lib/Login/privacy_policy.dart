import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
import 'package:html2md/html2md.dart' as html2md;

class privacy_policy extends StatefulWidget {
  @override
  _privacy_policyState createState() => _privacy_policyState();
}

class _privacy_policyState extends State<privacy_policy> with TickerProviderStateMixin {
  final url1 = url.basicUrl;
  final token = url.token;
  bool _isloading = true;
  List data = [];
  @override
  void initState() {
    super.initState();
    getTermsofservice();
  }

  Future<void> getTermsofservice() async {
    var url = "$url1/get-pages";

    var map = new Map<String, dynamic>();
    map["slug"] = "privacy-policy";

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res privacy-policy  " + responseJson.toString());
    setState(() {
      data = responseJson["data"];
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          height: query.height,
          color: Swhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: _isloading == true
                ? SpinKitRipple(
              color: SLightBlue,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            )
                : ListView(
              /*mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,*/
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: IconbuttonG(
                        () {
                          Navigator.pop(context);
                        },
                        "Assets/Icons/cancel.png",
                      )),
                ),
                Row(
                  children: [
                    Image.asset(
                      "Assets/Images/logo.png",
                      height: 80.sp,
                    ),
                  ],
                ),
                Text(html2md.convert(data[0]["name"].toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        height: 2,
                        fontFamily: "SFPro",
                        fontSize: header)),
                SizedBox(height: 20),
                Text(html2md.convert(data[0]["description"].toString()),
                  style: TextStyle(
                      fontSize: medium,
                      height: 1.3,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
