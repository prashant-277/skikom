import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Tutorials/topics_category/topics_category.dart';
import 'package:skicom/Tutorials/video_category/video_category.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class category_page extends StatefulWidget {

  @override
  _category_pageState createState() => _category_pageState();
}

class _category_pageState extends State<category_page> {
  int current_tab = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Category 1",
        colorImage: Swhite,
        fontsize: medium,
        imageBack: true,
        widgets: [
          FlatButton(
              highlightColor: Colors.transparent,
              color: Colors.transparent,
              splashColor: Colors.transparent,

              onPressed: () {},
              child: Row(
                children: [
                  Text("Search",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: Swhite,
                          fontSize: medium)),
                  SizedBox(width: 10.sp),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset("Assets/Icons/search.png",height: medium,),
                  )
                ],
              ))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              height: 35.sp,
              color: SGray,
              child: TabBar(
                automaticIndicatorColorAdjustment: true,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                indicatorWeight: 0.1,
                onTap: (page) {
                  print(page);
                  setState(() {
                    current_tab = page;
                  });
                },
                tabs: [
                  Container(
                    padding: EdgeInsets.zero,
                    width: query.width,
                    color: current_tab == 0 ? kGray : Swhite,
                    child: Tab(
                        child: Text("Topics",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: small))),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    width: query.width,
                    color: current_tab == 1 ? kGray : Swhite,
                    child: Tab(
                        child: Text("Video",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: small))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(child: topics_category(),color: Swhite),
                  Container(child: video_category(),color: Swhite)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
