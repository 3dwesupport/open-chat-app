import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  AuthenticationState createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  TextEditingController mobileNumController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN PAGE"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TextField(
            focusNode: mobileFocusNode,
            controller: mobileNumController,
            keyboardType: TextInputType.number,
            key: Key('mobileNum'),
            decoration: InputDecoration(labelText: "Enter Mobile"),
          ),
          ElevatedButton(
            child: Text("submit"),
            onPressed: () => {sendOTP()},
          )
        ],
      ),
    );
  }

  sendOTP() {
  }
}
