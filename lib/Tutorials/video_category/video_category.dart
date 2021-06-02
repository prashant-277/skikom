import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Tutorials/video_category/videoplay_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class video_category extends StatefulWidget {
  @override
  _video_categoryState createState() => _video_categoryState();
}

class _video_categoryState extends State<video_category> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Swhite,
        body: ListView.builder(
            itemCount: 8,
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
                              child: videoplay_page()));
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
                                  child: Container(
                                    width: query.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Assets/Images/banner.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "Assets/Icons/play.png",
                                      height: query.height * 0.08,
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
                                  Text(
                                    "What is Lorem Ipsum?",
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w600,
                                        color: SBlack,
                                        fontSize: medium),
                                  ),
                                  Container(
                                    width: query.width * 0.9,
                                    child: Text(
                                      "Custom Flutter widgets that makes Checkbox and Radio Buttons much cleaner and easier",
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
                                    "4 hr ago",
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
