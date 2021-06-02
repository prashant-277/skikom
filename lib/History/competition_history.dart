import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/History/competitonHistory_detail.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class competition_history extends StatefulWidget {

  @override
  _competition_historyState createState() => _competition_historyState();
}

class _competition_historyState extends State<competition_history> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Swhite,
        body:Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Container(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 300),
                                    child: competitonHistory_detail()));
                          },
                          child: Container(
                            width: query.width,
                            height: 70.sp,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: kGray, width: 1.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        "Assets/Images/image_noti.png",
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: query.height * 0.12,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Competition name",
                                            style: TextStyle(
                                                height: 1.5,
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: SBlack,
                                                fontSize: medium),
                                          ),
                                          Text(
                                            "date : 14 Feb, 2021",
                                            style: TextStyle(
                                                fontFamily: "SFPro",height: 1.5,
                                                fontWeight:
                                                FontWeight.w600,
                                                color: SBlack,
                                                fontSize: small),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14)
                      ],
                    ),
                  );
                }),
          ),
        )
    );
  }
}
