import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../constants.dart';


class progressbar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium)
    );
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}

