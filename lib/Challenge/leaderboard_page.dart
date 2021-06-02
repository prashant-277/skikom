import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class leaderboard_page extends StatefulWidget {
  @override
  _leaderboard_pageState createState() => _leaderboard_pageState();
}

class _leaderboard_pageState extends State<leaderboard_page> {

  double sliderValue = 500.0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: medium,
        imageBack: true,
        colorImage: Swhite,
        appbartext: "Leaderboard",
      ),
      body: Column(
        children: [
          Container(
            color: kGray,
            width: query.width,
            height: 40.sp,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Your position",
                      style: TextStyle(
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: medium)),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            color: Swhite,
            width: query.width,
            height: query.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset("Assets/Images/image_1.png")),
                SizedBox(width: 25),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your position",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: medium)),
                      Text("Not ranked",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: small)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            color: kGray,
            width: query.width,
            height: 40.sp,
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text("Leaderboard",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            fontSize: medium)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: query.height * 0.59,
            width: query.width,
            child: ListView.builder(
                itemCount: 10,
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
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text((index + 1).toString(),
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium)),
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
                           //   height: query.height * 0.15,
                                width: query.width / 1.7,
                                child: Column(
                                  children: [
                                    Text(""),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Michelbr",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: SBlack,
                                                fontSize: medium)),
                                        Text("848 km",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SBlack,
                                                fontSize: small)),
                                      ],
                                    ),
                                    SliderTheme(
                                        data: SliderThemeData(
                                            trackHeight: 3.5,
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 2.0,
                                                elevation: 0),
                                            showValueIndicator: ShowValueIndicator.always,
                                            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                            trackShape: CustomTrackShape(),
                                            overlayColor: Colors.transparent),
                                        child: Container(
                                          width: query.width*0.9,
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
                                              semanticFormatterCallback: (double newValue) {
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
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,

    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 3.8;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
