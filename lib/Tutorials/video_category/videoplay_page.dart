import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

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
                  padding: const EdgeInsets.only(top: 20.0, left: 00),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          "Assets/Icons/back.png",
                          height: 15.sp,
                          color: Swhite,
                        ),
                      )),
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
                          fontSize: medium),
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
                            fontSize: medium),
                      ),
                    ),
                    Text(
                      "4 hr ago",
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
                                            "Assets/Images/image_noti.png",
                                          )),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
