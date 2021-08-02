import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Challenge/challenge/startChallenge_page.dart';
import 'package:skicom/Widgets/toastDisplay.dart';

import '../../constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class requests_challenge extends StatefulWidget {
  var group_id;

  requests_challenge(this.group_id);

  @override
  _requests_challengeState createState() => _requests_challengeState();
}

class _requests_challengeState extends State<requests_challenge>
    with TickerProviderStateMixin {
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  bool _isloading = true;

  List requestList = [];
  List memberrequestList = [];

  String message;
  int challenge = 0;
  int memberstatus = 0;

  String isAdmin;

  @override
  void initState() {
    super.initState();
    getrequestList();
    getgroupmemberrequestList();
  }

  Future<void> getrequestList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-request-list";

    var map = new Map<String, dynamic>();
    map["group_id"] = widget.group_id.toString();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-request-list  " + responseJson.toString());
    setState(() {

      requestList = responseJson["data"];
      _isloading = false;
      message = responseJson["message"].toString();
    });
  }

  Future<void> getgroupmemberrequestList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/group-member-request-list";

    var map = new Map<String, dynamic>();
    map["group_id"] = widget.group_id.toString();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("group-member-request-list  " + responseJson.toString());
    setState(() {
      if(responseJson["status"].toString()=="success"){
        memberrequestList = responseJson["data"]["list"];
        isAdmin = responseJson["data"]["is_admin"].toString();
      }
      _isloading = false;
      message = responseJson["message"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return _isloading == true
        ? SpinKitRipple(
            color: SLightBlue,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
          )
        : Container(
            height: query.height,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: isAdmin=="true" ? Container(
                height: query.height,
                child: memberrequestList.toString()=="[]"?
                Container(height:query.height,width:query.width,child: Center(child: Text("No data found",
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w500,
                        color: SBlack,
                        fontSize: medium)))): GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55.sp,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0),
                    itemCount: memberrequestList == null ? "" : memberrequestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        child: Container(
                          width: query.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(width: 1.5, color: kGray)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage(
                                        image: NetworkImage(imageurl +
                                            memberrequestList[index]["userdetail"]
                                            ["profile"]
                                                .toString()),
                                        fit: BoxFit.fill,
                                        width: 60.sp,
                                        height: 60.sp,
                                        placeholder: AssetImage(
                                            "Assets/Images/giphy.gif"))),
                                SizedBox(height: 3.sp),
                                Text(
                                    memberrequestList[index]["userdetail"]
                                    ["username"]
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w600,
                                        color: SBlack,
                                        fontSize: medium)),
                                Text("sent you a join member request",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w500,
                                        color: SBlack,
                                        fontSize: small)),

                                SizedBox(height: 8.sp),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      memberstatus = 1;
                                    });
                                    acceptmemberRequest(index);
                                  },
                                  child: Container(
                                    width: query.width,
                                    height: 25.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                        BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Center(
                                        child: Text("Confirm",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: Swhite,
                                                fontSize: small)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.sp),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      memberstatus = 0;
                                    });
                                    acceptmemberRequest(index);
                                  },
                                  child: Container(
                                    width: query.width,
                                    height: 25.sp,
                                    decoration: BoxDecoration(
                                        color: SRed,
                                        borderRadius:
                                        BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Center(
                                        child: Text("Delete",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: Swhite,
                                                fontSize: small)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ): Container(
                height: query.height,
                child: requestList.toString()=="[]"?
                Container(
                    height:query.height,
                    width:query.width,
                    child: Center(child: Text("No data found",
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w500,
                        color: SBlack,
                        fontSize: medium)))):GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.55.sp,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0),
                        itemCount: requestList == null ? "" : requestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: Container(
                              width: query.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(width: 1.5, color: kGray)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: FadeInImage(
                                            image: NetworkImage(imageurl +
                                                requestList[index]["touserdetail"]
                                                        ["profile"].toString()),
                                            fit: BoxFit.fill,
                                            width: 60.sp,
                                            height: 60.sp,
                                            placeholder: AssetImage(
                                                "Assets/Images/giphy.gif"))),
                                    SizedBox(height: 3.sp),
                                    Text(
                                        requestList[index]["touserdetail"]
                                                ["username"].toString(),
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w600,
                                            color: SBlack,
                                            fontSize: medium)),
                                    Text(
                                        requestList[index]["for_km"].toString() +
                                            " request",
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w500,
                                            color: SBlack,
                                            height: 1.5,
                                            fontSize: small)),
                                    SizedBox(height: 8.sp),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          challenge = 1;
                                          //getrequestList();
                                        });
                                        acceptRequest(index);
                                      },
                                      child: Container(
                                        width: query.width,
                                        height: 25.sp,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5),
                                          child: Center(
                                            child: Text("Accept",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w600,
                                                    color: Swhite,
                                                    fontSize: small)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.sp),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          challenge = 2;
                                          acceptRequest(index);
                                        });
                                      },
                                      child: Container(
                                        width: query.width,
                                        height: 25.sp,
                                        decoration: BoxDecoration(
                                            color: SRed,
                                            borderRadius: BorderRadius.circular(5.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5),
                                          child: Center(
                                            child: Text("Decline",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w600,
                                                    color: Swhite,
                                                    fontSize: small)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          );
  }

  Future<void> acceptRequest(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    await pr.show();
    var url = "$url1/accept-request";
    var map = new Map<String, dynamic>();
    map["group_id"] = widget.group_id.toString();
    map["to_user"] = prefs.getString("userId").toString();
    map["status"] = challenge.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res accept-request  " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      displayToast(responseJson["message"].toString());
      getrequestList();
      await pr.hide();

      if (challenge == 1) {
        print("challenge id--- " + responseJson["data"]["id"].toString());
        Navigator.of(context, rootNavigator: true).push(PageTransition(
            type: PageTransitionType.fade,
            alignment: Alignment.bottomCenter,
            duration: Duration(milliseconds: 300),
            child: startChallenge(widget.group_id,responseJson["data"]["id"])));
      } else {
        getrequestList();
      }
    }
  }
  Future<void> acceptmemberRequest(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(memberstatus);
    print(memberrequestList[index]["user_id"].toString());
    print(widget.group_id.toString());
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    await pr.show();
    var url = "$url1/accept-group-member";
    var map = new Map<String, dynamic>();
    map["user_id"] = memberrequestList[0]["user_id"].toString();
    map["group_id"] = widget.group_id.toString();
    map["status"] = memberstatus.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res accept-request  " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      displayToast(responseJson["message"].toString());
      getgroupmemberrequestList();
      await pr.hide();

    }
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
