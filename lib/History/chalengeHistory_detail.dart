import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:skicom/Challenge/leaderboard_page.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class chalengeHistory_detail extends StatefulWidget {
  List historyList;

  var groupId;

  chalengeHistory_detail(this.historyList, this.groupId);

  @override
  _chalengeHistory_detailState createState() => _chalengeHistory_detailState();
}

class _chalengeHistory_detailState extends State<chalengeHistory_detail> {
  double sliderValue = 500.0;
  final imageurl = url.imageUrl;
  final url1 = url.basicUrl;
  final token = url.token;
  List<LatLng> polylineCoordinates = [];
  double Source_lat, Source_lang, Desti_lat, Desti_lng;
  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polylines = {};
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  Polyline polyline = new Polyline(polylineId: null);

  @override
  void initState() {
    super.initState();
    print(widget.historyList);
    print(widget.groupId.toString());
    getPolycordinates();
  }

  Set<Marker> _markers = {};
  LatLng currentPostion = LatLng(23.1031871, 72.5956003);

  void getPolycordinates() {
    print(widget.historyList[0]["latlanglist"][0].toString());
    Source_lat =
        double.parse(widget.historyList[0]["latlanglist"][1].toString());
    Source_lang =
        double.parse(widget.historyList[0]["latlanglist"][2].toString());
    Desti_lat = double.parse(widget.historyList[0]["latlanglist"]
            [widget.historyList[0]["latlanglist"].lenght - 2]
        .toString());
    Desti_lng = double.parse(widget.historyList[0]["latlanglist"]
            [widget.historyList[0]["latlanglist"].length - 1]
        .toString());

    for (int i = 0; i < widget.historyList[0]["latlanglist"].length; i += 2) {
      if (i == 0) {
        print(i.toString());
        polylineCoordinates.add(LatLng(
            double.parse(widget.historyList[0]["latlanglist"][i]
                .toString()
                .substring(1)),
            double.parse(
                widget.historyList[0]["latlanglist"][i + 1].toString())));
      } else if (i == widget.historyList[0]["latlanglist"].length - 2) {
        print(i.toString());
        polylineCoordinates.add(LatLng(
            double.parse(widget.historyList[0]["latlanglist"][i].toString()),
            double.parse(widget.historyList[0]["latlanglist"][i + 1]
                .toString()
                .substring(
                    0,
                    widget.historyList[0]["latlanglist"][i + 1]
                            .toString()
                            .length -
                        2))));
        print("Coordinates Added");
      } else {
        print(i.toString());
        polylineCoordinates.add(LatLng(
            double.parse(widget.historyList[0]["latlanglist"][i].toString()),
            double.parse(
                widget.historyList[0]["latlanglist"][i + 1].toString())));
      }
    }
    set_source_pin(Source_lat, Source_lang);
    set_destination_pin(Desti_lat, Desti_lng);
    setPolylines();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Container(
          width: query.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: query.height / 2.7,
                width: query.width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(Source_lat, Source_lang),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationEnabled: true,
                  compassEnabled: false,
                  tiltGesturesEnabled: true,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  markers: _markers,
                ),
              ),
              Container(
                //  height: query.height * 0.2,
                width: query.width,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.historyList == null
                        ? ""
                        : widget.historyList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Swhite,
                            width: query.width,
                            height: query.height * 0.10,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text((index + 1).toString(),
                                      style: TextStyle(
                                          fontFamily: "SFPro",
                                          fontWeight: FontWeight.w600,
                                          color: SBlack,
                                          fontSize: 18)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: FadeInImage(
                                          image: NetworkImage(imageurl +
                                              widget.historyList[index]
                                                      ["profile"]
                                                  .toString()),
                                          fit: BoxFit.fill,
                                          width: 35.sp,
                                          height: 35.sp,
                                          placeholder: AssetImage(
                                              "Assets/Images/giphy.gif"))),
                                ),
                                SizedBox(width: 15),
                                SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Container(
                                    color: Swhite,
                                    width: query.width / 1.7,
                                    child: Column(
                                      children: [
                                        Text(""),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                widget.historyList[index]
                                                        ["username"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w600,
                                                    color: SBlack,
                                                    fontSize: 15)),
                                            Text(
                                                widget.historyList[index]
                                                        ["time"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: "SFPro",
                                                    fontWeight: FontWeight.w500,
                                                    color: SBlack,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 3.5,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius: 2.0,
                                                        elevation: 0),
                                                showValueIndicator:
                                                    ShowValueIndicator.always,
                                                valueIndicatorShape:
                                                    PaddleSliderValueIndicatorShape(),
                                                trackShape: CustomTrackShape(),
                                                overlayColor:
                                                    Colors.transparent),
                                            child: Container(
                                              width: query.width * 0.9,
                                              child: Slider(
                                                  value: double.parse(widget
                                                      .historyList[index]["km"]
                                                      .toString()),
                                                  min: 0.0,
                                                  max: double.parse(widget
                                                      .historyList[index]
                                                          ["for_km"]
                                                      .toString()
                                                      .substring(0, 2)),
                                                  activeColor: SBlue,
                                                  inactiveColor: kGray,
                                                  onChanged:
                                                      (double newValue) {},
                                                  semanticFormatterCallback:
                                                      (double newValue) {
                                                    return '${newValue.round()}';
                                                  }),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: query.width,
                            color: kGray,
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: query.width,
                height: query.height / 4.0,
                color: Swhite,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 15),
                        child: Image.asset("Assets/Images/sharewith.png"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("Assets/Images/google_rd.png",
                              height: query.height * 0.10),
                          Image.asset("Assets/Images/fb_rd.png",
                              height: query.height * 0.10),
                          Image.asset("Assets/Images/insta_rd.png",
                              height: query.height * 0.10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 10),
                child: Container(
                  width: query.width,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: SRed,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SFPro",
                          fontWeight: FontWeight.w600,
                          color: Swhite),
                    ),
                    onPressed: () async {
                      showdeleteDialog();
                    },
                    padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showdeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to delete this history?',
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
              final ProgressDialog pr = _getProgress(context);
              pr.update(
                  message: "Please wait...",
                  messageTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "SFPro",
                      fontSize: medium));
              pr.show();
              var url = "$url1/delete-history";

              var map = new Map<String, dynamic>();
              map["id"] = widget.groupId.toString();

              Map<String, String> headers = {"_token": token};

              final response =
                  await http.post(url, body: map, headers: headers);
              final responseJson = json.decode(response.body);

              print("res delet-result  " + responseJson.toString());

              if (responseJson["status"].toString() == "success") {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
                pr.hide();
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
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void set_source_pin(double lat, double lng) {
    setState(() {
// source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: LatLng(lat, lng),
        icon: sourceIcon,
      ));
    });
  }

  void set_destination_pin(double lat, double long) {
    setState(() {
// destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: LatLng(lat, long),
          icon: destinationIcon));
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
    });
  }
}

ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}
