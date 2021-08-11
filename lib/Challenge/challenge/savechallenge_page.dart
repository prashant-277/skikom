import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';

import '../leaderboard_page.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class saveChallenge_page extends StatefulWidget {
  var group_id;

  saveChallenge_page(this.group_id);

  @override
  _saveChallenge_pageState createState() => _saveChallenge_pageState();
}

class _saveChallenge_pageState extends State<saveChallenge_page> {
  double sliderValue = 500.0;
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  bool _isloading = true;
  List resultdata = [];
  TextEditingController title_ctrl = TextEditingController();


  @override
  void initState() {
    super.initState();
    getChallengeResult();
  }

  Future<void> getChallengeResult() async {
    var url = "$url1/get-challenge-result";

    var map = new Map<String, dynamic>();
    map["group_id"] = widget.group_id.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-challenge-result  " + responseJson.toString());
    setState(() {
      resultdata = responseJson["data"];
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: SGray,
        appBar: commanAppBar(
          appBar: AppBar(),
          fontsize: medium,
          imageBack: false,
          colorImage: Swhite,
          appbartext: "Result",
          widgets: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconbuttonG(() async {
                showdeleteDialog();
              }, "Assets/Icons/delete.png"),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: query.width,
            color: Swhite,
            child: Column(

              children: [
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: resultdata.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Swhite,
                            width: query.width,
                            height: query.height * 0.12,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text((index + 1).toString(),
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: SBlack,
                                          fontSize: medium)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FadeInImage(
                                          image: NetworkImage(imageurl +
                                              resultdata[index]["userdetail"]["profile"].toString()),
                                          fit: BoxFit.fill,
                                          width: 60.sp,
                                          height: 60.sp,
                                          placeholder: AssetImage(
                                              "Assets/Images/giphy.gif"))),
                                ),
                                SizedBox(width: 10),
                                SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Container(
                                    //   height: query.height * 0.15,
                                    width: query.width / 1.7,
                                    child: Column(
                                      children: [
                                        Text(""),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(resultdata[index]["userdetail"]["username"].toString(),
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: SBlack,
                                                    fontSize: medium)),
                                            Text(resultdata[index]["km"].toString() +" km",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small)),
                                          ],
                                        ),
                                        SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 3.5,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius:2.0,
                                                        elevation: 0),
                                                showValueIndicator:
                                                    ShowValueIndicator.always,
                                                valueIndicatorShape:
                                                    PaddleSliderValueIndicatorShape(),
                                                trackShape:
                                                    CustomTrackShape(),
                                                overlayColor:
                                                    Colors.transparent),
                                            child: Container(
                                              width: query.width * 0.9,
                                              child: Slider(
                                                  value: double.parse(resultdata[index]["km"].toString()),
                                                  min: 0.0,
                                                  max: 50,
                                                  activeColor: SBlue,
                                                  inactiveColor: kGray,
                                                  onChanged:
                                                      (double newValue) {
                                                    /*setState(() {
                                                              sliderValue = newValue.round();
                                                            });*/
                                                  },
                                                  semanticFormatterCallback:
                                                      (double newValue) {
                                                    return '${newValue.round()}';
                                                  }),
                                            )),
                                        Text("")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: kGray,
                            thickness: 1,
                          )
                        ],
                      );
                    }),
                Container(
                  color: kGray,
                  width: query.width,
                  height: 45.sp,
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Custom save",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w500,
                                  color: SBlack,
                                  fontSize: medium)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Swhite,
                  width: query.width,
                  height: 40.sp,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Title : ",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: medium)),
                        /*Text("Please Enter title",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SBlack,
                                fontSize: 16)),*/
                        Container(
                          width: 150.sp,
                          child: TextField(
                            controller: title_ctrl,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: medium,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "Please enter title",
                              hintStyle: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w500,
                                  color: SGray),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  color: Swhite,
                  width: query.width,
                  height: 40.sp,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Save as : ",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: medium)),
                        Text("Challenge",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SBlack,
                                fontSize: medium)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: query.width,
                  color: SGray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10.sp),
                      Container(
                        height: 45.sp,
                        width: query.width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: SBlack, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.transparent,
                          child: Text(
                            "Share with friends",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      Container(
                          height: 45.sp,
                          width: query.width / 1.2,
                          child: basicButton(Swhite, () async {
                            if (title_ctrl.text.toString().isEmpty) {
                              displayToast("Please enter title");
                            } else {
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

                              var url = "$url1/save-challenge-result";

                              var map = new Map<String, dynamic>();
                              map["group_id"] = widget.group_id.toString();
                              map["title"] = title_ctrl.text.toString();
                              map["user_id"] =
                                  prefs.getString("userId").toString();
                              map["type"] = "challenge";

                              Map<String, String> headers = {"_token": token};

                              final response = await http.post(url,
                                  body: map, headers: headers);
                              final responseJson = json.decode(response.body);
                              print("res save-challenge-result  " +
                                  responseJson.toString());

                              if (responseJson["status"].toString() ==
                                  "success") {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                pr.hide();

                              }
                            }
                          }, "Save")),
                      SizedBox(height: 10.sp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showdeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to delete this history?',
            style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () async {
              final ProgressDialog pr = _getProgress(context);
              pr.update(
                  message: "Please wait...",
                  messageTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "SFPro",
                      fontSize: medium));
              pr.show();
              var url = "$url1/delet-result";

              var map = new Map<String, dynamic>();
              map["group_id"] = widget.group_id.toString();

              Map<String, String> headers = {"_token": token};

              final response =
                  await http.post(url, body: map, headers: headers);
              final responseJson = json.decode(response.body);
              print("res delet-result  " + responseJson.toString());

              if (responseJson["status"].toString() == "success") {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                pr.hide();
              }
            },
            child: Text('Yes',
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
