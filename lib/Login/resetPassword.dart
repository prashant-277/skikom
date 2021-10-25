import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/login_Screen.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
class resetPassword extends StatefulWidget {
  var responseJson;

  resetPassword(this.responseJson);


  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _pswdCtrl = TextEditingController();
  TextEditingController _confirmpswdCtrl = TextEditingController();
  final url1 = url.basicUrl;
  final token = url.token;

  String password = '';
  String conffirmpassword = '';

  bool show = true;
  bool confirmshow = true;

  void onTap() {
    show = !show;
    setState(() {});
  }

  void onTap1() {
    confirmshow = !confirmshow;
    setState(() {});
  }

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
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Reset password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "SFPro",
                        height: 1,
                        fontSize: header)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 260.sp,
                        child: TextFormField(
                          controller: _pswdCtrl,
                          textAlign: TextAlign.start,
                          obscureText: show,
                          validator: (value) => value.isEmpty
                              ? 'Please enter new password'
                              : null,
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          style:
                          TextStyle(fontFamily: "SFPro", color: SBlack),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              icon: !show
                                  ? Image.asset(
                                'Assets/Icons/visible.png',
                                width: 18.sp,
                              )
                                  : Image.asset(
                                'Assets/Icons/invisible.png',
                                width: 18.sp,
                              ),
                              onPressed: () {
                                onTap();
                              },
                            ),
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: SGray, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: SGray, width: 1)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: SGray,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: "SFPro",
                            ),
                            filled: true,
                            fillColor: Swhite,
                            hintText: 'New password',
                            prefixIcon: new IconButton(
                              icon: new Image.asset(
                                'Assets/Icons/password.png',
                                width: 15.sp,
                                color: SBlack,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 260.sp,

                        child: TextFormField(
                          controller: _confirmpswdCtrl,
                          textAlign: TextAlign.start,
                          obscureText: confirmshow,
                          validator: (value) => value.isEmpty
                              ? 'Please enter confirm password'
                              : null,
                          onChanged: (value) {
                            setState(() => conffirmpassword = value);
                          },
                          style:
                          TextStyle(fontFamily: "SFPro", color: SBlack),
                          maxLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              icon: !confirmshow
                                  ? Image.asset(
                                'Assets/Icons/visible.png',
                                width: 18.sp,
                              )
                                  : Image.asset(
                                'Assets/Icons/invisible.png',
                                width: 18.sp,
                              ),
                              onPressed: () {
                                onTap1();
                              },
                            ),
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: SGray, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: SGray, width: 1)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: SGray,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: "SFPro",
                            ),
                            filled: true,
                            fillColor: Swhite,
                            hintText: 'Confirm password',
                            prefixIcon: new IconButton(
                              icon: new Image.asset(
                                'Assets/Icons/password.png',
                                width: 15.sp,
                                color: SBlack,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 25),
              Container(
                  width: 90.w,
                  height: 8.0.h,
                  child: basicButton(Swhite, () async {
                    if(_formKey.currentState.validate()){
                      if(_pswdCtrl.text.toString()==_confirmpswdCtrl.text.toString()){

                        var url = "$url1/reset-password";

                        Map<String, String> header = {"_token": token};

                        var map = new Map<String, dynamic>();
//3608
                        map["password"] = _confirmpswdCtrl.text.toString();

                        final response = await http.post(url, body: map, headers: header);

                        final responseJson = json.decode(response.body);

                        print("reset-password === " + responseJson.toString());
                        if(responseJson["status"].toString()=="failed"){
                          displayToast(responseJson["message"].toString());
                        }else{
                          displayToast(responseJson["message"].toString());
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.bottomCenter,
                                  duration: Duration(milliseconds: 300),
                                  child: login_Screen()));
                        }
                      }else{
                        displayToast("Password does not match");
                      }
                    }
                  }, "Reset")),
            ],
          ),
        ),
      ),
    );
  }
}