import 'package:flutter/material.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';

class privacy_policy extends StatefulWidget {
  @override
  _privacy_policyState createState() => _privacy_policyState();
}

class _privacy_policyState extends State<privacy_policy> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: query.width,
        color: Swhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconbuttonG(
                    () {
                      Navigator.pop(context);
                    },
                    "Assets/Icons/cancel.png",
                  )),
              Image.asset(
                "Assets/Images/logo.png",
                fit: BoxFit.fill,
                height: query.height * 0.15,
              ),
              Text("Privacy policy",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      height: 2,
                      fontFamily: "SFPro",
                      fontSize: 25)),
              SizedBox(height: 20),
              Text(
                "Off you go! Try out how the skis feel on your feet when you move. It’s best to try this out on level ground. Move the skis forwards and backwards a little using the ski poles. Hop gently, with both of your legs and from one leg to the other. \n\nOr try to move with your skis, taking small steps forwards. Then remove one ski, and propel yourself forward, like with a kick scooter, and try to slide for as long as possible on one ski. \n\nOff you go! Try out how the skis feel on your feet when you move. It’s best to try this out on level ground. Move the skis forwards and backwards a little using the ski poles. Hop gently, with both of your legs and from one leg to the other.",
                style: TextStyle(
                    fontSize: 18,
                    height: 1.3,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w500,
                    color: Colors.black45),
              )
            ],
          ),
        ),
      ),
    );
  }
}
