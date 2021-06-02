import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

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
        backgroundColor: SGray,
        appBar: commanAppBar(
          appBar: AppBar(),
          appbartext: "Vanue Name",
          colorImage: Swhite,
          imageBack: true,
          fontsize: medium,
        ),
        body: Container(
            height: query.height,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 10.sp),
                      Container(
                        color: Swhite,
                        width: query.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        height: 80.sp,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 75.sp,
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
                                                fontSize: medium),
                                          ),
                                          Row(
                                            children: [
                                              Text("Venue : ",
                                                  style: TextStyle(
                                                      fontFamily: "SFPro",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: SBlack,
                                                      fontSize: small)),
                                              Text(
                                                "valdesqui",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Prize : ",
                                                  style: TextStyle(
                                                      fontFamily: "SFPro",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: SBlack,
                                                      fontSize: small)),
                                              Text(
                                                "100 points",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("From : ",
                                                  style: TextStyle(
                                                      fontFamily: "SFPro",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: SBlack,
                                                      fontSize: small)),
                                              Text(
                                                "12 Jan, 2021",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Until : ",
                                                  style: TextStyle(
                                                      fontFamily: "SFPro",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: SBlack,
                                                      fontSize: small)),
                                              Text(
                                                "14 Feb, 2021",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: small),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  "Track a maximum of Km during one day.",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                })));
  }
}
