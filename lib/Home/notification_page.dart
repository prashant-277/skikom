import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class notification_page extends StatefulWidget {
  @override
  _notification_pageState createState() => _notification_pageState();
}

class _notification_pageState extends State<notification_page> {
  bool noti_switch = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        appbartext: "Notification",
        colorImage: Swhite,
        fontsize: medium,
        imageBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: query.width,
                decoration: BoxDecoration(
                    border: Border.all(color: kGray, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Push notification",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.w600,
                            color: SBlack,
                            fontSize: medium),
                      ),
                      Container(
                        child: CupertinoSwitch(
                            value: noti_switch,
                            activeColor: Sgreen,
                            onChanged: (value) {
                              setState(() {
                                noti_switch = value;
                              });
                            }),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: query.height,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: query.width,
                            height: 80.sp,
                            decoration: BoxDecoration(
                                border: Border.all(color: SGray, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        "Assets/Images/image_noti.png",
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Main title",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: SBlack,
                                                fontSize: medium),
                                          ),
                                          Container(
                                            width: query.width * 0.58,
                                            child: Text(
                                              "You can support the library by liking it on pub...",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w500,
                                                  color: SBlack,
                                                  fontSize: small),
                                            ),
                                          ),
                                          Text(
                                            "4 hr ago",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SGray,
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
                          SizedBox(height: 16)
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
