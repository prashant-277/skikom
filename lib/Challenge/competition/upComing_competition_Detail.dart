import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class upComingCompetition_Detail extends StatefulWidget {
  @override
  _upComingCompetition_DetailState createState() =>
      _upComingCompetition_DetailState();
}

class _upComingCompetition_DetailState
    extends State<upComingCompetition_Detail> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Vanue Name",
        colorImage: Swhite,
        imageBack: true,
        fontsize: 15,
      ),
      body: Container(
        color: kGray,
        height: query.height,
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    color: Swhite,
                    width: query.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          Text(
                                            "valdesqui",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),
                                          )
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
                                          Text(
                                            "100 points",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),
                                          )
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
                                          Text(
                                            "12 Jan, 2021",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),
                                          )
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
                                          Text(
                                            "14 Feb, 2021",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: 14),
                                          )
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
                            child: Text(
                              "Track a maximum of Km during one day.",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: SBlack,
                                  fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
