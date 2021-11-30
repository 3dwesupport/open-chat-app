import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/request_handler/socket.dart';
import 'package:provider/provider.dart';

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
            child: Text(Provider.of<AuthProvider>(context, listen: false)
                .getUserInfo()
                .firstName),
            onTap: () => {SocketConnection().connect()},
          ),
        ),
      ),
    );
  }
}
