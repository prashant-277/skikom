import 'package:flutter/material.dart';
import 'package:skicom/Challenge/leaderboard_page.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';

class chalengeHistory_detail extends StatefulWidget {
  @override
  _chalengeHistory_detailState createState() => _chalengeHistory_detailState();
}

class _chalengeHistory_detailState extends State<chalengeHistory_detail> {
  double sliderValue = 500.0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          height: query.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: query.height / 2.7,
                  width: query.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/map.png"),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset("Assets/Icons/back.png", height: 15,color: Swhite,),
                      ),
                    ),
                  )),
              Container(
                height: query.height * 0.2,
                width: query.width,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Swhite,
                            width: query.width,
                            height: query.height * 0.10,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text((index + 1).toString(),
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: SBlack,
                                          fontSize: 18)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100.0),
                                      child: Image.asset(
                                        "Assets/Images/image_1.png",
                                        // height: query.height * 0.2,
                                      )),
                                ),
                                SizedBox(width: 15),
                                SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Container(
                                    color: Swhite,
                                    width: query.width / 1.7,
                                    child: Column(
                                      children: [
                                        Text(""),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Michelbr",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w600,
                                                    color: SBlack,
                                                    fontSize: 15)),
                                            Text("01:25:45",
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 3.5,
                                                thumbShape: RoundSliderThumbShape(
                                                    enabledThumbRadius: 2.0,
                                                    elevation: 0),
                                                showValueIndicator:
                                                    ShowValueIndicator.always,
                                                valueIndicatorShape:
                                                    PaddleSliderValueIndicatorShape(),
                                                trackShape: CustomTrackShape(),
                                                overlayColor: Colors.transparent),
                                            child: Container(
                                              width: query.width * 0.9,
                                              child: Slider(
                                                  value: sliderValue.toDouble(),
                                                  min: 1,
                                                  max: 1000,
                                                  divisions: 1000,
                                                  activeColor: SBlue,
                                                  inactiveColor: kGray,
                                                  onChanged: (double newValue) {
                                                    /*setState(() {
                                                                sliderValue = newValue.round();
                                                              });*/
                                                  },
                                                  semanticFormatterCallback:
                                                      (double newValue) {
                                                    return '${newValue.round()}';
                                                  }),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: query.width,
                            color: kGray,
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: query.width,
                height: query.height / 4.0,
                color: Swhite,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 15),
                        child: Image.asset("Assets/Images/sharewith.png"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("Assets/Images/google_rd.png",
                              height: query.height * 0.10),
                          Image.asset("Assets/Images/fb_rd.png",
                              height: query.height * 0.10),
                          Image.asset("Assets/Images/insta_rd.png",
                              height: query.height * 0.10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20 ),
                child: Container(
                  width: query.width,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: SRed,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: Swhite),
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
