import 'package:flutter/material.dart';
import 'package:skicom/History/challenge_history.dart';
import 'package:skicom/History/competition_history.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class history_page extends StatefulWidget {

  @override
  _history_pageState createState() => _history_pageState();
}

class _history_pageState extends State<history_page> {
  int current_tab = 1;
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an app?',style: TextStyle(
            fontFamily: "SFPro",
            fontWeight: FontWeight.w600,
            color: SBlack,
            fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
        ],
      ),
    ) ;
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Swhite,
        appBar: commanAppBar(
          appBar: AppBar(),
          appbartext: "History",
          colorImage: Colors.transparent,
          fontsize: 18.sp,
          imageBack: false,

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
                        child: Text("Competition",
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
                        child: Text("Challenge",
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
                  Container(child: competition_history(),color: Swhite),
                  Container(child: challenge_history(),color: Swhite)
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
