import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Login/login_Screen.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/level_selection.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skicom/url.dart';
class emailRegistration extends StatefulWidget {
  const emailRegistration({Key key}) : super(key: key);

  @override
  _emailRegistrationState createState() => _emailRegistrationState();
}

class _emailRegistrationState extends State<emailRegistration> {
  final _formKey = GlobalKey<FormState>();
  File _image1;
  String urlimg1;
  String document_path1;
  PermissionStatus _status;
  final url1 = url.basicUrl;
  final token = url.token;


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
  void initState() {
    super.initState();

    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then(_updateStatus);
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
            child: Form(
              key: _formKey,
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                child: IconButton(
                                  icon: _image1 == null
                                      ? Image.asset(
                                    "Assets/Icons/profile pic.png")
                                      : Container(
                                    width: MediaQuery.of(context).size.width /1,
                                    child: ClipRRect(
                                      borderRadius:
                                      new BorderRadius.circular(50.0),
                                      child: _image1 == null
                                          ? Image.network(urlimg1 == null
                                            ? "" : urlimg1,
                                        fit: BoxFit.fill,
                                      )
                                          : Image.file(_image1,
                                          height: MediaQuery.of(context).size.height / 1,
                                          width: MediaQuery.of(context).size.width / 6,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  iconSize: 90,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                        new AlertDialog(
                                          title: Text("Upload photo"),
                                          elevation: 1,
                                          contentPadding:
                                          EdgeInsets.all(5.0),
                                          content:
                                          new SingleChildScrollView(
                                            child: new ListBody(
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  child: FlatButton(
                                                    onPressed: _askPermissionD1,
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
                                                  width: MediaQuery.of(context).size.width,
                                                  child: FlatButton(
                                                    onPressed: imageSelectorGalleryD1,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                  BoxDecoration(
                                                    border: BorderDirectional(
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.black12),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: MediaQuery.of(context).size.width,
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
                                                  decoration:
                                                  BoxDecoration(
                                                    border: BorderDirectional(
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.black12),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
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
                        textcapitalization: TextCapitalization.words,
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
                        textcapitalization: TextCapitalization.none,
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
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
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
                      textfield(
                        controller: _confirmpswdCtrl,
                        obscureText: confirmshow,
                        hintText: "Confirm password",
                        textcapitalization: TextCapitalization.none,
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
                        if (_formKey.currentState.validate()) {
                          if(_pswdCtrl.text.toString() == _confirmpswdCtrl.text.toString()){
                            registrationData();
                          }else{
                            displayToast("Password not match");
                          }

                        } else {
                          displayToast("Enter valid data");
                        }

                      }, "Register")),
                  Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _askPermissionD1() {
    PermissionHandler().requestPermissions([PermissionGroup.camera]).then(
        _onStatusRequestedD1);
  }

  void _onStatusRequestedD1(Map<PermissionGroup, PermissionStatus> value) {
    final status = value[PermissionGroup.camera];
    if (status == PermissionStatus.granted) {
      imageSelectorCameraD1();
    } else {
      _updateStatus(status);
    }
  }

  _updateStatus(PermissionStatus value) {
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }
  }

  void imageSelectorCameraD1() async {
    Navigator.pop(context);
    var imageFile1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      print(document_path1);
    });
    document_path1 = imageFile1.path;
    if (document_path1.indexOf('file://') == 0) {
      document_path1 = document_path1.split('file://')[1];
      print(document_path1);
    }
    setState(() {
      _image1 = imageFile1;
      print(document_path1);
    });
  }

  void imageSelectorGalleryD1() async {
    Navigator.pop(context);
    var imageFile1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      print(document_path1);
    });
    document_path1 = imageFile1.path;
    if (document_path1.indexOf('file://') == 0) {
      document_path1 = document_path1.split('file://')[1];
      print(document_path1);
      //document_path1 = File(file) as String;
    }
    setState(() {
      _image1 = imageFile1;
    });
  }

  Future<void> registrationData() async {

    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    pr.show();
    var postUri = Uri.parse("$url1/register");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['username'] = _usernameCtrl.text.toString();
    request.fields['email'] = _emailCtrl.text.toString();
    request.fields['gender'] = gender.toString();
    request.fields['password'] = _pswdCtrl.text.toString();
    request.fields['password'] = _confirmpswdCtrl.text.toString();

    request.headers["_token"] = token.toString();

    document_path1 != null
        ? request.files
        .add(await MultipartFile.fromPath('image', document_path1))
        : request.fields["image"] = "";

    request.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded!");

        print("--------> " + response.statusCode.toString());

        final responseStream = await response.stream.bytesToString();
        final responseJson = json.decode(responseStream);

        print(responseJson.toString());
        if (responseJson["status"].toString() == "success") {
          displayToast(responseJson["message"].toString());

          pr.hide();
          Timer(
              Duration(seconds: 1),
                  () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.bottomCenter,
                      duration: Duration(milliseconds: 300),
                      child: login_Screen())));
        } else {
          displayToast(responseJson["message"].toString());
        }
      } else {
        final responseStream = await response.stream.bytesToString();
        final responseJson = json.decode(responseStream);

        print("Not Uploaded");
      }
    });
  }

}
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
