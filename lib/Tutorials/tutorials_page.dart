import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'category_page.dart';

class tutorials_page extends StatefulWidget {
  @override
  _tutorials_pageState createState() => _tutorials_pageState();
}

class _tutorials_pageState extends State<tutorials_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: false,
        appbartext: "Tutorials",
        colorImage: Colors.transparent,
        fontsize: 18.sp,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: query.height / 1.3,
          width: query.width / 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: [
                SizedBox(height: 15.sp),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: category_page()));
                  },
                  child: Container(
                      height: 100.sp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Assets/Icons/green_tuto.png"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            "Category 1",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.sp),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: category_page()));
                  },
                  child: Container(
                      height: 100.sp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("Assets/Icons/light_blue_tuto.png"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            "Category 2",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.sp),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: category_page()));
                  },
                  child: Container(
                      height: 100.sp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("Assets/Icons/yellow_tuto.png"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            "Category 3",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.sp),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: category_page()));
                  },
                  child: Container(
                      height: 100.sp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("Assets/Icons/pink_tuto.png"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            "Category 4",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10.sp),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: category_page()));
                  },
                  child: Container(
                      height: 100.sp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("Assets/Icons/orange_tuto.png"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40),
                          Text(
                            "Category 5",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: Swhite,
                                fontSize: 18.sp),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 25.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
