import 'package:flutter/material.dart';
import 'package:skicom/Widgets/appbarCustom.dart';
import 'package:skicom/Widgets/buttons.dart';
import 'package:skicom/Widgets/textfield.dart';
import 'package:skicom/constants.dart';

class editContacts extends StatefulWidget {
  @override
  _editContactsState createState() => _editContactsState();
}

class _editContactsState extends State<editContacts> {
  TextEditingController _usernameCtrl =
      TextEditingController(text: "User name");
  TextEditingController _numberCtrl =
      TextEditingController(text: "12345 67890");

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: commanAppBar(
        appBar: AppBar(),
        fontsize: medium,
        colorImage: Swhite,
        appbartext: "Edit",
        imageBack: true,
      ),
      body: Container(
        height: query.height,
        width: query.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              textfield(
                controller: _usernameCtrl,
                obscureText: false,
                hintText: "User name",
                functionValidate: commonValidation,
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
                textInputType: TextInputType.name,
              ),
              textfield(
                controller: _numberCtrl,
                obscureText: false,
                functionValidate: commonValidation,
                suffixIcon: null,
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'Assets/Icons/call.png',
                    width: 20.0,
                    height: 20.0,
                    color: SBlack,
                  ),
                  onPressed: null,
                ),
                parametersValidate: "Please enter User Name",
                textInputType: TextInputType.name,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                    width: query.width,
                    child: basicButton(Swhite, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, "Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
