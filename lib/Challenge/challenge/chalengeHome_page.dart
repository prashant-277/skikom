import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skicom/Challenge/challenge/friends_challenge.dart';
import 'package:skicom/Challenge/challenge/requests_challenge.dart';
import 'package:skicom/Challenge/competition/onGoing_Competition.dart';
import 'package:skicom/Challenge/competition/upComing_Competition.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class challengeHome_page extends StatefulWidget {
  var group_id;

  var groupName;

  challengeHome_page(this.group_id, this.groupName);



  @override
  _challengeHome_pageState createState() => _challengeHome_pageState();
}

class _challengeHome_pageState extends State<challengeHome_page> {

  int current_tab = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: medium,
        imageBack: true,
        colorImage: Swhite,
        appbartext: widget.groupName,
        widgets: [
          /*FlatButton(
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
                  SizedBox(width: 8),
                  Image.asset("Assets/Icons/search.png",height: 15,)
                ],
              ))*/
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
                  color: current_tab == 0 ? kGray : Swhite,
                  child: Tab(
                      child: Text("Friends",
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
                      child: Text("Requests",
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
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(child: friends_challenge(widget.group_id),color: Swhite),
                Container(child: requests_challenge(widget.group_id,),color: Swhite)
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
