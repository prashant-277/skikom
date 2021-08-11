import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Home/topicDetail_page.dart';
import 'package:skicom/Tutorials/topics_category/categoryDetails_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class topics_category extends StatefulWidget {
  var categorie_id;

  topics_category(this.categorie_id);

  @override
  _topics_categoryState createState() => _topics_categoryState();
}

class _topics_categoryState extends State<topics_category>
    with TickerProviderStateMixin {
  final imageurl = url.imageUrl;
  final url1 = url.basicUrl;
  final token = url.token;
  bool _isloading = true;
  List categorie_data = [];

  @override
  void initState() {
    super.initState();
    gettopicDetal();
    print(widget.categorie_id.toString());
  }

  Future<void> gettopicDetal() async {
    var url = "$url1/get-categories-base-topics";

    var map = new Map<String, dynamic>();
    map["categories_id"] = widget.categorie_id.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-topics-detail  " + responseJson.toString());
    setState(() {
      categorie_data = responseJson["data"];
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: gettopicDetal,
      color: buttonColor,
      child: Container(
        height: query.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: _isloading == true
              ? SpinKitRipple(
                  color: SLightBlue,
                  controller: AnimationController(
                      vsync: this, duration: const Duration(milliseconds: 1200)),
                )
              : categorie_data.toString()=="[]"?Container(
              color: Swhite,
              child: Center(
                  child: Text("No data found",style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w500,
                      color: SBlack,
                      fontSize: medium)))):
          ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: categorie_data == null ? "" : categorie_data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.bottomCenter,
                                      duration: Duration(milliseconds: 300),
                                      child: topicDetails_page(
                                          categorie_data[index]["id"])));
                            },
                            child: Container(
                              width: query.width,
                              height: 70.sp,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kGray, width: 1.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: FadeInImage(
                                            image: NetworkImage(imageurl +
                                                categorie_data[index]["image"]
                                                    .toString()),
                                            fit: BoxFit.fill,
                                            width: 70.sp,
                                            height: 70.sp,
                                            placeholder: AssetImage(
                                                "Assets/Images/giphy.gif"))),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              categorie_data[index]["title"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: medium),
                                            ),
                                            Container(
                                              width: query.width * 0.58,
                                              child: Text(
                                                categorie_data[index]["details"]
                                                    .toString(),
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small),
                                              ),
                                            ),
                                            Text(
                                              DateTime.now().difference(DateTime.tryParse(
                                                  categorie_data[index]["created_at"])).inHours <= 24 ?
                                              DateTime.now().difference(DateTime.tryParse(
                                                  categorie_data[index]["created_at"])).inHours.toString()+" hr ago" :
                                              DateTime.now().difference(DateTime.tryParse(
                                                  categorie_data[index]["created_at"])).inDays.toString()
                                                  +" days ago",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w500,
                                                  color: SGray,
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
    );
  }
}
