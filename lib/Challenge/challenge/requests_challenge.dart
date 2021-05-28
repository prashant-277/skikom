import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/challenge/startChallenge_page.dart';

import '../../constants.dart';

class requests_challenge extends StatefulWidget {

  @override
  _requests_challengeState createState() => _requests_challengeState();
}

class _requests_challengeState extends State<requests_challenge> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: query.height,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: query.width,
                decoration: BoxDecoration(
                    color: Swhite,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.5, color: kGray)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "Assets/Images/2.png",
                            height: query.height * 0.09,
                          )),

                      Text("Michelbr",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: 13)),

                      Text("10 km skiing",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: 10)),

                      InkWell(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).push(
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.bottomCenter,
                                  duration: Duration(milliseconds: 300),
                                  child: startChallenge()));
                        },
                        child: Container(
                          width: query.width,
                          height: query.height*0.04,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Center(
                              child: Text("Accept",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: Swhite,
                                      fontSize: 12)),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: query.width,
                        height: query.height*0.04,
                        decoration: BoxDecoration(
                            color: SRed,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Center(
                            child: Text("Decline",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w600,
                                    color: Swhite,
                                    fontSize: 12)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
