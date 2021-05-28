import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skicom/Challenge/challenge/challenge_dialog.dart';
import 'package:skicom/constants.dart';

class friends_challenge extends StatefulWidget {
  @override
  _friends_challengeState createState() => _friends_challengeState();
}

class _friends_challengeState extends State<friends_challenge> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Container(
      height: query.height,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                            contentPadding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 15, top: 0),
                            backgroundColor: Swhite,
                            content: challenge_dialog()));
                  });
                },
                child: Container(
                  height: query.height,
                  width: query.width,
                  decoration: BoxDecoration(
                      color: Swhite,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 1.5, color: kGray)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "Assets/Images/2.png",
                            height: query.height * 0.13,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Michelbr",
                          style: TextStyle(
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.w600,
                              color: SBlack,
                              fontSize: 15)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: SRed,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text("Challenge",
                              style: TextStyle(
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w600,
                                  color: Swhite,
                                  fontSize: 10)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
