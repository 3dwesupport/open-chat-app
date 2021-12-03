import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/providers/chat_socket_provider.dart';
import 'package:open_chat_app/providers/navigation_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:open_chat_app/utils/strings.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  bool isSearching = false;
  TextEditingController searchUserController = TextEditingController();
  FocusNode searchUserFocusNode = FocusNode();
  List<User> searchedUsers = [];

  @override
  void initState() {
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isSearching)
      return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => setSearch(),
                      icon: Icon(Icons.arrow_back_ios)),
                  Container(
                    width: 250,
                    child: TextField(
                      onChanged: (val) => onSearchTextChange(val),
                      controller: searchUserController,
                      focusNode: searchUserFocusNode,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search User"),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: CustomColors.themeOrange,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, int index) => InkWell(
                          onTap: () => openConversation(searchedUsers[index]),
                          child: Container(
                            margin: EdgeInsets.all(10),
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
                                  searchedUsers[index].firstName.toTitleCase() +
                                      " " +
                                      searchedUsers[index]
                                          .lastName
                                          .toTitleCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: searchedUsers.length))
          ],
        )),
      );

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
            onPressed: () => setSearch(),
            color: Colors.black54,
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black87,
            ),
            color: Colors.white,
            onSelected: (result) {
              if (result == 0) {
                goToEditDetails();
              } else if (result == 1) {
                logout();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  value: 0, child: Container(child: Text("Edit Details"))),
              PopupMenuItem(
                  value: 1,
                  child: Container(
                    child: Text("Logout"),
                  ))
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: getOnlineUsers().length,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () => openConversation(getOnlineUsers()[index]),
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

  openConversation(chatUser) {
    Provider.of<NavigationProvider>(context, listen: false)
        .navigateToWithArgs(Routes.CONVERSATION_SCREEN, chatUser);
  }

  void goToEditDetails() async {
    await Provider.of<NavigationProvider>(context, listen: false)
        .navigateTo(Routes.EDIT_DETAILS_SCREEN);
  }

  logout() async {
    await Provider.of<AuthProvider>(context, listen: false).logout(context);
  }

  setSearch() {
    isSearching = !isSearching;
    setState(() {});
  }

  onSearchTextChange(String val) async {
    searchedUsers =
        await Provider.of<AuthProvider>(context, listen: false).searchUser(val);
    print(searchedUsers.length);
    setState(() {});
  }
}
