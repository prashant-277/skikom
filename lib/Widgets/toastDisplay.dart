import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skicom/constants.dart';

void displayToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: SLightBlue,
      textColor: Colors.white,
      fontSize: 14.0);
}