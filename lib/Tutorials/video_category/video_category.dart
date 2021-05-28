import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Tutorials/video_category/videoplay_page.dart';
import 'package:skicom/constants.dart';

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
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: videoplay_page()));
                    },
                    child: Container(
                      // height: query.height*0.46,
                      decoration: BoxDecoration(
                          border: Border.all(color: kGray, width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: query.height * 0.31,
                              width: query.width,
                              child: Stack(
                                children: [
                                  Container(
                                    width: query.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Assets/Images/banner.png")),
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
                            Container(
                              height: query.height * 0.12,
                              width: query.width,
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
                                        height: 1.5,
                                        fontSize: 15),
                                  ),
                                  Container(
                                    width: query.width * 0.8,
                                    child: Text(
                                      "Custom Flutter widgets that makes Checkbox and Radio Buttons much cleaner and easier",
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w500,
                                          color: SBlack,
                                          height: 1.2,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    "4 hr ago",
                                    style: TextStyle(
                                        fontFamily: "SFPro",
                                        fontWeight: FontWeight.w500,
                                        color: SGray,
                                        height: 1.5,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
