import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skicom/constants.dart';
import 'package:sizer/sizer.dart';
class textfield extends StatelessWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function functionValidate;
  final String parametersValidate;

  const textfield({
    this.textInputType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.controller,
    this.functionValidate,
    this.parametersValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        cursorColor: SLightBlue,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: TextStyle(fontFamily: "SFPro", color: SBlack,fontSize: medium),
        obscureText: obscureText,
        controller: controller,
       textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15.0, 18.0, 20.0, 18.0),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: SGray, width: 1)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: SGray, width: 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: SGray,
                width: 1.0,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: "SFPro",
              fontSize: medium
            ),
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
        validator: (value) {
          if (functionValidate != null) {
            String resultValidate =
                functionValidate(value, parametersValidate);
            if (resultValidate != null) {
              return resultValidate;
            }
          }
          return null;
        },
      ),
    );
  }
}

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}
