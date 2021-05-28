import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/challenge/savechallenge_page.dart';
import 'package:skicom/Challenge/challenge/sos_emergency.dart';
import 'package:skicom/Challenge/competition/saveActivity_page.dart';
import 'package:skicom/constants.dart';

class startChallenge extends StatefulWidget {
  const startChallenge({Key key}) : super(key: key);

  @override
  _startChallengeState createState() => _startChallengeState();
}

class _startChallengeState extends State<startChallenge> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(48.521563, 17.677433);

  bool timer = true;
  bool finishResume = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Swhite,
      body: SingleChildScrollView(
        child: Container(
          height: query.height,
          width: query.width,
          child: Column(
            children: [
              Stack(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.bottomCenter,
                                duration: Duration(milliseconds: 300),
                                child: sos_emergency()));
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "Assets/Icons/sos_btn.png",
                            height: query.height * 0.09,
                          )),
                    ),
                  )
                ],
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
                                    fontSize: 16,
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w500,
                                    color: SGray),
                              ),
                              Text(
                                "0.01",
                                style: TextStyle(
                                    fontSize: 20,
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
                                    fontSize: 16,
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w500,
                                    color: SGray),
                              ),
                              Text(
                                "00:01:25",
                                style: TextStyle(
                                    fontSize: 20,
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
                            });
                          },
                          child: Image.asset(
                            "Assets/Icons/pause.png",
                            height: query.height * 0.1,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: finishResume,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        alignment: Alignment.bottomCenter,
                                        duration: Duration(milliseconds: 300),
                                        child: saveChallenge_page()));
                              },
                              child: Image.asset(
                                "Assets/Icons/finish.png",
                                height: query.height * 0.1,
                              ),
                            ),
                            SizedBox(width: query.width / 9),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  timer = true;
                                  finishResume = false;
                                });
                              },
                              child: Image.asset(
                                "Assets/Icons/resume.png",
                                height: query.height * 0.1,
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
    );
  }
}