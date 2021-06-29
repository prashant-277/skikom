import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/competition/saveActivity_page.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class startCompetition_page extends StatefulWidget {
  const startCompetition_page({Key key}) : super(key: key);

  @override
  _startCompetition_pageState createState() => _startCompetition_pageState();
}

class _startCompetition_pageState extends State<startCompetition_page> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(48.521563, 17.677433);

  bool timer = true;
  bool finishResume = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Stopwatch _stopwatch;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });

    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Swhite,
        body: SingleChildScrollView(
          child: Container(
            height: query.height,
            width: query.width,
            child: Column(
              children: [
                Container(
                  height: query.height * 0.75,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),
                ),
                Container(
                  width: query.width,
                  color: Swhite,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "km",
                                  style: TextStyle(
                                      fontSize: small,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w500,
                                      color: SGray),
                                ),
                                Text(
                                  "0.01",
                                  style: TextStyle(
                                      fontSize: medium,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: SBlack),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                      fontSize: small,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w500,
                                      color: SGray),
                                ),
                                Text(
                                  formatTime(_stopwatch.elapsedMilliseconds),
                                  style: TextStyle(
                                      fontSize: medium,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w600,
                                      color: SBlack),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          visible: timer,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                timer = false;
                                finishResume = true;
                                _stopwatch.stop();

                                print(_stopwatch.elapsed);
                              });
                            },
                            child: Image.asset(
                              "Assets/Icons/pause.png",
                              height: 60.sp,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: finishResume,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true).push(
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              alignment: Alignment.bottomCenter,
                                              duration: Duration(milliseconds: 300),
                                              child: saveActivity_page()));
                                    },
                                    onDoubleTap: (){
                                      _stopwatch.reset();
                                    },
                                    child: Image.asset(
                                      "Assets/Icons/finish.png",
                                      height: 60.sp,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:3.0),
                                    child: Text(
                                      "Double tap \nto reset",
                                      style: TextStyle(
                                          fontSize: small,
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w500,
                                          color: SGray),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: query.width / 9),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    timer = true;
                                    finishResume = false;
                                    _stopwatch.start();
                                  });
                                },
                                child: Image.asset(
                                  "Assets/Icons/resume.png",
                                  height: 60.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }
}
