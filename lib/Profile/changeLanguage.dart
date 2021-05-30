import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class changeLanguage extends StatefulWidget {
  @override
  _changeLanguageState createState() => _changeLanguageState();
}

class _changeLanguageState extends State<changeLanguage> {
  bool tickEN = false;
  bool tickFN  = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: true,
        appbartext: "Language",
        colorImage: Swhite,
        fontsize: 15,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: query.width,
          height: query.height,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    tickEN = true;
                    tickFN = false;
                  });
                },
                child: Container(
                  width: query.width / 1.1,
                  height: query.height * 0.08,
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
                          Text(
                            "English",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: 14),
                          ),
                          Visibility(
                            visible: tickEN,
                            child: Image.asset(
                              "Assets/Icons/tick.png",
                              height: query.height * 0.02,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  setState(() {
                    tickEN = false;
                    tickFN = true;
                  });
                },
                child: Container(
                  width: query.width / 1.1,
                  height: query.height * 0.08,
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
                          Text(
                            "French",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontWeight: FontWeight.w600,
                                color: SBlack,
                                fontSize: 14),
                          ),
                          Visibility(
                            visible: tickFN,
                            child: Image.asset(
                              "Assets/Icons/tick.png",
                              height: query.height * 0.02,
                            ),
                          )
                        ],
                      ),
                    ),
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
