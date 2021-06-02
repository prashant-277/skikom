import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/level_selection.dart';
import 'package:sizer/sizer.dart';

class emailRegistration extends StatefulWidget {
  const emailRegistration({Key key}) : super(key: key);

  @override
  _emailRegistrationState createState() => _emailRegistrationState();
}

class _emailRegistrationState extends State<emailRegistration> {
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pswdCtrl = TextEditingController();
  TextEditingController _confirmpswdCtrl = TextEditingController();
  bool show = true;
  bool confirmshow = true;

  String gender;

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
          width: query.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Register",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1,
                          fontFamily: "SFPro",
                          fontSize: header)),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                                  title: Text("Upload photo"),
                                  elevation: 1,
                                  contentPadding: EdgeInsets.all(5.0),
                                  content: new SingleChildScrollView(
                                    child: new ListBody(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FlatButton(
                                            //onPressed: imageSelectorCameraD1,
                                            child: Row(
                                              children: <Widget>[
                                                Text("Camera"),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FlatButton(
                                            //onPressed: imageSelectorGalleryD1,
                                            child: Row(
                                              children: <Widget>[
                                                Text("Gallery"),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text("Cancel"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )).then((value) => null);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(100.0),
                                    child: Text(""))
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "Assets/Icons/profile pic.png",
                                height: query.height * 0.14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    textfield(
                      controller: _usernameCtrl,
                      obscureText: false,
                      hintText: "User name",
                      functionValidate: commonValidation,
                      suffixIcon: null,
                      prefixIcon: new IconButton(
                        icon: new Image.asset(
                          'Assets/Icons/profile.png',
                          width: 15.sp,
                          color: SBlack,
                        ),
                        onPressed: null,
                      ),
                      parametersValidate: "Please enter User Name",
                      textInputType: TextInputType.name,
                    ),
                    textfield(
                      controller: _emailCtrl,
                      obscureText: false,
                      hintText: "Email",
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
                      textInputType: TextInputType.name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 42.sp,
                        decoration: new BoxDecoration(
                          color: Swhite,
                          border: new Border.all(width: 1.0, color: SGray),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Image.asset('Assets/Icons/gender.png',
                                    width: 15.sp, color: SBlack),
                                SizedBox(width: 8),
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      color: Colors.grey,
                                      fontSize: medium,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SBlack),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 18.sp,
                              color: SBlack,
                            ),
                            underline: Text(""),
                            elevation: 0,
                            items: <String>[
                              'Male',
                              'Female',
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('Assets/Icons/gender.png',
                                        width: 15.sp, color: SBlack),
                                    Padding(
                                      padding: const EdgeInsets.only(left:12.0),
                                      child: new Text(value,
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w500,
                                              fontSize: medium,
                                              color: SBlack)),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            value: gender,
                            onChanged: (newValue) {
                              setState(() {
                                gender = newValue;
                                print(gender);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    textfield(
                      controller: _pswdCtrl,
                      obscureText: show,
                      hintText: "Password",
                      functionValidate: commonValidation,
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
                    textfield(
                      controller: _confirmpswdCtrl,
                      obscureText: confirmshow,
                      hintText: "Confirm password",
                      functionValidate: commonValidation,
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
                      prefixIcon: IconButton(
                        icon: new Image.asset(
                          'Assets/Icons/password.png',
                          width: 15.sp,
                          color: SBlack,
                        ),
                        onPressed: null,
                      ),
                      parametersValidate: "Please enter confirm Password",
                      textInputType: TextInputType.name,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    height: 45.sp,
                    width: query.width,
                    child: basicButton(Swhite, () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: level_selection()));
                    }, "Register")),
                Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
