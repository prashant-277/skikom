import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/competition/onGoing_Competition.dart';
import 'package:skicom/Challenge/competition/upComing_Competition.dart';
import 'package:skicom/Challenge/leaderboard_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class competition_page extends StatefulWidget {
  @override
  _competition_pageState createState() => _competition_pageState();
}

class _competition_pageState extends State<competition_page> {
  int current_tab = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Competition",
        colorImage: Swhite,
        fontsize: 15,
        imageBack: true,
        widgets: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
            child: InkWell(
              onTap: (){
                Navigator.of(context, rootNavigator: true).push(
                    PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.bottomCenter,
                        duration: Duration(milliseconds: 300),
                        child: leaderboard_page()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Swhite, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("Leaderboard",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: Swhite,
                            fontSize: 15)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
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
                    color: current_tab == 0 ? SFacebook : kGray,
                    child: Tab(
                        child: Text("Ongoing",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: current_tab == 0 ? Swhite : SBlack,
                                fontSize: 15))),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    width: query.width,
                    color: current_tab == 1 ? SFacebook : kGray,
                    child: Tab(
                        child: Text("Upcoming",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: current_tab == 1 ? Swhite : SBlack,
                                fontSize: 15))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(child: onGoing_Competition(),color: kGray),
                  Container(child: upComing_Competition(),color: Swhite)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
