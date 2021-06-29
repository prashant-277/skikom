import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/competition/competition_map.dart';
import 'package:skicom/Challenge/competition/startCompetition_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class competition_detail extends StatefulWidget {
  @override
  _competition_detailState createState() => _competition_detailState();
}

class _competition_detailState extends State<competition_detail> {
  @override
  Widget build(BuildContext context) {
    var quary = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Competition",
        colorImage: Swhite,
        imageBack: true,
        fontsize: medium,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          "Assets/Icons/pin_cir.png",
          width: quary.width,
          fit: BoxFit.fill,
        ),
        onPressed: (){
          Navigator.of(context, rootNavigator: true).push(
              PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  child: competition_map()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          height: quary.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "Assets/Images/banner.png",
                width: quary.width,
                height: 200.sp,
                fit: BoxFit.fill,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Venue : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "valdesqui",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Prize : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "100 points",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Date : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "12 Jan, 2021",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Time : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text("12:30 PM",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("GPS coordinates : ",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: medium)),
                        Text(
                          "N 48.11405˚ E 17.133055˚",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: medium),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Temperature : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "14˚ C",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Row(
                  children: [
                    Text("Weather : ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "Cloudy",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium)),
                    Text(
                      "If you are not using it in an AppBar you could wrap the TabBar.",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: SBlack,
                          fontSize: medium),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    width: quary.width,
                    height: 45.sp,
                    child: basicButton(Swhite, () {
                      Navigator.of(context, rootNavigator: true).pushReplacement(
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: startCompetition_page()));
                    }, "Start  Now!")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
