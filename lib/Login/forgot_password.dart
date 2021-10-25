import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/confirmAccount.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/url.dart';
import '../constants.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class forgotPassword extends StatefulWidget {
  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final url1 = url.basicUrl;
  final token = url.token;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();

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
            height: query.height / 2.3,
            width: query.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Forgot password",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1,
                            fontFamily: "SFPro",
                            fontSize: header)),
                  ),
                  Text(
                      "Enter your email address below and we will send you a reset link",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "SFPro",
                          height: 1.5,
                          fontSize: medium)),
                  Form(
                    key: _formKey,

                    child: textfield(
                      controller: email_controller,
                      obscureText: false,
                      hintText: "Email",
                      textcapitalization: TextCapitalization.none,
                      functionValidate: commonValidation,
                      suffixIcon: null,
                      prefixIcon: new IconButton(
                        icon: new Image.asset(
                          'Assets/Icons/email.png',
                          width: 15.sp,
                          color: SBlack,
                        ),
                        onPressed: null,
                      ),
                      parametersValidate: "Please enter Email",
                      textInputType: TextInputType.emailAddress,

                    ),
                  ),
                  Container(
                      width: 90.w,
                      height: 8.0.h,

                      child: basicButton(Swhite, () {
                        if(_formKey.currentState.validate()){
                          forgetPassword();
                        }

                      }, "Send")),
                ],
              ),
            ),
          ),
        ));
  }
  Future<void> forgetPassword() async {

    var url = "$url1/forget-password";

    Map<String, String> header = {"_token": token};

    var map = new Map<String, dynamic>();

    map["email"] = email_controller.text.toString();

    final response = await http.post(url, body: map, headers: header);

    final responseJson = json.decode(response.body);

    print("forget-password === " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 300),
              child: confirmAccount(responseJson)));
    }
  }
}
