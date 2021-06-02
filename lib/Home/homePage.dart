import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Home/notification_page.dart';
import 'package:skicom/Home/topicDetail_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final controller = PageController(viewportFraction: 0.6, initialPage: 1);
  final controller1 = PageController(viewportFraction: 0.6, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Hello William,",
        colorImage: Colors.transparent,
        fontsize: 18.sp,
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
      body: SingleChildScrollView(
        child: Container(
          height: query.height,
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
                        Text(
                          "See all",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SLightBlue,
                              fontSize: medium),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: query.height * 0.40,
                    child: PageView(
                      controller: controller,
                      reverse: false,
                      children: List.generate(
                          3,
                          (_) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5),
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
                                                  child: topicDetails_page()));
                                        },
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                topLeft: Radius.circular(15.0)),
                                            child: Image.asset(
                                              "Assets/Images/img1.png",
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, left: 8),
                                        child: Text(
                                          "What is ipsum?",
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w600,
                                              color: SBlack,
                                              fontSize: medium),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5, left: 8, bottom: 5, top: 5),
                                        child: Text("Customizable animated page indicator with a set...",
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
                          controller: controller,
                          count: 3,
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
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category 1",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: medium),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SLightBlue,
                              fontSize: medium),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: query.height * 0.40,
                    child: PageView(
                      controller: controller1,
                      reverse: false,
                      children: List.generate(
                          3, (_) => Padding(
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
                                                  child: topicDetails_page()));
                                        },
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                topLeft: Radius.circular(15.0)),
                                            child: Image.asset(
                                              "Assets/Images/img1.png",
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, left: 8),
                                        child: Text(
                                          "What is ipsum?",
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w600,
                                              color: SBlack,
                                              fontSize: medium),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5, left: 8, bottom: 5, top: 5),
                                        child: Text(
                                          "Customizable animated page indicator with a set...",
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
                          count: 3,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}