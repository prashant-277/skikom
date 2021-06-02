import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class topicDetails_page extends StatefulWidget {
  const topicDetails_page({Key key}) : super(key: key);

  @override
  _topicDetails_pageState createState() => _topicDetails_pageState();
}

class _topicDetails_pageState extends State<topicDetails_page> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: true,
        fontsize: medium,
        colorImage: Swhite,
        appbartext: "Back",
      ),
      body: Container(
        height: query.height,
        width: query.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Image.asset("Assets/Images/img_1.png"),
              SizedBox(height: 10),
              Text(
                "Learning to ski I: sliding and moving?",
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w700,
                    color: SBlack,
                    fontSize: 18.sp),
              ),
              SizedBox(height: 10),
              Text(
                "Off you go! Try out how the skis feel on your feet when you move. It’s best to try this out on level ground. Move the skis forwards and backwards a little using the ski poles. Hop gently, with both of your legs and from one leg to the other. Or try to move with your skis, taking small steps forwards. Then remove one ski, and propel yourself forward, like with a kick scooter, and try to slide for as long as possible on one ski.",
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w500,
                    color: SBlack,
                    height: 1.4,
                    fontSize: medium),
              ),
              SizedBox(height: 10),
              Image.asset("Assets/Images/img_1.png"),
              SizedBox(height: 10),
              Text(
                "Off you go! Try out how the skis feel on your feet when you move. It’s best to try this out on level ground. Move the skis forwards and backwards a little using the ski poles. Hop gently, with both of your legs and from one leg to the other. Or try to move with your skis, taking small steps forwards. Then remove one ski, and propel yourself forward, like with a kick scooter, and try to slide for as long as possible on one ski.",
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w500,
                    color: SBlack,
                    height: 1.4,
                    fontSize: 16),
              ),
              SizedBox(height: 10),
              Image.asset("Assets/Images/sharewith.png"),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("Assets/Images/google_rd.png",
                        height: 60.sp),
                    Image.asset("Assets/Images/fb_rd.png",
                        height: 60.sp),
                    Image.asset("Assets/Images/insta_rd.png",
                        height: 60.sp),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
