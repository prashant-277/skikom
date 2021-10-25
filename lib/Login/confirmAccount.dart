import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/resetPassword.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class confirmAccount extends StatefulWidget {
  var responseJson;

  confirmAccount(this.responseJson);


  @override
  _confirmAccountState createState() => _confirmAccountState();
}

class _confirmAccountState extends State<confirmAccount> {
  var userotp;
  final url1 = url.basicUrl;
  final token = url.token;
  String otp;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: BaseAppBar(
        appBar: AppBar(),
        backgroundColor: Swhite,
        appbartext: "",
      ),
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text("Confirm Account",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1,
                            fontFamily: "SFPro",
                            fontSize: header)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                        width: query.width / 1.15,
                        child: Text(
                          "We'll sent an email with 4-digit code to prashant.theappideas@gmail.com",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontSize: medium,
                              color: SBlack,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: query.width / 1.75,
                height: query.height / 13,
                child: OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w500),
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  fieldStyle: FieldStyle.box,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    setState(() {
                      userotp = pin;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                  width: 90.w,
                  height: 8.0.h,
                  child: basicButton(Swhite, () {
                    connfirmPassword();

                  }, "Confirm")),
              SizedBox(
                height: 25,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      style: TextStyle(
                          color: SBlack,
                          fontFamily: "SFPro",
                          fontSize: medium,
                          fontWeight: FontWeight.w500),
                      text: "Don't get code?",
                    ),
                    WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                      style: TextStyle(
                          color: SRed,
                          fontFamily: "SFPro",
                          fontSize: medium,
                          fontWeight: FontWeight.w600),
                      text: "Resend",
                      recognizer: TapGestureRecognizer()..onTap = () async {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> connfirmPassword() async {
    var url = "$url1/otp-verify";

    Map<String, String> header = {"_token": token};

    var map = new Map<String, dynamic>();

    map["email"] = widget.responseJson["data"]["email"].toString();
    map["otp"] = userotp.toString();

    final response = await http.post(url, body: map, headers: header);

    final responseJson = json.decode(response.body);

    print("otp-verify === " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      displayToast(responseJson["message"].toString());
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 300),
              child: resetPassword(widget.responseJson)));
    }else{
      displayToast(responseJson["message"].toString());
    }

  }
}
