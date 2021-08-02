import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Login/forgot_password.dart';
import 'package:skicom/Login/gender_selection.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:skicom/level_selection.dart';
import 'package:skicom/url.dart';

class login_Screen extends StatefulWidget {
  @override
  _login_ScreenState createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final url1 = url.basicUrl;
  final token = url.token;

  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  final _formKey = GlobalKey<FormState>();

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
                            fontSize: header)),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        textfield(
                          controller: usernameEmail_controller,
                          obscureText: false,
                          hintText: "Email/user name",
                          functionValidate: commonValidation,
                          textcapitalization: TextCapitalization.none,
                          suffixIcon: null,
                          prefixIcon: new IconButton(
                            icon: new Image.asset(
                              'Assets/Icons/profile.png',
                              width: 15.sp,
                              color: SBlack,
                            ),
                            onPressed: null,
                          ),
                          parametersValidate: "Please enter Email/User Name",
                          textInputType: TextInputType.emailAddress,
                        ),
                        textfield(
                          controller: userpassword_controller,
                          obscureText: show,
                          hintText: "Password",
                          functionValidate: commonValidation,
                          textcapitalization: TextCapitalization.none,
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
                          prefixIcon: IconButton(
                            icon: new Image.asset(
                              'Assets/Icons/password.png',
                              width: 15.sp,
                              color: SBlack,
                            ),
                            onPressed: null,
                          ),
                          parametersValidate: "Please enter Password",
                          textInputType: TextInputType.name,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
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
                                    fontSize: medium)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 90.w,
                      height: 8.0.h,
                      child: basicButton(Swhite, () async {
                        if (_formKey.currentState.validate()) {
                          print("Done");

                          final ProgressDialog pr = _getProgress(context);
                          pr.update(message: "Please wait...",
                              messageTextStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                              fontFamily: "SFPro",
                              fontSize: medium));
                          await pr.show();


                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var url = "$url1/login";

                          Map<String, String> header = {"_token": token};

                          var map = new Map<String, dynamic>();
                          map["email"] =
                              usernameEmail_controller.text.toString();
                          map["password"] =
                              userpassword_controller.text.toString();

                          final response = await http.post(Uri.parse(url),
                              body: map, headers: header);

                          final responseJson = json.decode(response.body);
                          print(responseJson.toString());

                          if (responseJson["data"].toString() != "[]") {
                            prefs.setString("userEmail",responseJson["data"]["email"].toString());
                            prefs.setString("api_token", responseJson["data"]["api_token"].toString());
                            prefs.setString("userId", responseJson["data"]["id"].toString());
                            prefs.setString("username", responseJson["data"]["username"].toString());

                            displayToast(responseJson["message"].toString());
                            pr.hide();

                            Navigator.pushReplacement(
                                context, PageTransition(
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 300),
                                    child: level_selection()));

                          } else {
                            displayToast(responseJson["message"].toString());
                            pr.hide();
                          }
                        }
                      }, "Login")),
                  Image.asset(
                    "Assets/Icons/loginwith.png",
                  ),
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
                          width: 90.w,
                          height: 8.5.h,
                          child: primarybutton("Continue with google", () {
                            _handleSignIn().then((FirebaseUser user) async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              var url = "$url1/google-login";

                              Map<String, String> header = {"_token": token};

                              var map = new Map<String, dynamic>();
                              map["f_name"] = user.displayName.toString();
                              map["l_name"] = user.displayName.toString();
                              map["email"] = user.email.toString();
                              map["userId"] = user.uid.toString();
                              map["imageUrl"] = user.photoUrl.toString();
                              map["gender"] = "";

                              final response = await http.post(url,
                                  body: map, headers: header);

                              final responseJson = json.decode(response.body);
                              print(responseJson.toString());
                              if (responseJson["success"].toString() == "Success") {
                                prefs.setString("googlePhoto", user.photoUrl.toString());

                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        alignment: Alignment.bottomCenter,
                                        duration: Duration(milliseconds: 300),
                                        child: gender_selection(
                                            responseJson, "google")));
                              }
                            }).catchError((e) => print(e));
                          }, Swhite, "Assets/Icons/Google.png", SBlack),
                        ),
                        Container(
                          width: 90.w,
                          height: 8.5.h,
                          child: primarybutton("Continue with Facebook", () {
                            initiateFacebookLogin();
                          }, SFacebook, "Assets/Icons/facebook.png", Swhite),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(width: 1, color: SGray),
                          ),
                          width: 90.w,
                          height: 8.5.h,
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

  Future<void> initiateFacebookLogin() async {
    final facebookLoginResult = await facebookSignIn.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);

        print("profile******* " + profile.toString());
        print("user Id +++++ " + profile["id"].toString());
        onLoginStatusChanged(true, profileData: profile);

        var url = "$url1/facebook-login";

        Map<String, String> header = {"_token": token};

        var map = new Map<String, dynamic>();
        map["f_name"] = profile["first_name"].toString();
        map["l_name"] = profile["last_name"].toString();
        map["email"] = profile["email"].toString();
        map["imageUrl"] = profile["picture"]["data"]["url"].toString();
        map["gender"] = "";
        map["fb_id"] = profile["id"].toString();

        final response = await http.post(url, body: map, headers: header);

        final responseJson = json.decode(response.body);
        print(responseJson.toString());
        print(responseJson["data"]["api_token"].toString());
        if (responseJson["status"].toString() == "Success") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  child: gender_selection(responseJson, "facebook")));
        }
        break;
    }
  }

  Future<FirebaseUser> _handleSignIn() async {
    _auth.app.options.catchError((error) {
      print("error---->$error");
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    print("signed in " + user.displayName);
    return user;
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
