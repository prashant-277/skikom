import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
class addGroup_dialog extends StatefulWidget {


  @override
  _addGroup_dialogState createState() => _addGroup_dialogState();
}

class _addGroup_dialogState extends State<addGroup_dialog> with TickerProviderStateMixin{
  final url1 = url.basicUrl;
  final token = url.token;
  File _image1;
  String urlimg1;
  String document_path1;

  final imageurl = url.imageUrl;
  TextEditingController groupName_ctrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Swhite, borderRadius: BorderRadius.circular(40.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "Assets/Icons/cancel_dark.png",
                    height: query.height * 0.02,
                  ),
                )),
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
            SizedBox(height: 10.sp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: textfield(
                controller: groupName_ctrl,
                hintText: "Group name",
                obscureText: false,
                textInputType: TextInputType.text,
                textcapitalization: TextCapitalization.words,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("Assets/Icons/profile.png",height: 5.sp),
                ),
              ),
            ),
            SizedBox(height: 10.sp),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20,bottom: 10),
              child: Container(
                  height: 40.sp,
                  width: query.width,
                  child: basicButton(Swhite, () {
                    createGroup();
                  }, "Create")),
            )
          ],
        ),
      ),
    );
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

  Future<void> createGroup() async {
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    pr.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var postUri = Uri.parse("$url1/make-group");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['group_name'] = groupName_ctrl.text.toString();
    request.fields['user_id'] = prefs.getString("userId").toString();

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
          Navigator.pop(context);
          pr.hide();
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