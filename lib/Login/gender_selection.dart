import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

import '../level_selection.dart';

class gender_selection extends StatefulWidget {
  var fbresponse;
  String facebook;

  gender_selection(this.fbresponse, this.facebook);

  @override
  _gender_selectionState createState() => _gender_selectionState();
}

class _gender_selectionState extends State<gender_selection> {
  List<RadioModel> sampleData = new List<RadioModel>();
  final url1 = url.basicUrl;
  final token = url.token;

  String checkApi;

  @override
  void initState() {
    super.initState();

    sampleData.add(new RadioModel(false, 'Assets/Icons/boy.png', 'Male',
        Icon(Icons.arrow_back_ios_outlined), "Assets/Icons/boy_act.png"));
    sampleData.add(new RadioModel(false, 'Assets/Icons/girl.png', 'Female',
        Icon(Icons.arrow_forward_ios_outlined), "Assets/Icons/girl_act.png"));
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/Images/background.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            IconButton(
              onPressed: null,
              icon: Image.asset(
                "Assets/Icons/back.png",
                height: 12.sp,
                color: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Select Gender",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        height: 1,
                        fontFamily: "SFPro",
                        fontSize: header)),
              ),
            ),
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        sampleData
                            .forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;

                        prefs.setString("gender", sampleData[index].text);
                      });
                      print("gender " + sampleData[index].text);
                    },
                    child: new RadioItem(sampleData[index]),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: basicButton(Swhite, () async {
                      if (widget.facebook == "facebook") {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        var url = "$url1/facebook-login";

                        Map<String, String> header = {
                          "_token": token
                        };
                        print("gender " + prefs.getString("gender").toString());
                        var map = new Map<String, dynamic>();
                        map["f_name"] =
                            widget.fbresponse["data"]["f_name"].toString();
                        map["l_name"] =
                            widget.fbresponse["data"]["l_name"].toString();
                        map["email"] =
                            widget.fbresponse["data"]["email"].toString();
                        map["imageUrl"] =
                            widget.fbresponse["data"]["profile"].toString();
                        map["gender"] = prefs.getString("gender").toString();
                        map["fb_id"] =
                            widget.fbresponse["data"]["fb_id"].toString();

                        final response =
                            await http.post(url, body: map, headers: header);

                        final responseJson = json.decode(response.body);
                        print(responseJson.toString());
                        print(responseJson["data"]["api_token"].toString());
                        if (responseJson["status"].toString() == "Success") {
                          prefs.setString("api_token",
                              responseJson["data"]["api_token"].toString());
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.bottomCenter,
                                  duration: Duration(milliseconds: 300),
                                  child: level_selection()));
                          displayToast(responseJson["message"].toString());
                        } else {
                          displayToast(responseJson["message"].toString());
                        }
                      } else if (widget.facebook == "google") {
                        print("google");
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        print(widget.fbresponse["data"]["f_name"].toString());

                        var url = "$url1/google-login";

                        Map<String, String> header = {
                          "_token": token.toString()
                        };
                        var map = new Map<String, dynamic>();
                        map["f_name"] =
                            widget.fbresponse["data"]["f_name"].toString();
                        map["l_name"] =
                            widget.fbresponse["data"]["l_name"].toString();
                        map["email"] =
                            widget.fbresponse["data"]["email"].toString();
                        map["userId"] =
                            widget.fbresponse["data"]["fb_id"].toString();
                        map["imageUrl"] =
                            prefs.getString("googlePhoto").toString();
                        map["gender"] = prefs.getString("gender").toString();

                        final response =
                            await http.post(url, body: map, headers: header);
                        final responseJson = json.decode(response.body);
                        print(responseJson.toString());
                        print(responseJson["data"]["api_token"].toString());

                        if (responseJson["success"].toString() == "Success") {
                          prefs.setString("api_token",
                              responseJson["data"]["api_token"].toString());
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.bottomCenter,
                                  duration: Duration(milliseconds: 300),
                                  child: level_selection()));
                          displayToast(responseJson["message"].toString());
                        } else {
                          displayToast(responseJson["message"].toString());
                        }
                      }
                    }, "Register"))),
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(20.0),
      child: new Row(
        children: <Widget>[
          Stack(
            children: [
              Container(
                //height: 45.0,
                width: 75.0.sp,
                child: new Image.asset(
                    _item.isSelected ? _item.buttonText1 : _item.buttonText),
                decoration: new BoxDecoration(
                  color: _item.isSelected
                      ? Colors.transparent
                      : Colors.transparent,
                  border: new Border.all(
                      width: 0.0,
                      color: _item.isSelected
                          ? Colors.transparent
                          : Colors.transparent),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(50.0)),
                ),
              ),
              Container(
                width: 70.sp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(""),
                    Image.asset("Assets/Icons/select.png",
                        height: _item.isSelected ? 25 : 0),
                  ],
                ),
              )
            ],
          ),
          new Container(
            margin: new EdgeInsets.only(left: 0.0),
            child: new Text(
              _item.text,
              style: TextStyle(
                  fontFamily: "SFPro", fontSize: medium, color: SBlack),
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String buttonText1;
  final String text;
  final Widget icon;

  RadioModel(
      this.isSelected, this.buttonText, this.text, this.icon, this.buttonText1);
}
