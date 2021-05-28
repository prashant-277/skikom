import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

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
        fontsize: 18,
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
                            fontSize: 16),
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
                            height: query.height * 0.16,
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
                                        height: query.height * 0.13,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: query.height * 0.12,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Main title",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w600,
                                                color: SBlack,
                                                fontSize: 20),
                                          ),
                                          Container(
                                            width: query.width * 0.58,
                                            child: Text(
                                              "You can support the library by liking it on pub...",
                                              style: TextStyle(
                                                  fontFamily: "SFPro",
                                                  fontWeight: FontWeight.w500,
                                                  color: SBlack,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            "4 hr ago",
                                            style: TextStyle(
                                                fontFamily: "SFPro",
                                                fontWeight: FontWeight.w500,
                                                color: SGray,
                                                fontSize: 12),
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
