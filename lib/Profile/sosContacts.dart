import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Profile/editContacts.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;
class sosContacts extends StatefulWidget {
  @override
  _sosContactsState createState() => _sosContactsState();
}

class _sosContactsState extends State<sosContacts> with TickerProviderStateMixin{
  final url1 = url.basicUrl;
  final token = url.token;
  List sosList = [];
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    getSosContact();
  }
  Future<void> getSosContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/get-sos-contact";

    var map = new Map<String, dynamic>();

    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res get-sos-contact  " + responseJson.toString());
    setState(() {
      sosList = responseJson["data"];
      _isloading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Swhite,
      appBar: commanAppBar(
        appBar: AppBar(),
        imageBack: true,
        appbartext: "Contacts",
        colorImage: Swhite,
        fontsize: medium,
        widgets: [
          IconButton(onPressed: (){

            Navigator.of(context,rootNavigator: true).
            push(new MaterialPageRoute(builder: (_)=>new editContacts("add",null,null,null)),)
                .then((val)=>getSosContact());

          }, icon: Icon(Icons.add))
        ],
      ),
      body: _isloading == true
          ? SpinKitRipple(
        color: SLightBlue,
        controller: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1200)),
      )
          : SingleChildScrollView(
            child: Container(
        width: query.width,
        height: query.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("Assets/Icons/sos.png"),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: query.height/2.5,
                  child: sosList.toString()=="[]"? Container(
                    child: Text("No SOS contacet added",
                      style: TextStyle(
                        fontFamily: "SFPro",
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: SBlack,
                        fontSize: medium),),):ListView.builder(
                      itemCount: sosList==null?"":sosList.length,
                      itemBuilder: (context, index){
                    return Column(
                      children: [
                        Container(
                          width: query.width / 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kGray),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(sosList[index]["user_name"].toString(),
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              fontWeight: FontWeight.w600,
                                              height: 1.5,
                                              color: SBlack,
                                              fontSize: small),
                                        ),
                                        Text(sosList[index]["phone"].toString(),
                                          style: TextStyle(
                                              fontFamily: "SFPro",
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              color: SBlack,
                                              fontSize: medium),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context,rootNavigator: true).
                                          push(new MaterialPageRoute(builder: (_)=>new editContacts("edit",sosList[index]["id"],sosList[index]["user_name"],sosList[index]["phone"])),)
                                              .then((val)=>getSosContact());

                                          },
                                        icon: Image.asset(
                                          "Assets/Icons/edit.png",
                                          height: query.height * 0.05,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showAlertDialog(sosList[index]["id"]);
                                        },
                                        icon: Image.asset(
                                          "Assets/Icons/delete_red.png",
                                          height: query.height * 0.05,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
        ),
      ),
          ),
    );
  }

  showAlertDialog(sosId) {

    Widget yesButton = FlatButton(
      child: Text("Yes",style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium),),
      onPressed: () {deleteItem(sosId);},
    );
    Widget noButton = FlatButton(
      child: Text("No",style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium)),
      onPressed: () {Navigator.pop(context);},
    );

    AlertDialog alert = AlertDialog(


      content: Text("Do you really want to delete contact?",style: TextStyle(
          fontFamily: "SFPro",
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: SBlack,
          fontSize: medium),),
      actions: [
        yesButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deleteItem(sosId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ProgressDialog pr = _getProgress(context);
    pr.update(
        message: "Please wait...",
        messageTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "SFPro",
            fontSize: medium));
    await pr.show();
    var url = "$url1/delete-sos-contact";

    var map = new Map<String, dynamic>();

    map["user_id"] = prefs.getString("userId").toString();
    map["id"] = sosId.toString();

    Map<String, String> headers = {"_token": token};

    final response = await http.post(url, body:map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res delete-sos-contact  " + responseJson.toString());

    if(responseJson["status"].toString()=="success"){
      displayToast(responseJson["message"].toString());
      getSosContact();
      Navigator.pop(context);
      pr.hide();
    }
  }
}
ProgressDialog _getProgress(BuildContext context) {
  return ProgressDialog(context);
}