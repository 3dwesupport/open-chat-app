import 'package:flutter/cupertino.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/request_handler/request_handler.dart';
import 'package:open_chat_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  bool isLoggedIn = false;
  final SharedPreferences sharedPreferences;
  final Api api;
  bool existingUser = false;

  AuthProvider({required this.sharedPreferences, required this.api});

  sendOTP(phone, otp) async {
    var result = await api.request(
        Constants.send_login_otp, {}, "", {"phone": phone, "otp": otp});
    if (result != null && result["otp_sent"]) {
      existingUser = result["existinguser"];
      return result;
    }
    return {"otp_sent": false};
  }

  getUserInfo() {
    if (user != null) {
      return user;
    }
    return User(uid: '', online: '', firstName: '', lastName: '');
  }

  otpVerified(phone) async {
    var result;
    if (existingUser) {
      result = await api.request(
          Constants.login, {}, "", {"phone": phone, "countrycode": '+91'});
    } else {
      result = await api.request(Constants.add_new_user, {}, "",
          {"phone": phone, "countrycode": "+91", "ipaddress": ""});
    }
    await sharedPreferences.setString(Constants.token, result["token"]);
    user = User.fromJson(result["user"]);
  }

  checkUserAuth() async {
    var result = await api.request(Constants.check_auth);
    if (result != null && result != "") {
      await sharedPreferences.setString(Constants.token, result["token"]);
      user = User.fromJson(result["user"]);
      return true;
    } else {
      return false;
    }
  }
}
