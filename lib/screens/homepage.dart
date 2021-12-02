import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/providers/chat_socket_provider.dart';
import 'package:open_chat_app/providers/navigation_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
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
        child: ListView.separated(
          itemCount: getOnlineUsers().length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => openConversation(index),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Image(
                          width: 54,
                          image: AssetImage('assets/logos/open_chat_logo.png')),
                    ),
                    Text(
                      getOnlineUsers()[index].username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 20), child: Divider());
          },
        ),
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

  List<User> getOnlineUsers() {
    List<User> users =
        Provider.of<ChatSocketProvider>(context, listen: false).chatUsersList;
    String uid =
        Provider.of<AuthProvider>(context, listen: false).getUserInfo().uid;
    users.removeWhere((element) => element.uid == uid);
    return users;
  }

  openConversation(int index) {
    User chatUser = Provider.of<ChatSocketProvider>(context, listen: false)
        .chatUsersList[index];
    Provider.of<NavigationProvider>(context, listen: false)
        .navigateToWithArgs(Routes.CONVERSATION_SCREEN, chatUser);
  }
}
