import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Challenge/challenge/chalengeHome_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class challenge_groupList extends StatefulWidget {
  const challenge_groupList({Key key}) : super(key: key);

  @override
  _challenge_groupListState createState() => _challenge_groupListState();
}

class _challenge_groupListState extends State<challenge_groupList>
    with TickerProviderStateMixin {
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;

  bool _isloading = true;
  List groupList = [];

  String message;

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  Future<void> getGroups() async {

    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-all-group";

    var map = new Map<String, dynamic>();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-all-group  " + responseJson.toString());
    setState(() {
      pr.hide();
      groupList = responseJson["data"];
      _isloading = false;
      message = responseJson["message"].toString();
      joingroup=0;
    });
  }

  int search = 0;
  TextEditingController search_ctrl = TextEditingController();
  int joingroup = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: search == 0
          ? commanAppBar(
              appBar: AppBar(),
              appbartext: "Challenge",
              colorImage: Swhite,
              fontsize: medium,
              imageBack: true,
              widgets: [
                FlatButton(
                    highlightColor: Colors.transparent,
                    color: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        search = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Text("Search",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: medium)),
                        SizedBox(width: 8),
                        Image.asset(
                          "Assets/Icons/search.png",
                          height: 15,
                        )
                      ],
                    ))
              ],
            )
          : AppBar(
              automaticallyImplyLeading: false,
              title: TextField(
                controller: search_ctrl,
                maxLines: 1,
                autofocus: true,
                cursorColor: Swhite,
                style: TextStyle(
                    fontFamily: "SFPro", fontSize: medium, color: Swhite),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 25, bottom: 11, top: 11, right: 15),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                        fontFamily: "SFPro", color: Swhite,
                        fontSize: medium,
                        decoration: TextDecoration.none)),
                cursorHeight: 20.sp,
                onChanged: (value){
                  setState(() {
                    searchData();
                  });
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = 0;
                        getGroups();
                        joingroup=0;
                        search_ctrl.text="";

                      });
                    },
                    icon: Icon(Icons.cancel_outlined))
              ],
            ),
      body: _isloading == true
          ? SpinKitRipple(
              color: SLightBlue,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            )
          : Container(
              color: Swhite,
              height: query.height,
              child: groupList.toString() == "[]"
                  ? Container(
                      color: Swhite,
                      child: Center(
                          child: Text("No data found",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w500,
                                  color: SBlack,
                                  fontSize: medium))))
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: groupList == null ? "" : groupList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(height: 3.sp),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Swhite,
                                    border: Border.all(color: SGray, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: query.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: FadeInImage(
                                                  image: NetworkImage(imageurl +
                                                      groupList[index]["group_image"].toString()),
                                                  fit: BoxFit.fill,
                                                  width: 80.sp,
                                                  height: 80.sp,
                                                  placeholder: AssetImage(
                                                      "Assets/Images/giphy.gif"))),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              height: 75.sp,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    groupList[index]["group_name"],
                                                    style: TextStyle(
                                                        fontFamily: "SFPro",
                                                        fontWeight: FontWeight.w600,
                                                        color: SBlack,
                                                        fontSize: medium),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Created date : ",
                                                          style: TextStyle(
                                                              fontFamily: "SFPro",
                                                              fontWeight: FontWeight.w600,
                                                              color: SBlack,
                                                              fontSize: small)),
                                                      Text(
                                                        groupList[index]["date"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: "SFPro",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: SBlack,
                                                            fontSize: small),
                                                      )
                                                    ],
                                                  ),
                                                  joingroup==0?FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context, rootNavigator:true)
                                                          .push(PageTransition(
                                                              type:PageTransitionType.fade,
                                                              alignment: Alignment.bottomCenter,
                                                              duration: Duration(milliseconds:300),
                                                              child: challengeHome_page(
                                                                  groupList[index]["id"],
                                                                  groupList[index]["group_name"])));
                                                    },
                                                    child: Text(
                                                      groupList[index]["members_count"].toString() +
                                                          " Member",
                                                      style: TextStyle(
                                                        fontSize: small,
                                                        color: Swhite,
                                                        fontFamily: "SFPro",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    color: Sgreen,
                                                  ):
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

                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                      var url = "$url1/join-a-group";
                                                      var map = new Map<String, dynamic>();
                                                      map["user_id"] = prefs.getString("userId").toString();
                                                      map["group_id"] = groupList[index]["id"].toString();
                                                      Map<String, String> headers = {"_token": token};

                                                      final response =
                                                          await http.post(url, body: map, headers: headers);
                                                      final responseJson = json.decode(response.body);
                                                      print("res join-a-group  " + responseJson.toString());
                                                      if(responseJson["status"].toString()=="success"){
                                                        displayToast(responseJson["message"].toString());
                                                        pr.hide();
                                                      }

                                                    },
                                                    child: Text("Join group",
                                                      style: TextStyle(
                                                        fontSize: small,
                                                        color: Swhite,
                                                        fontFamily: "SFPro",
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                    color: Sgreen,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
            ),
    );
  }

  Future<void> searchData() async {

    setState(() {
      joingroup = 1;
    });
    var url = "$url1/search-group";
    var map = new Map<String, dynamic>();
    map["search"] = search_ctrl.text.toString();

    Map<String, String> headers = {"_token": token};

    final response =
        await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res search-group  " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      setState(() {
        groupList = responseJson["data"];
        message = responseJson["message"].toString();
        if(search_ctrl.text.toString()==""){
          getGroups();
        }
      });
      //displayToast(responseJson["message"].toString());

    }
  }
}
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}