import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/constants.dart';

class chalengeHistory_detail extends StatefulWidget {
  @override
  _chalengeHistory_detailState createState() => _chalengeHistory_detailState();
}

class _chalengeHistory_detailState extends State<chalengeHistory_detail> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: 15,
        colorImage: Swhite,
        appbartext: "Challenge name",
        imageBack: true,
        widgets: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("Assets/Icons/delete.png",
                  height: query.height * 0.025),
            ),
          )
        ],
      ),
    );
  }
}
