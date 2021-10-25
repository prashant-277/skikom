import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'category_page.dart';

class tutorials_page extends StatefulWidget {
  List categorie_data;

  var back;

  tutorials_page(this.categorie_data, this.back);



  @override
  _tutorials_pageState createState() => _tutorials_pageState();
}

class _tutorials_pageState extends State<tutorials_page> {


  dynamic listImages = [
    "Assets/Icons/green_tuto.png",
    "Assets/Icons/light_blue_tuto.png",
    "Assets/Icons/orange_tuto.png",
    "Assets/Icons/pink_tuto.png",
    "Assets/Icons/yellow_tuto.png",
  ];
  Random rnd;

  Image img() {
    int min = 0;
    int max = listImages.length;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String image_name  = listImages[r].toString();
    return Image.asset(image_name);
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to exit an app?',style: TextStyle(
            fontFamily: "SFPro",
            fontWeight: FontWeight.w600,
            color: SBlack,
            fontSize: 14.sp)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: SBlack,
                fontSize: 14.sp)),
          ),
        ],
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Swhite,
        appBar: commanAppBar(
          appBar: AppBar(),
          imageBack: widget.back == "back" ? true : false,
          appbartext: "Tutorials",
          colorImage: Swhite,
          fontsize: 16.sp,
        ),
        body: SingleChildScrollView(
          child: widget.categorie_data.toString()=="[]" ?
          Container(
            height: query.height,
              color: Swhite,
              child: Center(
                  child: Text("No data found",
                      style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w500,
                      color: SBlack,
                      fontSize: medium)))):
          Container(
            height: query.height / 1.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: ListView.builder(
                itemCount: widget.categorie_data == null ? "" : widget.categorie_data.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              child: category_page(widget.categorie_data[index]["detail"]["categories_id"],
                                  widget.categorie_data[index]["detail"]["categories_name"].toString())));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Container(
                        width: query.width,
                        child: Stack(
                          children: [
                            img(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 25.sp),
                                Container(
                                  height: 100.sp,
                                  child: Center(
                                    child: Text(
                                      widget.categorie_data[index]["detail"]["categories_name"].toString(),
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: Swhite,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}