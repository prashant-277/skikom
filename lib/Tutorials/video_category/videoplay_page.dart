import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class videoplay_page extends StatefulWidget {
  var id;

  videoplay_page(this.id);

  @override
  _videoplay_pageState createState() => _videoplay_pageState();
}

class _videoplay_pageState extends State<videoplay_page>  with TickerProviderStateMixin{
  final imageurl = url.imageUrl;
  final url1 = url.basicUrl;
  final token = url.token;
  bool _isloading = true;
  List video_data = [];
  VideoPlayerController _controller;
  DateTime before,after;

  @override
  void initState() {
    super.initState();
    getvideoDetal();
    print(widget.id.toString());
  }

  Future<void> getvideoDetal() async {
    var url = "$url1/get-video-detail";

    var map = new Map<String, dynamic>();
    map["id"] = widget.id.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-video-detail  " + responseJson.toString());
    setState(() {
      video_data = responseJson["data"];
      _isloading = false;
      before = DateTime.tryParse(video_data[0]["created_at"]);
      after = DateTime.now();

    });
    if (responseJson["status"].toString() == "success") {
      _controller = VideoPlayerController.network(
          imageurl+video_data[0]["video"].toString())
        ..initialize().then((_) {
          setState(() {_controller.play();});

        });
    }
  }


  @override
    Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: _isloading == true
            ? Container(
          height: query.height,
              child: SpinKitRipple(
          color: SLightBlue,
          controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
            )
            :  Container(
          height: query.height,
          width: query.width,
          child: Column(
            children: [

              Container(
                width: query.width,
                height: query.height*0.35,
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),

              ),

              Container(
                width: query.width / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      video_data[0]["title"].toString(),
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: SBlack,
                          height: 2.5,
                          fontSize: medium),
                    ),
                    Container(
                      width: query.width * 1.0,
                      child: Text(
                        video_data[0]["details"].toString(),
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w500,
                            color: SBlack,
                            height: 1.2,
                            fontSize: medium),
                      ),
                    ),
                    Text(
                      after.difference(before).inHours.toString() +" hr ago",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SGray,
                          height: 1.5,
                          fontSize: small),
                    ),
                    Text(
                      "Related videos",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: SBlack,
                          height: 2.5,
                          fontSize: medium),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: query.height * 0.34,
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: query.width,
                                  height: 80.sp,
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
                                            child: Image.asset(
                                                "Assets/Images/image_noti.png")),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: query.height * 0.12,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "What is Lorem Ipsum?",
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      fontFamily: "SFPro",
                                                      fontWeight: FontWeight.w600,
                                                      color: SBlack,
                                                      fontSize: medium),
                                                ),
                                                Text(
                                                  "20.05",
                                                  style: TextStyle(
                                                      fontFamily: "SFPro",
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w600,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
