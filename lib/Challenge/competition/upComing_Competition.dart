import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/competition/upComing_competition_Detail.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class upComing_Competition extends StatefulWidget {
  @override
  _upComing_CompetitionState createState() => _upComing_CompetitionState();
}

class _upComing_CompetitionState extends State<upComing_Competition> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: query.height,

      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: upComingCompetition_Detail()));
                    },
                    child: Container(
                      width: query.width,
                      height: 80.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: kGray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset(
                                  "Assets/Images/image_1.png",
                                  height: 60.sp,
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 35.sp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amanganilearn",
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: SBlack,
                                          fontSize: medium),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("Assets/Icons/km_away.png",height: query.height*0.022,),
                                        SizedBox(width: small,),
                                        Text(
                                          "12 km " +"away",
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w500,
                                              color: SBlack,
                                              fontSize: small),
                                        ),
                                      ],
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
                  SizedBox(height: 16)
                ],
              );
            }),
      ),
    );
  }
}
