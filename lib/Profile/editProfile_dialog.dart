import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/constants.dart';

class editProfile_dialog extends StatefulWidget {
  @override
  _editProfile_dialogState createState() => _editProfile_dialogState();
}

class _editProfile_dialogState extends State<editProfile_dialog> {
  TextEditingController _usernameCtrl =
      TextEditingController(text: "William Myer");
  TextEditingController _emailCtrl =
      TextEditingController(text: "williammyer@gmail.com");

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Swhite, borderRadius: BorderRadius.circular(40.0)),
        width: query.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit profile",
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack,
                        fontSize: medium),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "Assets/Icons/cancel_dark.png",
                      height: query.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: query.height * 0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/2.png"))),
                  child: Image.asset(
                    "Assets/Icons/profilepic_edit.png",
                    cacheHeight: 30,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: textfield(
                controller: _usernameCtrl,
                obscureText: false,
                hintText: "User name",
                functionValidate: commonValidation,
                suffixIcon: null,
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'Assets/Icons/profile.png',
                    width: 20.0,
                    height: 20.0,
                    color: SBlack,
                  ),
                  onPressed: null,
                ),
                parametersValidate: "Please enter User Name",
                textcapitalization: TextCapitalization.words,
                textInputType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: textfield(
                controller: _emailCtrl,
                obscureText: false,
                hintText: "Email",
                functionValidate: commonValidation,
                suffixIcon: null,
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'Assets/Icons/email.png',
                    width: 20.0,
                    height: 20.0,
                    color: SBlack,
                  ),
                  onPressed: null,
                ),
                parametersValidate: "Please enter Email",
                textInputType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
              child: Container(
                  width: query.width,
                  child: basicButton(Swhite, () {}, "Save")),
            )
          ],
        ),
      ),
    );
  }
}
