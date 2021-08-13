import 'dart:convert';
import 'dart:io';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';

class editProfile_dialog extends StatefulWidget {
  var profiledata;

  editProfile_dialog(this.profiledata);

  @override
  _editProfile_dialogState createState() => _editProfile_dialogState();
}

class _editProfile_dialogState extends State<editProfile_dialog> {
  final url1 = url.basicUrl;
  final url2 = url.imageUrl;
  final token = url.token;

  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  File _image1;
  String urlimg1;
  String document_path1;

  @override
  void initState() {
    super.initState();
    _usernameCtrl.text = widget.profiledata["username"].toString();
    _emailCtrl.text = widget.profiledata["email"].toString();
    urlimg1 = url2 + widget.profiledata["profile"].toString();

    print(url2 + "null");
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Swhite, borderRadius: BorderRadius.circular(40.0)),
        width: query.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit profile",
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack,
                        fontSize: medium),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "Assets/Icons/cancel_dark.png",
                      height: query.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: GestureDetector(
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
                                    width: MediaQuery.of(context).size.width,
                                    child: FlatButton(
                                      onPressed: imageSelectorCameraD1,
                                      child: Row(
                                        children: <Widget>[
                                          Text("Camera"),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                            width: 0.5, color: Colors.black12),
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
                                    decoration: BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                            width: 0.5, color: Colors.black12),
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
                                  ),
                                ],
                              ),
                            ),
                          )).then((value) => null);
                },
                child: Container(
                  height: query.height * 0.15,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: _image1 == null
                                ? Image.network(
                                    urlimg1 == url2 + "null"
                                        ? "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"
                                        : urlimg1,
                                    height: query.height * 0.15,
                                    width: query.height * 0.15,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(_image1,
                                    height: query.height * 0.15,
                                    width: query.height * 0.15,
                                    fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: textfield(
                controller: _usernameCtrl,
                obscureText: false,
                hintText: "User name",
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
                parametersValidate: "Please enter User Name",
                textcapitalization: TextCapitalization.words,
                textInputType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: textfield(
                controller: _emailCtrl,
                obscureText: false,
                hintText: "Email",
                functionValidate: commonValidation,
                suffixIcon: null,
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'Assets/Icons/email.png',
                    width: 20.0,
                    height: 20.0,
                    color: SBlack,
                  ),
                  onPressed: null,
                ),
                parametersValidate: "Please enter Email",
                textcapitalization: TextCapitalization.none,
                textInputType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
              child: Container(
                  width: query.width,
                  child: basicButton(Swhite, () async {
                    final ProgressDialog pr = _getProgress(context);
                    pr.update(
                        message: "Please wait...",
                        messageTextStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "SFPro",
                            fontSize: medium));
                    pr.show();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    var postUri = Uri.parse("$url1/update-profile");
                    var request = new http.MultipartRequest("POST", postUri);

                    request.fields['username'] = _usernameCtrl.text.toString();
                    request.fields['email'] = _emailCtrl.text.toString();
                    request.fields["api_token"] =
                        prefs.getString("api_token").toString();

                    document_path1 != null
                        ? request.files.add(await MultipartFile.fromPath(
                            'image', document_path1))
                        : request.fields["image"] = "";

                    request.send().then((response) async {
                      if (response.statusCode == 200) {
                        print("Uploaded!");

                        print("--------> " + response.statusCode.toString());

                        final responseStream =
                            await response.stream.bytesToString();
                        final responseJson = json.decode(responseStream);

                        print(responseJson.toString());
                        if (responseJson["status"].toString() == "success") {
                          displayToast(responseJson["message"].toString());
                          Navigator.pop(context, true);
                          pr.hide();
                        } else {
                          displayToast(responseJson["message"].toString());
                          pr.hide();
                        }
                      } else {
                        final responseStream =
                            await response.stream.bytesToString();
                        final responseJson = json.decode(responseStream);

                        print("Not Uploaded");
                      }
                    });
                  }, "Save")),
            )
          ],
        ),
      ),
    );
  }

  void imageSelectorCameraD1() async {
    Navigator.of(context, rootNavigator: true).pop('dialog');

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
    Navigator.of(context, rootNavigator: true).pop('dialog');

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
}
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}