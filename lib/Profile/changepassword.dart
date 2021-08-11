import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class changepassword extends StatefulWidget {
  const changepassword({Key key}) : super(key: key);

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldpswdCtrl = TextEditingController();
  TextEditingController _newpswdCtrl = TextEditingController();
  TextEditingController _confirmpswdCtrl = TextEditingController();
  String password = '';
  bool show = true;
  bool show1 = true;
  bool show2 = true;
  final url1 = url.basicUrl;
  final token = url.token;
  void onTap() {
    show = !show;
    setState(() {});
  }

  void onTap1() {
    show1 = !show1;
    setState(() {});
  }

  void onTap2() {
    show2 = !show2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Swhite,
      appBar: BaseAppBar(
        appBar: AppBar(),
        backgroundColor: Swhite,
        appbartext: "",
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Swhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Change password",
                  style: TextStyle(
                      color: SBlack,
                      fontSize: header,
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: textfield(
                            controller: _oldpswdCtrl,
                            obscureText: show,
                            hintText: "Old password",
                            functionValidate: commonValidation,
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              icon: !show
                                  ? Image.asset(
                                      'Assets/Icons/visible.png',
                                      width: 25.0,
                                      height: 25.0,
                                    )
                                  : Image.asset(
                                      'Assets/Icons/invisible.png',
                                      width: 25.0,
                                      height: 25.0,
                                    ),
                              onPressed: () {
                                onTap();
                              },
                            ),
                            prefixIcon: IconButton(
                              icon: new Image.asset(
                                'Assets/Icons/password.png',
                                width: 20.0,
                                height: 20.0,
                                color: SBlack,
                              ),
                              onPressed: null,
                            ),
                            parametersValidate: "Please enter old password",
                            textInputType: TextInputType.name,
                          )),
                      SizedBox(height: 10),*/
                      Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: textfield(
                            controller: _newpswdCtrl,
                            obscureText: show1,
                            hintText: "New password",
                            textcapitalization: TextCapitalization.none,
                            functionValidate: commonValidation,
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              icon: !show1
                                  ? Image.asset(
                                      'Assets/Icons/visible.png',
                                      width: 25.0,
                                      height: 25.0,
                                    )
                                  : Image.asset(
                                      'Assets/Icons/invisible.png',
                                      width: 25.0,
                                      height: 25.0,
                                    ),
                              onPressed: () {
                                onTap1();
                              },
                            ),
                            prefixIcon: IconButton(
                              icon: new Image.asset(
                                'Assets/Icons/password.png',
                                width: 20.0,
                                height: 20.0,
                                color: SBlack,
                              ),
                              onPressed: null,
                            ),
                            parametersValidate: "Please enter new password",
                            textInputType: TextInputType.text,
                          )),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: textfield(
                          controller: _confirmpswdCtrl,
                          obscureText: show2,
                          hintText: "Confirm password",
                          functionValidate: commonValidation,
                          textcapitalization: TextCapitalization.none,
                          suffixIcon: IconButton(
                            color: Colors.grey,
                            icon: !show2
                                ? Image.asset(
                                    'Assets/Icons/visible.png',
                                    width: 25.0,
                                    height: 25.0,
                                  )
                                : Image.asset(
                                    'Assets/Icons/invisible.png',
                                    width: 25.0,
                                    height: 25.0,
                                  ),
                            onPressed: () {
                              onTap2();
                            },
                          ),
                          prefixIcon: IconButton(
                            icon: new Image.asset(
                              'Assets/Icons/password.png',
                              width: 20.0,
                              height: 20.0,
                              color: SBlack,
                            ),
                            onPressed: null,
                          ),
                          parametersValidate: "Please enter confirm password",
                          textInputType: TextInputType.text,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: basicButton(Swhite, () async {
                            if (_formKey.currentState.validate()){
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              if(_newpswdCtrl.text.toString()==_confirmpswdCtrl.text.toString()){
                                final ProgressDialog pr = _getProgress(context);
                                pr.update(
                                    message: "Please wait...",
                                    messageTextStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "SFPro",
                                        fontSize: medium));
                                pr.show();
                                print("done");
                                var url = "$url1/change-password";

                                Map<String, String> header = {"_token": token};

                                var map = new Map<String, dynamic>();
                                map["api_token"] = prefs.getString("api_token").toString();
                                map["password"] = _confirmpswdCtrl.text.toString();


                                final response = await http.post(Uri.parse(url),
                                    body: map, headers: header);

                                final responseJson = json.decode(response.body);
                                print(responseJson.toString());
                                if (responseJson["status"].toString() == "success"){
                                  displayToast(responseJson["message"].toString());
                                  pr.hide();

                                }
                              }else{
                                displayToast("Password not match");
                              }

                            }
                          }, "Change")),
                    ],
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
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}