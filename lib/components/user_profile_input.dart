import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileInput extends StatelessWidget {
  final FocusNode mobileFocusNode;
  final TextEditingController mobileNumController;
  final String labelText;
  final Icon? prefixIcon;
  final Key key;
  final TextInputType keyboardType;
  final bool enabled;

  const UserProfileInput(
      {required this.labelText,
      required this.mobileFocusNode,
      required this.mobileNumController,
      this.prefixIcon,
      required this.key,
      this.keyboardType = TextInputType.text,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 9),
            child: Text(
              labelText,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Container(
          decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset.fromDirection(90, 4))
              ]),
          child: TextField(
            focusNode: mobileFocusNode,
            controller: mobileNumController,
            keyboardType: keyboardType,
            key: key,
            decoration: InputDecoration(
                hintText: labelText,
                enabled: enabled,
                contentPadding: EdgeInsets.all(10),
                prefixIcon: prefixIcon,
                floatingLabelStyle: TextStyle(color: Colors.orange),
                fillColor: Colors.white,
                focusColor: Colors.orange,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
