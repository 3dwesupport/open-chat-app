import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/request_handler/socket.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GestureDetector(
            child: Text("Welcome to homepage"), onTap: () => {
          SocketConnection().connect()
          },),
        ),
      ),
    );
  }
}
