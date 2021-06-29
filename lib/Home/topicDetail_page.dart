import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:skicom/url.dart';

class topicDetails_page extends StatefulWidget {
  var articleId;

  topicDetails_page(this.articleId);

  @override
  _topicDetails_pageState createState() => _topicDetails_pageState();
}

class _topicDetails_pageState extends State<topicDetails_page>
    with TickerProviderStateMixin {
  final url1 = url.basicUrl;
  final token = url.token;
  final imageurl = url.imageUrl;
  List detailData = [];
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    var url = "$url1/get-topics-detail";

    Map<String, String> headers = {"_token": token};

    var map = new Map<String, dynamic>();
    map["id"] = widget.articleId.toString();

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("get-topics-detail " + responseJson.toString());
    setState(() {
      _isloading = false;
      detailData = responseJson["data"];
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
        colorImage: Swhite,
        appbartext: "Back",
      ),
      body: Container(
        height: query.height,
        width: query.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _isloading == true
              ? SpinKitRipple(
                  color: SLightBlue,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200)),
                )
              : ListView(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: FadeInImage(
                            image: NetworkImage(
                                imageurl + detailData[0]["image"].toString()),
                            fit: BoxFit.fill,
                            width: query.width,
                            placeholder:
                                AssetImage("Assets/Images/giphy.gif"))),
                    SizedBox(height: 10),
                    Text(
                      detailData[0]["title"].toString(),
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w700,
                          color: SBlack,
                          fontSize: 18.sp),
                    ),
                    SizedBox(height: 10),
                    Text(
                      detailData[0]["details"].toString(),
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          height: 1.4,
                          fontSize: medium),
                    ),
                    SizedBox(height: 10),
                    Image.asset("Assets/Images/sharewith.png",height: 20.sp,),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("Assets/Images/google_rd.png",
                              height: 60.sp),
                          Image.asset("Assets/Images/fb_rd.png", height: 60.sp),
                          Image.asset("Assets/Images/insta_rd.png",
                              height: 60.sp),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
