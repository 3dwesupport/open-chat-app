import 'package:flutter/cupertino.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/navigation_provider.dart';
import 'package:open_chat_app/request_handler/request_handler.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:open_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

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
    return User(
        uid: '',
        online: '',
        firstName: '',
        lastName: '',
        username: "",
        phone: "",
        userImgUrl: "");
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
      if (result["user"]["appuser"] != null && result["user"]["appuser"]) {
        return Routes.HOME_SCREEN;
      }
      return Routes.SIGN_UP_SCREEN;
    } else {
      return Routes.AUTH_PAGE;
    }
  }

  saveUserData(User updatedUser) async {
    user!
      ..firstName = updatedUser.firstName
      ..lastName = updatedUser.lastName
      ..online = updatedUser.online
      ..username = updatedUser.username
      ..userImgUrl = updatedUser.userImgUrl
      ..appUser = updatedUser.appUser;
    await api.request(Constants.update_user, {}, user!.toJson());
  }

  logout(context) async {
    user = null;
    await sharedPreferences.clear();
    Provider.of<NavigationProvider>(context, listen: false)
        .navigateAndReplaceTo(Routes.AUTH_PAGE);
  }

  searchUser(String searchString) async {
    var usersList = await api
        .request(Constants.search_user, {"searchstring": searchString});
    List<User> users = [];
    if (usersList != null) {
      for (var user in usersList) {
        users.add(User.fromJson(user));
      }
    }
    return users;
  }
}
