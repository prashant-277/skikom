import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/Widgets/toastDisplay.dart';
import 'package:skicom/constants.dart';
import 'package:skicom/url.dart';
import 'package:http/http.dart' as http;

class editContacts extends StatefulWidget {
  String checkString;
  var sosid;
  var username;
  var phoneNumber;

  editContacts(this.checkString, this.sosid, this.username, this.phoneNumber);

  @override
  _editContactsState createState() => _editContactsState();
}

class _editContactsState extends State<editContacts> {
  final _formKey = GlobalKey<FormState>();

  final url1 = url.basicUrl;
  final token = url.token;

  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _numberCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSosContact();
  }

  Future<void> getSosContact() async {
    if (widget.checkString == "edit") {
      _usernameCtrl.text = widget.username.toString();
      _numberCtrl.text = widget.phoneNumber.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: medium,
        colorImage: Swhite,
        appbartext: widget.checkString=="add"? "Add contact" :"Edit contact",
        imageBack: true,
      ),
      body: Container(
        height: query.height,
        width: query.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textfield(
                  controller: _usernameCtrl,
                  obscureText: false,
                  hintText: "User name",
                  functionValidate: commonValidation,
                  textcapitalization: TextCapitalization.words,
                  suffixIcon: null,
                  prefixIcon: new IconButton(
                    icon: new Image.asset(
                      'Assets/Icons/profile.png',
                      width: 20.0,
                      height: 20.0,
                      color: SBlack,
                    ),
                    onPressed: null,
                  ),
                  parametersValidate: "Please enter User Name",
                  textInputType: TextInputType.text,
                ),
                textfield(
                  controller: _numberCtrl,
                  obscureText: false,
                  hintText: "Phone number",
                  functionValidate: commonValidation,
                  textcapitalization: TextCapitalization.none,
                  suffixIcon: null,
                  textlength: 10,
                  prefixIcon: new IconButton(
                    icon: new Image.asset(
                      'Assets/Icons/call.png',
                      width: 20.0,
                      height: 20.0,
                      color: SBlack,
                    ),
                    onPressed: null,
                  ),
                  parametersValidate: "Please enter phone number",
                  textInputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                      width: query.width,
                      child: basicButton(Swhite, () {
                        /*Navigator.pop(context);
                        Navigator.pop(context);
                        */

                        if(_formKey.currentState.validate()){
                          if(_numberCtrl.text.length==10){
                            if (widget.checkString == "add") {
                              addSosContact();
                            } else {
                              editSosContact();
                            }
                          }else{
                            displayToast("Enter valid phone number");
                          }
                        }

                      }, widget.checkString == "add" ? "Add" : "Save")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> addSosContact() async {

    final ProgressDialog pr =  ProgressDialog(context);
    pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "$url1/add-sos-contact";

    var map = new Map<String, dynamic>();

    map["user_name"] = _usernameCtrl.text.toString();
    map["phone"] = _numberCtrl.text.toString();
    map["user_id"] = prefs.getString("userId").toString();

    Map<String, String> headers = {"_token": token};


    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res add-sos-contact  " + responseJson.toString());
    if(responseJson["status"].toString()=="success"){
      Navigator.pop(context,true);
      pr.hide();
    }
  }

  Future<void> editSosContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ProgressDialog pr =  ProgressDialog(context);
    pr.show();

    var url = "$url1/edit-sos-contact";

    print(prefs.getString("userId").toString());
    print(widget.sosid.toString());
    print(_usernameCtrl.text.toString());
    print(_numberCtrl.text.toString());

    var map = new Map<String, dynamic>();
    map["user_id"] = prefs.getString("userId").toString();
    map["id"] = widget.sosid.toString();
    map["user_name"] = _usernameCtrl.text.toString();
    map["phone"] = _numberCtrl.text.toString();

    Map<String, String> headers = {"_token": token};
    //
    final response = await http.post(url, body: map, headers: headers);
    final responseJson = json.decode(response.body);
    print("res edit-sos-contact  " + responseJson.toString());
    if(responseJson["status"].toString()=="success"){
      Navigator.pop(context,true);
      pr.hide();
    }
  }

}

