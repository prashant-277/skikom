import 'package:flutter/material.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final AppBar appBar;
  final List<Widget> widgets;

  final String appbartext;
  final Widget leadingIcon;

  const BaseAppBar({Key key, this.backgroundColor, this.appBar, this.widgets, this.appbartext, this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: leadingIcon,
      backgroundColor: backgroundColor,
      title: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.only(left: 0),
        onPressed: () {
          Navigator.pop(context,true);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "Assets/Icons/back.png",
              height: 12.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                appbartext,
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: Swhite,
                    fontSize: medium),
              ),
            ),
          ],
        ),
      ),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class commanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color colorImage;
  final AppBar appBar;
  final List<Widget> widgets;
  final String appbartext;
  final Widget leadingIcon;
  final double fontsize;
  final bool imageBack;

  const commanAppBar({Key key, this.appBar, this.widgets, this.appbartext, this.leadingIcon, this.colorImage, this.fontsize, this.imageBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      leading: leadingIcon,
      backgroundColor: SBlue,
      title: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.only(left: 0),
        onPressed: imageBack ? () {
          Navigator.pop(context);
        }:null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: imageBack,
              child: Image.asset(
                "Assets/Icons/back.png",
                 height: 12.sp,
                color: colorImage,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                width: 200.sp,
                child: Text(
                  appbartext,
                  style: TextStyle(
                      fontFamily: "SFPro",
                      fontWeight: FontWeight.w600,
                      color: Swhite,
                      fontSize: fontsize),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
