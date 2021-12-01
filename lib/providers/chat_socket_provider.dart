import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/request_handler/request_handler.dart';
import 'package:open_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class ChatSocketProvider extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  Api api;
  late IOWebSocketChannel channel;
  List<User> _chatUsers = [];

  List<User> get chatUsersList => _chatUsers;

  ChatSocketProvider({required this.sharedPreferences, required this.api});

  connect(reload) async {
    await api.request(Constants.set_user_online);
    String token = sharedPreferences.getString(Constants.token)!;
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: token
    };
    channel = IOWebSocketChannel.connect(
        Uri.parse(dotenv.env['SOCKET_CONNECT']!),
        headers: headers);
    channel.stream.listen((message) {
      print(message);
      message = jsonDecode(message);
      _handleSocketMessages(message["eventname"], message["eventpayload"]);
      reload.call();
    });
  }

  void sendMessage(context, msg, toUserID) {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    channel.sink.add(jsonEncode({
      "eventname": "message",
      "eventpayload": {"message": msg, "fromUserID": uid, "toUserID": toUserID}
    }));
  }

  getConversation(context, withUID) async {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    var x = await api.request(
        Constants.get_conversation, {"toUserID": withUID, "fromUserID": uid});
    print(x);
  }

  _handleSocketMessages(eventName, eventPayload) {
    switch (eventName) {
      case "chatlist-response":
        _handleChatUpdate(eventPayload["type"], eventPayload["chatlist"]);
        break;
      case "message-response":
        _handleMessageUpdate(eventPayload["fromuid"], eventPayload["touid"],
            eventPayload["message"]);
    }
  }

  void _handleChatUpdate(type, chatList) {
    switch (type) {
      case "my-chat-list":
        for (var user in chatList) {
          _chatUsers.add(User.fromJson(user));
        }
        break;
      case "new-user-joined":
        _chatUsers.add(User.fromJson(chatList));
        break;
      case "user-disconnected":
        _chatUsers.removeWhere((element) => element.uid == chatList["uid"]);
    }
  }

  void _handleMessageUpdate(fromUID, toUID, message) {

  }
}
