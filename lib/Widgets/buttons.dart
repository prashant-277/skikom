import 'package:flutter/material.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class primarybutton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color, textcolor;
  final String imageName;

  primarybutton(
      this.text, this.onPressed, this.color, this.imageName, this.textcolor);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            imageName,
            width: 6.w,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 14.0.sp,
                fontFamily: "SFPro",
                fontWeight: FontWeight.w600,
                color: textcolor),
          ),
          Image.asset(
            imageName,
            width: 6.w,
            color: Colors.transparent,
          ),
        ],
      ),
      onPressed: onPressed,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    );
  }
}

class IconbuttonG extends StatelessWidget {
  final Function onPressed;
  final String imagename;

  const IconbuttonG(this.onPressed, this.imagename);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        imagename,
        fit: BoxFit.fill,
        height: query.height * 0.025,
      ),
    );
  }
}

class basicButton extends StatelessWidget {
  final Color textcolor;
  final Function onPressed;
  final String text;

  const basicButton(this.textcolor, this.onPressed, this.text);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: buttonColor,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "SFPro",
            fontWeight: FontWeight.w600,
            color: textcolor),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
    );
  }
}
