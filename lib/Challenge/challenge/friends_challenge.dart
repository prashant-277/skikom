import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Challenge/challenge/challenge_dialog.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class friends_challenge extends StatefulWidget {
  var group_id;

  friends_challenge(this.group_id);

  @override
  _friends_challengeState createState() => _friends_challengeState();
}

class _friends_challengeState extends State<friends_challenge> with TickerProviderStateMixin{


  int current_tab = 0;
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  bool _isloading = true;

  List memberList = [];
  String isAdmin;

  @override
  void initState() {
    super.initState();
    getGroupMember();
  }

  Future<void> getGroupMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-group-all-member";

    var map = new Map<String, dynamic>();
    map["group_id"] = widget.group_id.toString();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-group-all-member  " + responseJson.toString());
    setState(() {
      memberList = responseJson["data"];
      _isloading = false;
      isAdmin = responseJson["0"]["is_admin"].toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return  _isloading == true
        ? SpinKitRipple(
      color: SLightBlue,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1200)),
    )
        :Container(
      height: query.height,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0),
            itemCount: memberList==null?"":memberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: query.height,
                width: query.width,
                decoration: BoxDecoration(
                    color: Swhite,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.5, color: kGray)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage(
                            image: NetworkImage(imageurl +
                                memberList[index]["userdetail"]["profile"].toString()),
                            fit: BoxFit.fill,
                            width: 60.sp,
                            height: 60.sp,
                            placeholder: AssetImage(
                                "Assets/Images/giphy.gif"))),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(memberList[index]["userdetail"]["username"].toString(),
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    SizedBox(
                      height: 10.sp,
                    ),
                    memberList[index]["is_admin"].toString()=="1" ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Sgreen,width: 1),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                        child: Text("Admin",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Sgreen,
                                fontSize: small)),
                      ),
                    ): InkWell(
                      onTap: (){
                        isAdmin=="true" ? showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                contentPadding: EdgeInsets.only(
                                    left: 0, right: 0, bottom: 15, top: 0),
                                backgroundColor: Swhite,
                                content: challenge_dialog(memberList[index]["user_id"],widget.group_id))):
                        displayToast("Only admin can give challenge");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: SRed,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text("Challenge",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: Swhite,
                                  fontSize: small)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
