import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';

import '../constants.dart';
import 'chalengeHistory_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class challenge_history extends StatefulWidget {
  @override
  _challenge_historyState createState() => _challenge_historyState();
}

class _challenge_historyState extends State<challenge_history>
    with TickerProviderStateMixin{
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  bool _isloading = true;
  List historyList = [];

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  Future<void> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-all-history";

    var map = new Map<String, dynamic>();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-all-history " + responseJson.toString());
    setState(() {
      historyList = responseJson["data"];
      _isloading = false;
      
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an app?',style: TextStyle(
            fontFamily: "SFPro",
            fontWeight: FontWeight.w600,
            color: SBlack,
            fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
        ],
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Swhite,
          appBar: commanAppBar(
            appBar: AppBar(),
            appbartext: "History",
            colorImage: Colors.transparent,
            fontsize: 18.sp,
            imageBack: false,

          ),
        body:Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child:_isloading == true
              ? SpinKitRipple(
            color: SLightBlue,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
          )
              : RefreshIndicator(
            onRefresh: getHistory,
            color: buttonColor,
                child: Container(
            child: historyList.toString()=="[]"? Container(
                  color: Swhite,
                  child: Center(
                      child: Text("No data found",style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium)))):
            ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: historyList==null?"":historyList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {

                              Navigator.of(context,rootNavigator: true).
                              push(new MaterialPageRoute(builder: (_)=>new
                              chalengeHistory_detail(jsonDecode(historyList[index]["detail"])
                                  ,historyList[index]["id"])))
                                  .then((val)=>getHistory());

                              /*Navigator.of(context, rootNavigator: true).push(
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.bottomCenter,
                                      duration: Duration(milliseconds: 300),
                                      child: chalengeHistory_detail(jsonDecode(historyList[index]["detail"])
                                          ,historyList[index]["group_id"])));*/
                            },
                            child: Container(
                              width: query.width,
                              height: 70.sp,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: kGray, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        child: FadeInImage(
                                            image: NetworkImage(historyList[index]["groupdetail"] == null ?
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"
                                                :imageurl +
                                                historyList[index]["groupdetail"]["group_image"].toString()),
                                            fit: BoxFit.fill,
                                            width: 60.sp,
                                            height: 60.sp,
                                            placeholder: AssetImage(
                                                "Assets/Images/giphy.gif"))),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(historyList[index]["title"].toString(),
                                              style: TextStyle(
                                                  height: 1.5,
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: medium),
                                            ),
                                            Text(
                                              "date : "+historyList[index]["date"].toString(),
                                              style: TextStyle(
                                                  fontFamily: "SFPro",height: 1.5,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: small),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14)
                        ],
                      ),
                    );
                  }),
          ),
              ),
        )
      ),
    );
  }
}
