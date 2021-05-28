import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';

import '../leaderboard_page.dart';

class saveChallenge_page extends StatefulWidget {
  @override
  _saveChallenge_pageState createState() => _saveChallenge_pageState();
}

class _saveChallenge_pageState extends State<saveChallenge_page> {
  double sliderValue = 500.0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGray,
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: 15,
        imageBack: true,
        colorImage: Swhite,
        appbartext: "Result",
        widgets: [IconbuttonG(() {}, "Assets/Icons/delete.png")],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          color: Swhite,
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: query.height * 0.48,
                width: query.width,
                child: ListView.builder(
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.asset(
                                        "Assets/Images/image_1.png",
                                        // height: query.height * 0.2,
                                      )),
                                ),
                                SizedBox(width: 15),
                                SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Container(
                                    //   height: query.height * 0.15,
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
                                            Text("848 km",
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
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius: 2.0,
                                                        elevation: 0),
                                                showValueIndicator:
                                                    ShowValueIndicator.always,
                                                valueIndicatorShape:
                                                    PaddleSliderValueIndicatorShape(),
                                                trackShape: CustomTrackShape(),
                                                overlayColor:
                                                    Colors.transparent),
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
                                        Text("")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: kGray,
                            thickness: 1,
                          )
                        ],
                      );
                    }),
              ),
              Container(
                color: kGray,
                width: query.width,
                height: query.height * 0.08,
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Custom save",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SBlack,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Swhite,
                width: query.width,
                height: query.height * 0.06,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Title : ",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: 16)),
                      /*Text("Please Enter title",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: 16)),*/
                      Container(
                        width: query.width * 0.31,
                        child: TextField(
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Please enter title",
                            hintStyle: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SGray),
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                color: Swhite,
                width: query.width,
                height: query.height * 0.06,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Save as : ",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: 16)),
                      Text("Challenge",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Container(
                width: query.width,
                height: query.height * 0.20,
                color: SGray,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: query.width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: SBlack, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.transparent,
                          child: Text(
                            "Share with friends",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                          width: query.width / 1.2,
                          child: basicButton(Swhite, () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, "Save"))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
