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
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.black87, fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
            color: Colors.black54,
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => {},
            color: Colors.black87,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: GestureDetector(
                child: Text(Provider.of<AuthProvider>(context, listen: false)
                    .getUserInfo()
                    .firstName),
                onTap: () => {SocketConnection().connect()},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
