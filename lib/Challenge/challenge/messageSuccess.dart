import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class messageSuccess extends StatefulWidget {
  @override
  _messageSuccessState createState() => _messageSuccessState();
}

class _messageSuccessState extends State<messageSuccess> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: 15,
        colorImage: Swhite,
        appbartext: "               ",
        imageBack: true,
      ),
      body: Container(
        width: query.width,
        height: query.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "Assets/Icons/sent.png",
                height: query.height*0.35,
              ),
              Text(
                "Emergency message sent success.",
                textAlign: TextAlign.center,
                style: TextStyle(

                    fontSize: 25,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w700,
                    color: SBlack),
              ),
              Container(
                width: query.width / 1.2,
                decoration: BoxDecoration(
                    border: Border.all(color: SBlack, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.transparent,
                  child: Text(
                    "Back to home!",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
