import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/constants.dart';

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
      /*appBar: BaseAppBar(appBar: AppBar(),
      backgroundColor: Swhite,
      appbartext: "",
      ),*/
      body: SingleChildScrollView(
        child: Container(
          color: Swhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(""),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "Assets/Icons/back.png",
                  height: 15,
                  color: SBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Change password",
                  style: TextStyle(
                      color: SBlack,
                      fontSize: 25,
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
                      Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: textfield(
                            controller: _oldpswdCtrl,
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
                          )),
                      SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: textfield(
                            controller: _newpswdCtrl,
                            obscureText: show1,
                            hintText: "Password",
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
                            parametersValidate: "Please enter Password",
                            textInputType: TextInputType.name,
                          )),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: textfield(
                          controller: _confirmpswdCtrl,
                          obscureText: show2,
                          hintText: "Password",
                          functionValidate: commonValidation,
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
                          parametersValidate: "Please enter Password",
                          textInputType: TextInputType.name,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: basicButton(Swhite, () {}, "Change")),
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
