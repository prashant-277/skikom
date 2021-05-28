import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class competitonHistory_detail extends StatefulWidget {
  @override
  _competitonHistory_detailState createState() =>
      _competitonHistory_detailState();
}

class _competitonHistory_detailState extends State<competitonHistory_detail> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGray,
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: 15,
        colorImage: Swhite,
        appbartext: "Competition name",
        imageBack: true,
        widgets: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("Assets/Icons/delete.png",
                  height: query.height * 0.025),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          child: Column(
            children: [
              Image.asset("Assets/Images/group_1430.png"),
              Container(
                width: query.width,
                color: Swhite,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Distance",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SGray),
                          ),
                          Divider(height: 5),
                          Text(
                            "4.31 km",
                            style: TextStyle(
                                fontSize: 20,
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
                                fontSize: 14,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SGray),
                          ),
                          Divider(height: 5),
                          Text(
                            "02:05:14",
                            style: TextStyle(
                                fontSize: 20,
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
                                fontSize: 14,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w500,
                                color: SGray),
                          ),
                          Divider(height: 5),
                          Text(
                            "8 km/h",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset("Assets/Images/sharewith.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("Assets/Images/google_rd.png",
                        height: query.height * 0.11),
                    Image.asset("Assets/Images/fb_rd.png",
                        height: query.height * 0.11),
                    Image.asset("Assets/Images/insta_rd.png",
                        height: query.height * 0.11),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
