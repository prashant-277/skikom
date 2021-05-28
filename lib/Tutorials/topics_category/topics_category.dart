import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Home/topicDetail_page.dart';
import 'package:skicom/Tutorials/topics_category/categoryDetails_page.dart';
import 'package:skicom/constants.dart';

class topics_category extends StatefulWidget {
  @override
  _topics_categoryState createState() => _topics_categoryState();
}

class _topics_categoryState extends State<topics_category> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: query.height,
      child: Padding(
        padding: const EdgeInsets.only(top:15.0),
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    InkWell(

                      onTap: (){
                        Navigator.of(context, rootNavigator: true).push(
                            PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.bottomCenter,
                                duration: Duration(milliseconds: 300),
                                child: categoryDetails_page()));
                      },
                      child: Container(
                        width: query.width,
                        height: query.height * 0.12,
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
                                  child: Image.asset(
                                    "Assets/Images/image_noti.png",
                                    height: query.height * 0.16,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: query.height * 0.12,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "What is Lorem Ipsum?",
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w600,
                                            color: SBlack,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        width: query.width * 0.58,
                                        child: Text(
                                          "You can support the library by liking it on pub...",
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w500,
                                              color: SBlack,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        "4 hr ago",
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w500,
                                            color: SGray,
                                            fontSize: 10),
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
    );
  }
}
