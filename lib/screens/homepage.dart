import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/chat_socket_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  void initState() {
    connect();
    super.initState();
  }

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
        child: ListView.builder(
            itemCount: Provider.of<ChatSocketProvider>(context, listen: false)
                .chatUsersList
                .length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => openConversation(index),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image(
                                width: 54,
                                image: AssetImage(
                                    'assets/logos/open_chat_logo.png')),
                          ),
                          Text(
                            Provider.of<ChatSocketProvider>(context,
                                    listen: false)
                                .chatUsersList[index]
                                .username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider())
                  ],
                ),
              );
            }),
      ),
    );
  }

  void connect() async {
    await Provider.of<ChatSocketProvider>(context, listen: false)
        .connect(reload);
  }

  reload() {
    setState(() {});
  }

  openConversation(int index) {
    User chatUser = Provider.of<ChatSocketProvider>(context, listen: false)
        .chatUsersList[index];
    Provider.of<ChatSocketProvider>(context, listen: false)
        .getConversation(context, chatUser.uid);
    Provider.of<ChatSocketProvider>(context, listen: false)
        .sendMessage(context, "helllloooo", chatUser.uid);
  }
}
