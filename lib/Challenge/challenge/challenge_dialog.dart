import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class challenge_dialog extends StatefulWidget {
  @override
  _challenge_dialogState createState() => _challenge_dialogState();
}

class _challenge_dialogState extends State<challenge_dialog> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Swhite, borderRadius: BorderRadius.circular(40.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "Assets/Icons/cancel_dark.png",
                    height: query.height * 0.02,
                  ),
                )),
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "Assets/Images/2.png",
                  height: 80.sp,
                )),
            SizedBox(height: 10.sp),
            Text("Martin",
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: medium)),
            SizedBox(height: 10.sp),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text("Challenge for : ",
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack,
                        fontSize: medium)),
              ),
            ),
            SizedBox(height: 10),
            CustomRadioButton(
              width: query.width * 0.2,
              height: query.height * 0.05,
              padding: 0,
              autoWidth: false,
              enableButtonWrap: true,
              unSelectedBorderColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              elevation: 0,
              absoluteZeroSpacing: false,
              unSelectedColor: kGray,
              buttonLables: [
                '10 km',
                '20 km',
                '30 km',
                '40 km',
                '50 km',
              ],
              buttonValues: [
                '10 km',
                '20 km',
                '30 km',
                '40 km',
                '50 km',
              ],
              buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(
                    fontSize: small,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w500,
                    color: SBlack,
                  )),
              radioButtonValue: (value) {
                print(value);
              },
              selectedColor: SBlue,
            ),
            SizedBox(height: 10.sp),
            Container(
                height: 6.5.h,
                child: basicButton(Swhite, () {}, "Challenge Now!"))
          ],
        ),
      ),
    );
  }
}
