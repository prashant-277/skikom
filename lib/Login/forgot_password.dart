import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/confirmAccount.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';

import '../constants.dart';

class forgotPassword extends StatefulWidget {
  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
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
                            fontSize: 30)),
                  ),
                  Text(
                      "Enter your email address below and we will send you a reset link",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "SFPro",
                          height: 1.5,
                          fontSize: 18)),
                  textfield(
                    controller: email_controller,
                    obscureText: false,
                    hintText: "Email",
                    functionValidate: commonValidation,
                    suffixIcon: null,
                    prefixIcon: new IconButton(
                      icon: new Image.asset(
                        'Assets/Icons/email.png',
                        width: 25.0,
                        height: 25.0,
                        color: SBlack,
                      ),
                      onPressed: null,
                    ),
                    parametersValidate: "Please enter Email",
                    textInputType: TextInputType.name,
                  ),
                  Container(
                      height: query.height * 0.08,
                      width: query.width,
                      child: basicButton(Swhite, () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.bottomCenter,
                                duration: Duration(milliseconds: 300),
                                child: confirmAccount()));
                      }, "Send")),
                ],
              ),
            ),
          ),
        ));
  }
}
