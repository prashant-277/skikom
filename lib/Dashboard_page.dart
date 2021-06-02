import 'package:flutter/material.dart';
import 'package:skicom/Challenge/challenge_selection_page.dart';
import 'package:skicom/History/history_page.dart';
import 'package:skicom/Home/homePage.dart';
import 'package:skicom/Profile/profile_page.dart';
import 'package:skicom/Tutorials/tutorials_page.dart';
import 'package:skicom/constants.dart';

class dashboard_page extends StatefulWidget {
  @override
  _dashboard_pageState createState() => _dashboard_pageState();
}

class _dashboard_pageState extends State<dashboard_page> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Swhite,
      body: Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: new MaterialApp(
                debugShowCheckedModeBanner: false,
                home: homePage(),
              ),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: new MaterialApp(
                  debugShowCheckedModeBanner: false, home: challenge_page()),
            ),
          ),
          new Offstage(
            offstage: index != 2,
            child: new TickerMode(
              enabled: index == 2,
              child: new MaterialApp(
                  debugShowCheckedModeBanner: false, home: tutorials_page()),
            ),
          ),
          new Offstage(
            offstage: index != 3,

            child: new TickerMode(
              enabled: index == 3,
              child: new MaterialApp(
                  debugShowCheckedModeBanner: false, home: history_page()),
            ),
          ),
          new Offstage(

            offstage: index != 4,
            child: new TickerMode(
              enabled: index == 4,
              child: new MaterialApp(
                  debugShowCheckedModeBanner: false, home: profile_page()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        enableFeedback: false,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
            print(index);
          });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: IconButton(
              icon: Container(
                child: new Image.asset(
                  index == 0
                      ? 'Assets/Images/Home_active.png'
                      : "Assets/Images/Home.png",
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: SGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
              iconSize: 45,
              onPressed: null,
            ),
            title: new Text(
              "Home",
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: SBlack),
            ),
          ),
          new BottomNavigationBarItem(
            icon: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: SGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: new Image.asset(
                  index == 1
                      ? 'Assets/Images/challenge_active.png'
                      : "Assets/Images/challenge.png",
                ),
              ),
              onPressed: null,
              iconSize: 45,
            ),
            title: new Text(
              "Challenge",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w500,
                  color: SBlack),
            ),
          ),
          new BottomNavigationBarItem(
            icon: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: SGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: new Image.asset(
                  index == 2
                      ? 'Assets/Images/Tutorial_active.png'
                      : "Assets/Images/Tutorial.png",
                ),
              ),
              onPressed: null,
              iconSize: 45,
            ),
            title: new Text(
              "Tutorials",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w500,
                  color: SBlack),
            ),
          ),
          new BottomNavigationBarItem(
            icon: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: SGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: new Image.asset(
                  index == 3
                      ? 'Assets/Images/History_active.png'
                      : "Assets/Images/History.png",
                ),
              ),
              onPressed: null,
              iconSize: 45,
            ),
            title: new Text(
              "History",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w500,
                  color: SBlack),
            ),
          ),
          new BottomNavigationBarItem(
            icon: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: SGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: new Image.asset(
                  index == 4
                      ? 'Assets/Images/Profile_active.png'
                      : "Assets/Images/Profile.png",
                ),
              ),
              onPressed: null,
              iconSize: 45,
            ),
            title: new Text(
              "Profile",
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: SBlack),
            ),
          ),
        ],
      ),
    );
  }
}
