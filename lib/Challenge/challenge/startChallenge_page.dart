import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Challenge/challenge/savechallenge_page.dart';
import 'package:skicom/Challenge/challenge/sos_emergency.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

class startChallenge extends StatefulWidget {
  var group_id;

  var challenge_id;

  startChallenge(this.group_id, this.challenge_id);

  @override
  _startChallengeState createState() => _startChallengeState();
}

class _startChallengeState extends State<startChallenge> {
  final url1 = url.basicUrl;
  final token = url.token;

  GoogleMapController mapController;
  LatLng currentPostion;

  Stopwatch _stopwatch;
  Timer _timer;

  bool timer = true;
  bool finishResume = false;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  double Source_lat = 0,
      Source_lang = 0,
      Desti_lat = 0,
      Desti_lng = 0,
      Inter_lat = 0,
      Inter_lng = 0;
  List<LatLng> polylineCoordinates = [];
  List<double> lat_lng = [];
  Polyline polyline = new Polyline(polylineId: PolylineId("null"));
  PolylinePoints polylinePoints = PolylinePoints();

  /*BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;*/
  int count_dst = 0;
  int count_srs = 0;
  int track = 0;
  double distance;

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
    _getUserLocation();
    distance = 0.0;
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    print("LAT" + position.latitude.toString());
    print("LANG" + position.longitude.toString());

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
    start_tracking();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Do you want to exit from challenge?',
                style: TextStyle(
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.w600,
                    color: SBlack,
                    fontSize: 14.sp)),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack,
                        fontSize: 14.sp)),
              ),
              FlatButton(
                onPressed: () async {

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  var url = "$url1/accept-request";
                  var map = new Map<String, dynamic>();
                  map["group_id"] = widget.group_id.toString();
                  map["to_user"] = prefs.getString("userId").toString();
                  map["status"] = "2";

                  Map<String, String> headers = {"_token": token};

                  final response =
                      await http.post(url, body: map, headers: headers);
                  final responseJson = json.decode(response.body);
                  print("res accept-request  " + responseJson.toString());

                  if (responseJson["status"].toString() == "success") {
                    displayToast(responseJson["message"].toString());
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Yes',
                    style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: SBlack,
                        fontSize: 14.sp)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                        myLocationEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: true,
                        markers: _markers,
                        polylines: _polylines,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: currentPostion,
                          zoom: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, right: 20),
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
                              height: 60.sp,
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
                                      fontSize: small,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w500,
                                      color: SGray),
                                ),
                                Text(
                                  distance.toString(),
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
                            onTap: () async {
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
                              InkWell(
                                onTap: () {
                                  setState(() async {
                                    track = 1;
                                    start_tracking();

                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    var url = "$url1/finish-challenge";

                                    print(formatTime(_stopwatch.elapsedMilliseconds).toString());
                                    print(distance.toString());
                                    print("challenge id--- " + widget.challenge_id.toString());

                                    var map = new Map<String, dynamic>();
                                    map["challenge_id"] = widget.challenge_id.toString();
                                    map["user_id"] = prefs.getString("userId").toString();
                                    map["time"] = formatTime(_stopwatch.elapsedMilliseconds).toString();
                                    map["km"] = distance.toString();

                                    Map<String, String> headers = {"_token": token};


                                    final response = await http.post(url, body:map, headers: headers);
                                    final responseJson = json.decode(response.body);
                                    print("res finish-challenge  " + responseJson.toString());

                                    if(responseJson["status"].toString()=="success"){
                                      setState(() {
                                        track=1;
                                        _stopwatch.stop();
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .push(PageTransition(
                                          type: PageTransitionType.fade,
                                          alignment: Alignment.bottomCenter,
                                          duration:
                                          Duration(milliseconds: 300),
                                          child: saveChallenge_page(widget.group_id)));
                                    }
                                  });
                                },
                                child: Image.asset(
                                  "Assets/Icons/finish.png",
                                  height: 60.sp,
                                ),
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

  start_tracking() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    location.onLocationChanged.listen((LocationData currentLocation) async {
      if (track == 0) {
        setState(() {
          count_dst = 0;

          Inter_lat = Desti_lat != null ? Desti_lat : Source_lat;
          Inter_lng = Desti_lng != null ? Desti_lng : Source_lang;
          print("Desti" + currentLocation.latitude.toString());

          Desti_lat = currentLocation.latitude;
          Desti_lng = currentLocation.longitude;
          polylineCoordinates.add(LatLng(Desti_lat, Desti_lng));

          lat_lng.add(Desti_lat);
          lat_lng.add(Desti_lng);

          setPolylines();
          dis();

          if (count_srs == 0) {
            set_source_pin(Desti_lat, Desti_lng);
            count_srs++;
          } else {}
        });
      } else {
        if (count_dst == 0) {
          set_destination_pin(Desti_lat, Desti_lng);
        } else {}
      }
    });
  }

  setPolylines() async {
    setState(() {
      polyline = Polyline(
          visible: true,
          width: 5,
          geodesic: true,
          zIndex: 1,
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);

      print("PolylineCoordinates" + polylineCoordinates.toString());
      print("Only Lat Long List" + lat_lng.toString());
    });
  }

  dis() async {
    distance = await (distance +
            Geolocator.distanceBetween(
                Inter_lat, Inter_lng, Desti_lat, Desti_lng)/1000) ;
    // distance = distance +
    //     await polylinePoints.getDistance(
    //         "AIzaSyAixWpeG2pCQGvAQ-KYHG7CNzEq0v4L7iY", Inter_lat, Inter_lng, Desti_lat, Desti_lng);
    // print("Total Distance"+distance.toString());
    /* var _distanceInMeters = await Geolocator.distanceBetween(
        Desti_lat,
        Desti_lng,
        Inter_lat,
        Inter_lng,
      );
*/
    print("distance   ==== " + distance.toString());
    // print("distance  _distanceInMeters ==== " + (_distanceInMeters/1000).toString());
  }

  void set_source_pin(double lat, double lng) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  void set_destination_pin(double lat, double long) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarker));
    });
  }
}
