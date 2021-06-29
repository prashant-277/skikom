import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Tutorials/video_category/videoplay_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http ;
class video_category extends StatefulWidget {
  var categorie_id;

  video_category(this.categorie_id);

  @override
  _video_categoryState createState() => _video_categoryState();
}

class _video_categoryState extends State<video_category>with TickerProviderStateMixin {
  final imageurl = url.imageUrl;
  final url1 = url.basicUrl;
  final token = url.token;
  bool _isloading = true;
  List video_data = [];
  DateTime before,after;

  @override
  void initState() {
    super.initState();
    getvideoDetal();
    print(widget.categorie_id.toString());

  }

  Future<void> getvideoDetal() async {
    var url = "$url1/get-video";

    var map = new Map<String, dynamic>();
    map["categories_id"] = widget.categorie_id.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-video  " + responseJson.toString());
    setState(() {
      video_data = responseJson["data"];
      _isloading = false;

    });



    print(after.difference(before).inHours);
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Swhite,
        body: _isloading == true
            ? SpinKitRipple(
          color: SLightBlue,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        )
            : video_data.toString()=="[]"?Container(
            color: Swhite,
            child: Center(
                child: Text("No data found",style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w500,
                    color: SBlack,
                    fontSize: medium)))):
        ListView.builder(
            itemCount: video_data ==null?"":video_data.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: videoplay_page(video_data[index]["id"])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kGray, width: 1),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: query.height * 0.25,
                            width: query.width,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: FadeInImage(
                                          image: NetworkImage(imageurl +
                                              video_data[index]["image"].toString()),
                                          fit: BoxFit.fill,
                                          width: query.width,
                                          placeholder: AssetImage(
                                              "Assets/Images/giphy.gif"))),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "Assets/Icons/play.png",
                                      height: query.height * 0.08,
                                      color: Swhite,
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              width: query.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(video_data[index]["title"].toString(),
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w600,
                                        color: SBlack,
                                        fontSize: medium),
                                  ),
                                  Container(
                                    width: query.width * 0.9,
                                    child: Text(
                                      video_data[index]["details"].toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w500,
                                          color: SBlack,
                                          height: 1.2,
                                          fontSize: small),
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().difference(DateTime.tryParse
                                      (video_data[index]["created_at"])).inHours.toString()
                                        +" hr ago",
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w500,
                                        color: SGray,
                                        height: 1.5,
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
              );
            }));
  }
}
