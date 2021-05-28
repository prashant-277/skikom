import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/competition/competition_detail.dart';
import 'package:skicom/constants.dart';

class onGoing_Competition extends StatefulWidget {

  @override
  _onGoing_CompetitionState createState() => _onGoing_CompetitionState();
}

class _onGoing_CompetitionState extends State<onGoing_Competition> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: query.height,
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.bottomCenter,
                            duration: Duration(milliseconds: 300),
                            child: competition_detail()));
                  },
                  child: Container(
                    color: Swhite,
                    width: query.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    "Assets/Images/image_1.png",
                                    height: query.height * 0.18,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: query.height * 0.17,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Competition name",
                                        style: TextStyle(
                                            fontFamily: "SFPro",
                                            fontWeight: FontWeight.w600,
                                            color: SBlack,
                                            fontSize: 18),
                                      ),
                                      Row(
                                        children: [
                                          Text("Venue : ",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: 14)),
                                          Text("valdesqui",
                                              style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w500,
                                              color: SBlack,
                                              fontSize: 14),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Prize : ",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: 14)),
                                          Text("100 points",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("From : ",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: 14)),
                                          Text("12 Jan, 2021",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Until : ",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w600,
                                                  color: SBlack,
                                                  fontSize: 13)),
                                          Text("14 Feb, 2021",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Track a maximum of Km during one day.",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SBlack,
                                  fontSize: 10),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            );
          }),
    );
  }
}
