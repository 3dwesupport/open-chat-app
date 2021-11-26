import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class SocketConnection {
  connect() async {
    String vars =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRob3JpemVkIjp0cnVlLCJleHAiOjE2NDA1MTY4MTcsInJvbGUiOiJhZG1pbiIsInN0YXR1cyI6ImZyZWUiLCJ1aWQiOiJhOTJkOWY2Yy04NDZmLTQxYWUtOWEzYy0yZjU2OTBhNWY3NzIifQ.u6yX6zXtykm-QO06sbk-8oxKEVSA1G84zzBb8ryzOd4";
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: vars
    };
    var channel = IOWebSocketChannel.connect(
        Uri.parse('wss://chatdev.itinkerserver.com/connect'),
        headers: headers);
    channel.stream.listen((message) {
      print("egge");
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
  }
}

//
