import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class saveActivity_page extends StatefulWidget {
  @override
  _saveActivity_pageState createState() => _saveActivity_pageState();
}

class _saveActivity_pageState extends State<saveActivity_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: SGray,
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: medium,
        imageBack: true,
        colorImage: Swhite,
        appbartext: "Save Activity",
        widgets: [IconbuttonG(() {}, "Assets/Icons/delete.png")],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          color: Swhite,
          child: Column(
            children: [
              Image.asset("Assets/Images/group_1430.png"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Distance",
                          style: TextStyle(
                              fontSize: small,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SGray),
                        ),
                        Divider(height: 5),
                        Text(
                          "4.31 km",
                          style: TextStyle(
                              fontSize: medium,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack),
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      color: kGray,
                      width: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          "Duration",
                          style: TextStyle(
                              fontSize: small,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SGray),
                        ),
                        Divider(height: 5),
                        Text(
                          "02:05:14",
                          style: TextStyle(
                              fontSize: medium,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack),
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      color: kGray,
                      width: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          "Speed",
                          style: TextStyle(
                              fontSize: small,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SGray),
                        ),
                        Divider(height: 5),
                        Text(
                          "8 km/h",
                          style: TextStyle(
                              fontSize: medium,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: kGray,
                width: query.width,
                height: 45.sp,
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
                                fontSize: medium)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Swhite,
                width: query.width,
                height: 40.sp,
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
                              fontSize: medium)),
                      /*Text("Please Enter title",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: 16)),*/
                      Container(
                        width: 150.sp,
                        child: TextField(
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: medium,
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
                height: 40.sp,
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
                              fontSize: medium)),
                      Text("Challenge",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w500,
                              color: SBlack,
                              fontSize: medium)),
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
                        height: 45.sp,
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
                          height: 45.sp,
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
