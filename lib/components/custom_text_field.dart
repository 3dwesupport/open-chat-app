import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode mobileFocusNode;
  final TextEditingController mobileNumController;
  final String labelText;
  final Icon? prefixIcon;
  final Key key;
  final TextInputType keyboardType;

  const CustomTextField(
      {required this.labelText,
      required this.mobileFocusNode,
      required this.mobileNumController,
      this.prefixIcon,
      required this.key,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset.fromDirection(90, 5))
          ]),
      child: TextField(
        focusNode: mobileFocusNode,
        controller: mobileNumController,
        keyboardType: keyboardType,
        key: key,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(7),
            prefixIcon: prefixIcon,
            label: Text(labelText),
            labelStyle: TextStyle(color: Colors.grey[600]),
            floatingLabelStyle: TextStyle(color: Colors.orange),
            fillColor: Colors.white,
            focusColor: Colors.orange,
            border: InputBorder.none),
      ),
    );
  }
}
