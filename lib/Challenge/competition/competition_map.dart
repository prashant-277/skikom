import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';

class competition_map extends StatefulWidget {
  @override
  _competition_mapState createState() => _competition_mapState();
}

class _competition_mapState extends State<competition_map> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(48.521563, 17.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: query.height / 1.15,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 20.sp),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "Assets/Icons/back.png",
                        height: 15.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
                height: query.height * 0.18,
            width: query.width,
            decoration: BoxDecoration(
                color: SBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1 hr 52 min",
                    style: TextStyle(
                        fontSize: 28,
                        height: 1,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w600,
                        color: Swhite),
                  ),
                  Text(
                    "72 km Remaining",
                    style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w500,
                        color: Swhite),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
