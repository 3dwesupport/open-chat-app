class Constants {
  static const String appName = "Open Chat";

  ///Requests
  /// Login Requests
  static const String login = '/login';
  static const String add_new_user = '/adduser';
  static const String send_login_otp = '/sendloginotp';
  static const String check_auth = '/checkauth';
  static const String update_user = '/updateuser';

  /// Chat Requests
  static const String get_conversation = "";

  ///ERRORS
  static const String internet_error = "Your Internet is not Working Properly";
  static const String server_error = "Server Internal Error, please wait";

  ///Shared Prefs
  static const String token = "user-auth-token";
}
