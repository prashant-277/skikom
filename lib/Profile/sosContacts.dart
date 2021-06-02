import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Profile/editContacts.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class sosContacts extends StatefulWidget {
  @override
  _sosContactsState createState() => _sosContactsState();
}

class _sosContactsState extends State<sosContacts> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: true,
        appbartext: "Contacts",
        colorImage: Swhite,
        fontsize: medium,
      ),
      body: Container(
        width: query.width,
        height: query.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("Assets/Icons/sos.png"),
            Column(
              children: [
                Container(
                  width: query.width / 1.1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "User name",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                Text(
                                  "01 12345 667890",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).push(
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          alignment: Alignment.bottomCenter,
                                          duration: Duration(milliseconds: 300),
                                          child: editContacts()));
                                },
                                icon: Image.asset(
                                  "Assets/Icons/edit.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "Assets/Icons/delete_red.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: query.width / 1.1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "User name",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                Text(
                                  "01 12345 667890",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "Assets/Icons/edit.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "Assets/Icons/delete_red.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: query.width / 1.1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kGray),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "User name",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: SBlack,
                                      fontSize: small),
                                ),
                                Text(
                                  "01 12345 667890",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: SBlack,
                                      fontSize: medium),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "Assets/Icons/edit.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "Assets/Icons/delete_red.png",
                                  height: query.height * 0.05,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
