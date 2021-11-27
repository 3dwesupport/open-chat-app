import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/io.dart';

class SocketConnection {
  connect() async {
    String vars = dotenv.env['TOKEN']!;
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: vars
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
