import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Login/forgot_password.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/constants.dart';

class login_Screen extends StatefulWidget {
  @override
  _login_ScreenState createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  TextEditingController usernameEmail_controller = TextEditingController();
  TextEditingController userpassword_controller = TextEditingController();

  bool show = true;

  void onTap() {
    show = !show;
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
            height: query.height / 1.16,
            width: query.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1,
                            fontFamily: "SFPro",
                            fontSize: 30)),
                  ),
                  Column(
                    children: [
                      textfield(
                        controller: usernameEmail_controller,
                        obscureText: false,
                        hintText: "Email/user name",
                        functionValidate: commonValidation,
                        suffixIcon: null,
                        prefixIcon: new IconButton(
                          icon: new Image.asset(
                            'Assets/Icons/profile.png',
                            width: 20.0,
                            height: 20.0,
                            color: SBlack,
                          ),
                          onPressed: null,
                        ),
                        parametersValidate: "Please enter Email/User Name",
                        textInputType: TextInputType.name,
                      ),
                      textfield(
                        controller: userpassword_controller,
                        obscureText: show,
                        hintText: "Password",
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
                        parametersValidate: "Please enter Password",
                        textInputType: TextInputType.name,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 300),
                                    child: forgotPassword()));
                          },
                          child: Text("Forgot password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 2,
                                  color: Colors.black45,
                                  fontFamily: "SFPro",
                                  fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: query.height * 0.08,
                      width: query.width,
                      child: basicButton(Swhite, () {}, "Login")),
                  Image.asset("Assets/Icons/loginwith.png"),
                  Container(
                    height: query.height * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(width: 1, color: SGray),
                          ),
                          width: query.width,
                          height: query.height * 0.08,
                          child: primarybutton("Continue with google", () {},
                              Swhite, "Assets/Icons/Google.png", SBlack),
                        ),
                        Container(
                          width: query.width,
                          height: query.height * 0.08,
                          child: primarybutton("Continue with Facebook", () {},
                              SFacebook, "Assets/Icons/facebook.png", Swhite),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(width: 1, color: SGray),
                          ),
                          width: query.width,
                          height: query.height * 0.08,
                          child: primarybutton("Continue with Apple", () {},
                              Swhite, "Assets/Icons/apple.png", SBlack),
                        ),
                      ],
                    ),
                  ),
                  Text("")
                ],
              ),
            ),
          ),
        ));
  }
}
