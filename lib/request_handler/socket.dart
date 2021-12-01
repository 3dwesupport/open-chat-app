import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_chat_app/providers/data_provider.dart';
import 'package:open_chat_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class SocketConnection {
  connect() async {
    SharedPreferences sharedPreferences = get();
    String token = sharedPreferences.getString(Constants.token)!;
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: token
    };
    var channel = IOWebSocketChannel.connect(
        Uri.parse(dotenv.env['SOCKET_CONNECT']!),
        headers: headers);
    channel.stream.listen((message) {
      print("connected");
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }
}

//
