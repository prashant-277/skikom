import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Profile/add_user.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'groupMemberDialog.dart';
import 'package:http/http.dart' as http;

class groupMemberPage extends StatefulWidget {
  var groupList;

  var name;

  groupMemberPage(this.groupList, this.name);


  @override
  _groupMemberPageState createState() => _groupMemberPageState();
}

class _groupMemberPageState extends State<groupMemberPage> with TickerProviderStateMixin{
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
    map["group_id"] = widget.groupList.toString();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-group-all-member  " + responseJson.toString());
    setState(() {
      memberList = responseJson["data"];
      _isloading = false;
      isAdmin = responseJson["0"]["is_admin"].toString();
      print(isAdmin);
    });
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        appBar: commanAppBar(
          appBar: AppBar(),
          colorImage: Swhite,
          appbartext: widget.name,
          fontsize: medium,
          imageBack: true,
          widgets: [
            /*FlatButton(
                highlightColor: Colors.transparent,
                color: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
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
                ))*/
          ],
        ),
        body: _isloading == true
            ? SpinKitRipple(
          color: SLightBlue,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        )
            : Container(
          height: query.height,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemCount: memberList==null ?"":memberList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
                                    "Assets/Images/giphy.gif"))
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(memberList[index]["userdetail"]["username"].toString(),
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SBlack,
                                  fontSize: medium)),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        memberList[index]["is_admin"].toString()=="1" ?
                        Container(
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
                        ):InkWell(
                          onTap: (){
                            isAdmin=="true"?
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                    contentPadding: EdgeInsets.only(
                                        left: 0, right: 0, bottom: 15, top: 0),
                                    backgroundColor: Swhite,
                                    content: groupMemberDialog(memberList[index]["user_id"],widget.groupList)))
                                .then((value) => getGroupMember()):displayToast("Only admin can give challenge");
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
        ),


    floatingActionButton: isAdmin== "true" ? FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.add),
        backgroundColor: SBlue,
        onPressed: (){
          Navigator.of(context,rootNavigator: true).
          push(new MaterialPageRoute(builder: (_)=>new add_user(widget.groupList)),)
              .then((val)=>getGroupMember());
        }
    ):Container(),
    );
  }
}
