import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class add_user extends StatefulWidget {
  var groupId;

  add_user(this.groupId);



  @override
  _add_userState createState() => _add_userState();
}

class _add_userState extends State<add_user> with TickerProviderStateMixin {
  final url1 = url.basicUrl;
  final token = url.token;
  bool _isloading = true;
  final imageurl = url.imageUrl;

  List userList = [];

  @override
  void initState() {
    super.initState();
    getuser();
  }

  Future<void> getuser() async {
    var url = "$url1/get-all-user";

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-all-user  " + responseJson.toString());
    setState(() {
      userList = responseJson["data"];
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: true,
        fontsize: medium,
        appbartext: "User list",
        colorImage: Swhite,
      ),
      body: _isloading == true
          ? SpinKitRipple(
        color: SLightBlue,
        controller: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1200)),
      )
          : Container(
        height: query.height,
        child: ListView.builder(
            itemCount: userList == null ? "" : userList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: query.width,
                  height: 80.sp,
                  decoration: BoxDecoration(
                      color: Swhite,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 1.5, color: kGray)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage(
                                image: NetworkImage(userList[index]["profile"]
                                            .toString() ==
                                        "null"
                                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
                                    : imageurl +
                                        userList[index]["profile"].toString()),
                                fit: BoxFit.fill,
                                width: 60.sp,
                                height: 60.sp,
                                placeholder:
                                    AssetImage("Assets/Images/giphy.gif"))),
                        Container(
                          width: 25.w,
                          child: Text(userList[index]["username"].toString(),
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SBlack,
                                  fontSize: medium)),
                        ),
                        FlatButton(

                          color: buttonColor,
                          onPressed: () async {
                            final ProgressDialog pr = _getProgress(context);
                            pr.update(
                                message: "Please wait...",
                                messageTextStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "SFPro",
                                    fontSize: medium));
                            pr.show();

                            var url = "$url1/add-group-member";

                            var map = new Map<String, dynamic>();
                            map["group_id"] = widget.groupId.toString();
                            map["user_id"] = userList[index]["id"].toString();

                            Map<String, String> headers = {"_token": token};


                            final response = await http.post(url, body:map, headers: headers);
                            final responseJson = json.decode(response.body);
                            print("res add-group-member  " + responseJson.toString());
                            if(responseJson["status"].toString()=="success"){
                              displayToast(responseJson["message"].toString());
                              pr.hide();
                            }

                          },
                          child: Text("Add in group",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: Swhite,
                                  fontSize: small)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
