import 'dart:convert';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_chat_app/utils/constants.dart';
import 'package:open_chat_app/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final http.Client client = http.Client();
  final Connectivity connectivity = Connectivity();
  final SharedPreferences sharedPreferences;

  Api(this.sharedPreferences);

  request(item, [params, body]) async {
    switch (item) {
      case Constants.appName:
        return await createRequest(item, params, body, Method.GET,
            HeaderTypes.AUTHENTICATED, Service.LOGIN);
    }
  }

  getURL(Service service, item, Map<String, dynamic> params) {
    String url = dotenv.env['API_ADDRESS']!;
    switch (service) {
      case Service.CHAT:
        url = dotenv.env['API_ADDRESS']!;
        break;
      case Service.LOGIN:
        url = dotenv.env['LOGIN_API_ADDRESS']!;
        break;
    }
    return Uri.https(url, item, params);
  }

  createRequest(item, params, body, Method method, HeaderTypes headerTypes,
      Service service) async {
    Response response;
    if (body == null) {
      body = "";
    }
    body = jsonEncode(body);
    if (params == null) {
      params = <String, dynamic>{};
    }
    switch (method) {
      case Method.GET:
        response = await client.get(getURL(service, item, params!),
            headers: await getHeaders(headerTypes));
        break;
      case Method.POST:
        response = await client.post(getURL(service, item, params!),
            headers: await getHeaders(headerTypes), body: body);
        break;
      case Method.PUT:
        response = await client.put(getURL(service, item, params!),
            headers: await getHeaders(headerTypes), body: body);
        break;
      case Method.DELETE:
        response = await client.delete(getURL(service, item, params!),
            headers: await getHeaders(headerTypes));
        break;
    }

    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode != 200) {
      var connectivityResult = await (connectivity.checkConnectivity());
      if (!(connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi)) {
        toastInfo(Constants.internet_error);
      } else {
        Future.error("ERROR in Request: " +
            item.toString() +
            " " +
            response.statusCode.toString());
        toastInfo(Constants.server_error);
      }
    }
    return "";
  }

  toastInfo(String info, {int seconds = 3}) {
    showToast(info,
        position: ToastPosition.bottom,
        backgroundColor: Color(0xaaeeeeee),
        radius: 25,
        textStyle: TextStyle(color: Colors.grey, fontSize: 20),
        textPadding: EdgeInsets.all(15),
        dismissOtherToast: false,
        duration: Duration(seconds: seconds));
  }

  getHeaders(HeaderTypes headerTypes) {
    switch (headerTypes) {
      case HeaderTypes.AUTHENTICATED:
        return;
      case HeaderTypes.NON_AUTHENTICATED:
        return;
      case HeaderTypes.FOR_AUTHENTICATION:
        return;
    }
  }
}
