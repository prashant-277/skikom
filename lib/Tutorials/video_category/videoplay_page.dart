import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/constants.dart';

class videoplay_page extends StatefulWidget {
  @override
  _videoplay_pageState createState() => _videoplay_pageState();
}

class _videoplay_pageState extends State<videoplay_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: query.height,
          width: query.width,
          child: Column(
            children: [
              Container(
                height: query.height * 0.3,
                width: query.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Assets/Images/banner.png"),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "Assets/Icons/back.png",
                        height: query.height * 0.025,
                        color: Swhite,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: query.width / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "What is Lorem Ipsum?",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: SBlack,
                          height: 2.5,
                          fontSize: 20),
                    ),
                    Container(
                      width: query.width * 1.0,
                      child: Text(
                        "Custom Flutter widgets that makes Checkbox and Radio Buttons much cleaner and easier",
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w500,
                            color: SBlack,
                            height: 1.2,
                            fontSize: 16),
                      ),
                    ),
                    Text(
                      "4 hr ago",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SGray,
                          height: 1.5,
                          fontSize: 14),
                    ),
                    Text(
                      "Related videos",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: SBlack,
                          height: 2.5,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                height: query.height * 0.45,
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
                                height: query.height * 0.12,
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
                                            "Assets/Images/image_noti.png",
                                            height: query.height * 0.16,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          height: query.height * 0.12,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "What is Lorem Ipsum?",
                                                style: TextStyle(
                                                  height: 1.5,
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w600,
                                                    color: SBlack,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "20.05",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",height: 1.5,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: SBlack,
                                                    fontSize: 12),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
