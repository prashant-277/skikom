import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Profile/addGroup_dialog.dart';
import 'package:skicom/Profile/editGroup_dialog.dart';
import 'package:skicom/Profile/groupMemberPage.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
class myChallengeGroup extends StatefulWidget {
  const myChallengeGroup({Key key}) : super(key: key);

  @override
  _myChallengeGroupState createState() => _myChallengeGroupState();
}

class _myChallengeGroupState extends State<myChallengeGroup> with TickerProviderStateMixin {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-all-group";

    var map = new Map<String, dynamic>();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-all-group  " + responseJson.toString());
    setState(() {
      groupList = responseJson["data"];
      _isloading = false;
      message = responseJson["message"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "My challenge group",
        fontsize: medium,
        imageBack: true,
        colorImage: Swhite,

      ),
      body: _isloading == true
          ? SpinKitRipple(
        color: SLightBlue,
        controller: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1200)),
      )
          : ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: query.height / 1.30,
            child: message=="Group not found"?
            Container(
                color: Swhite,
                child: Center(
                    child: Text("No data found",style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w500,
                        color: SBlack,
                        fontSize: medium)))):
            ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: groupList == null ? "" : groupList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Swhite,
                                        border: Border.all(
                                            color: SGray, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    width: query.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(10.0),
                                                  child: FadeInImage(
                                                      image: NetworkImage(
                                                          imageurl +
                                                              groupList[index]["group_image"]
                                                                  .toString()),
                                                      fit: BoxFit.fill,
                                                      width: 80.sp,
                                                      height: 80.sp,
                                                      placeholder: AssetImage(
                                                          "Assets/Images/giphy.gif"))),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Container(
                                                  height: 75.sp,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        groupList[index]["group_name"],
                                                        style: TextStyle(
                                                            fontFamily: "SFPro",
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: SBlack,
                                                            fontSize: medium),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Created date : ",
                                                              style: TextStyle(
                                                                  fontFamily: "SFPro",
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  color: SBlack,
                                                                  fontSize: small)),
                                                          Text(
                                                            groupList[index]["date"].toString(),
                                                            style: TextStyle(
                                                                fontFamily: "SFPro",
                                                                fontWeight: FontWeight.w500,
                                                                color: SBlack,
                                                                fontSize: small),
                                                          )
                                                        ],
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                              rootNavigator: true).push(
                                                            new MaterialPageRoute(
                                                                builder: (_) =>
                                                                new groupMemberPage(
                                                                    groupList[index]["id"],
                                                                    groupList[index]["group_name"])))
                                                              .then((val) => getGroups());
                                                        },
                                                        child: Text(
                                                          groupList[index]["members_count"].toString() +
                                                              " Member",
                                                          style: TextStyle(
                                                            fontSize: small,
                                                            color: Swhite,
                                                            fontFamily: "SFPro",
                                                            fontWeight: FontWeight
                                                                .w600,
                                                          ),
                                                        ),
                                                        color: Sgreen,
                                                      ),
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
                            ),
                            secondaryActions: <Widget>[
                              Container(
                                height: 40.sp,
                                child: IconSlideAction(
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                  if(prefs.getString("userId").toString()==groupList[index]["user_id"].toString()){
                                    showAlertDialog(groupList[index]["id"].toString());
                                  }else{
                                    displayToast("Only admin can delete group");
                                  }
                                  },
                                  iconWidget: Image.asset(
                                      "Assets/Icons/delete_1.png"),
                                ),
                              ),
                              Container(
                                height: 40.sp,
                                child: IconSlideAction(
                                  iconWidget:
                                  Image.asset("Assets/Icons/edit_1.png"),
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    if(prefs.getString("userId").toString()==groupList[index]["user_id"].toString()){
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              AlertDialog(
                                                  contentPadding: EdgeInsets.only(
                                                      left: 0,
                                                      right: 0,
                                                      bottom: 15,
                                                      top: 0),
                                                  backgroundColor: Swhite,
                                                  content: editGroup_dialog(
                                                      groupList[index]["id"])))
                                          .then((value) => getGroups());
                                    }else{
                                      displayToast("Only admin can edit group");
                                    }

                                  },
                                  foregroundColor: Swhite,
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Container(
                width: query.width,
                child: basicButton(Swhite, () {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                              contentPadding: EdgeInsets.only(
                                  left: 0, right: 0, bottom: 15, top: 0),
                              backgroundColor: Swhite,
                              content: addGroup_dialog())).then((value) =>
                      getGroups());
                }, "Add new group")),
          )
        ],
      ),
    );
  }

  void showAlertDialog(String group_id) {
    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium),),
      onPressed: ()  {
          deleteItem(group_id);
      },
    );
    Widget noButton = FlatButton(
      child: Text("No", style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Do you really want to delete this group?", style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium),),
      actions: [
        yesButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deleteItem(group_id) async {
    var url = "$url1/remove-group";

    var map = new Map<String, dynamic>();
    map["group_id"] = group_id.toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res remove-group  " + responseJson.toString());

    if (responseJson["status"].toString() == "success") {
      displayToast(responseJson["message"].toString());
      Navigator.pop(context);
      getGroups();
    }
  }
}