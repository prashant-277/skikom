import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

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
        fontsize: 20,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: query.height / 1.35,
          //   width: query.width,
          child: ListView(
            children: [
              SizedBox(height: 15),
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
                    height: query.height * 0.18,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Icons/green_tuto.png"))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Category 1",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 22),
                        ),
                        Text(""),
                      ],
                    )),
              ),
              SizedBox(height: 20),
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
                    width: query.width,
                    height: query.height * 0.18,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "Assets/Icons/light_blue_tuto.png"))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Category 2",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 22),
                        ),
                        Text(""),
                      ],
                    )),
              ),
              SizedBox(height: 20),
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
                    width: query.width,
                    height: query.height * 0.18,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Icons/yellow_tuto.png"))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Category 3",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 22),
                        ),
                        Text(""),
                      ],
                    )),
              ),
              SizedBox(height: 20),
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
                    width: query.width,
                    height: query.height * 0.18,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Icons/pink_tuto.png"))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Category 4",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 22),
                        ),
                        Text(""),
                      ],
                    )),
              ),
              SizedBox(height: 20),
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
                    width: query.width,
                    height: query.height * 0.18,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Icons/orange_tuto.png"))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Category 5",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: Swhite,
                              fontSize: 22),
                        ),
                        Text(""),
                      ],
                    )),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
