import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Home/notification_page.dart';
import 'package:skicom/Home/topicDetail_page.dart';
import 'package:skicom/Tutorials/tutorials_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class homePage extends StatefulWidget {
  var level_id;

  homePage(this.level_id);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> with TickerProviderStateMixin{
  final controller = PageController(viewportFraction: 0.6, initialPage: 1);

  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  bool _isloading = true;
  List  topicData = [];
  List  categorie_data = [];

  String username="";
  @override
  void initState() {
    super.initState();
    gettopidata();
    getcategorydata();
  }

  Future<void> gettopidata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString("username").toString();
    var url = "$url1/get-topics";

    var map = new Map<String, dynamic>();
    map["level_id"] = widget.level_id.toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-topics  " + responseJson.toString());
    setState(() {
      topicData = responseJson["data"];
      _isloading = false;
    });
  }

  Future<void> getcategorydata() async {
    var url = "$url1/get-categories";

    var map = new Map<String, dynamic>();
    map["level_id"] = widget.level_id.toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-categories  " + responseJson.toString());
    setState(() {
      categorie_data = responseJson["data"];
      _isloading = false;
    });
  }

  Future<void> getdata() {
    gettopidata();
    getcategorydata();
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
          appbartext: "Hello, " +username.toString(),
          colorImage: Colors.transparent,
          fontsize: 15.sp,
          imageBack: false,
          widgets: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: notification_page()));
                  },
                  icon: Image.asset("Assets/Icons/noti.png", height: 15.sp)),
            )
          ],
        ),

        body: _isloading == true
            ? SpinKitRipple(
          color: SLightBlue,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        )
            : RefreshIndicator(
          onRefresh: getdata,
          color: buttonColor,
              child: SingleChildScrollView(
          child: Container(
              width: query.width,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Latest topic",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SBlack,
                                  fontSize: medium),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.of(context, rootNavigator: true).push(
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        alignment: Alignment.bottomCenter,
                                        duration: Duration(milliseconds: 300),
                                        child: tutorials_page(categorie_data,"back")));
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w600,
                                    color: SLightBlue,
                                    fontSize: medium),
                              ),
                            )
                          ],
                        ),
                      ),

                      topicData.length==0 ?
                      Container(height: query.height *0.38,
                        child: Center(
                        child: Text(
                          "No data",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SLightBlue,
                              fontSize: medium),
                        ),
                      ),) :Container(
                        height: query.height * 0.39,
                        child: PageView(
                          controller: controller,
                          reverse: false,
                          children: List.generate(
                              topicData.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context, rootNavigator: true)
                                                  .push(PageTransition(type: PageTransitionType.fade,
                                                      alignment: Alignment.bottomCenter,
                                                      duration: Duration(milliseconds: 300),
                                                      child: topicDetails_page(topicData[index]["id"])));
                                              print(topicData[index]["id"].toString());
                                            },
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15.0),
                                                    topLeft: Radius.circular(15.0)),
                                                child: FadeInImage(
                                                    image: NetworkImage(imageurl + topicData[index]["image"].toString()),
                                                    fit: BoxFit.fill,
                                                    width: query.width,
                                                    height: 130.sp,
                                                    placeholder: AssetImage(
                                                        "Assets/Images/giphy.gif"))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 8),
                                            child: Text(
                                              topicData[index]["title"].toString(),
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: medium),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5, left: 8, bottom: 5, top: 5),
                                            child: Text(topicData[index]["details"].toString(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w500,
                                                  color: SBlack,
                                                  fontSize: small),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      topicData.length==0 ? Container() :  Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SmoothPageIndicator(
                              controller: controller,
                              count: topicData.length,
                              effect: ExpandingDotsEffect(
                                  expansionFactor: 4,
                                  activeDotColor: SLightBlue,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categorie_data == null ? "" : categorie_data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        var controller1 = PageController(viewportFraction: 0.6, initialPage: 1);

                        return Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categorie_data[index]["detail"]["categories_name"].toString(),
                                style: TextStyle(
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w600,
                                    color: SBlack,
                                    fontSize: medium),
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context, rootNavigator: true).push(
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          alignment: Alignment.bottomCenter,
                                          duration: Duration(milliseconds: 300),
                                          child: tutorials_page(categorie_data,"back")));
                                },
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: SLightBlue,
                                      fontSize: medium),
                                ),
                              )
                            ],
                          ),
                        ),
                        categorie_data[index]["topics"].length == 0 ? Container(height: query.height *0.38,
                          child: Center(
                            child: Text(
                              "No data",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SLightBlue,
                                  fontSize: medium),
                            ),
                          ),) : Container(
                          height: query.height * 0.39,
                          child: PageView(
                            controller: controller1,
                            reverse: false,
                            children: List.generate(
                                categorie_data[index]["topics"].length, (index1) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true)
                                            .push(PageTransition(type: PageTransitionType.fade,
                                            alignment: Alignment.bottomCenter,
                                            duration: Duration(milliseconds: 300),
                                            child: topicDetails_page(categorie_data[index]["topics"][index1]["id"])));
                                        print(categorie_data[index]["topics"][index1]["id"].toString());
                                      },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              topLeft: Radius.circular(15.0)),
                                          child: FadeInImage(
                                              image: NetworkImage(imageurl +
                                                  categorie_data[index]["topics"][index1]["image"].toString()),
                                              fit: BoxFit.fill,
                                              width: query.width,
                                              height: 125.sp,
                                              placeholder: AssetImage(
                                                  "Assets/Images/giphy.gif"))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, left: 8),
                                      child: Text(
                                        categorie_data[index]["topics"][index1]["title"].toString(),
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w600,
                                            color: SBlack,
                                            fontSize: medium),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5, left: 8, bottom: 0, top: 0),
                                      child: Text(
                                        categorie_data[index]["topics"][index1]["details"].toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w500,
                                            color: SBlack,
                                            fontSize: small),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SmoothPageIndicator(
                                controller: controller1,
                                count: categorie_data[index]["topics"].length,
                                effect: ExpandingDotsEffect(
                                    expansionFactor: 4,
                                    activeDotColor: SLightBlue,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    spacing: 3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
          ),
        ),
            ),
      ),
    );
  }


}