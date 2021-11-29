import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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
  final http.Client client;
  final Connectivity connectivity = Connectivity();
  final SharedPreferences sharedPreferences;

  Api(this.sharedPreferences, this.client);

  request(item, [Map<String, String>? params, body, extraParams]) async {
    switch (item) {
      case Constants.send_login_otp:
        return await createRequest(
            item,
            params,
            body,
            Method.POST,
            HeaderTypes.FOR_AUTHENTICATION,
            Service.LOGIN,
            extraParams['phone'],
            extraParams["otp"]);
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

  createRequest(item, Map<String, String>? params, body, Method method,
      HeaderTypes headerTypes, Service service,
      [phone, otp]) async {
    Response response;
    if (body == null) {
      body = "";
    }
    body = jsonEncode(body);
    if (params == null) {
      params = <String, String>{};
    }
    switch (method) {
      case Method.GET:
        response = await client.get(getURL(service, item, params),
            headers: await getHeaders(headerTypes, phone, otp));
        break;
      case Method.POST:
        response = await client.post(getURL(service, item, params),
            headers: await getHeaders(headerTypes, phone, otp), body: body);
        break;
      case Method.PUT:
        response = await client.put(getURL(service, item, params),
            headers: await getHeaders(headerTypes, phone, otp), body: body);
        break;
      case Method.DELETE:
        response = await client.delete(getURL(service, item, params),
            headers: await getHeaders(headerTypes, phone, otp));
        break;
    }

    if (response.statusCode == 200) {
      if (response.body != "") {
        return json.decode(response.body);
      }
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

  getHeaders(HeaderTypes headerTypes, String? phone, String? otp) {
    switch (headerTypes) {
      case HeaderTypes.AUTHENTICATED:
        return;
      case HeaderTypes.NON_AUTHENTICATED:
        return;
      case HeaderTypes.FOR_AUTHENTICATION:
        final jwt = JWT({
          "otp": otp != null ? otp : "",
          "phone": phone!,
          "countrycode": "+91",
          "source": "app",
          "ipaddress": ""
        });
        String key = dotenv.env['OTP_TOKEN_KEY']!;
        var token = jwt.sign(SecretKey(key));
        return <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        };
    }
  }
}
