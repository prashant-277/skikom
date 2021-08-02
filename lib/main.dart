import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/Login/splashScreen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Skicom',
          theme: ThemeData(
            primaryColor: Color(0xff002868),
          ),
          home: splashScreen(),
        );
      },
    );


  }
}
