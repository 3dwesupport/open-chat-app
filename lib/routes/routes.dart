import 'package:flutter/cupertino.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/screens/authentication/authentication.dart';
import 'package:open_chat_app/screens/authentication/signup.dart';
import 'package:open_chat_app/screens/conversation.dart';
import 'package:open_chat_app/screens/edit_details.dart';
import 'package:open_chat_app/screens/splash_screen.dart';

import '../screens/homepage.dart';

class SetupRoutes {
  /// Set initial route here
  static String initialRoute = Routes.SPLASH_SCREEN;

  /// Add entry for new route here
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME_SCREEN: (context) => Homepage(),
      Routes.SPLASH_SCREEN: (context) => SplashScreen(),
      Routes.AUTH_PAGE: (context) => Authentication(),
      Routes.SIGN_UP_SCREEN: (context) => SignUp(),
      Routes.EDIT_DETAILS_SCREEN: (context) => EditDetails(),
      Routes.CONVERSATION_SCREEN: (context) =>
          Conversation(ModalRoute.of(context)!.settings.arguments as User),
    };
  }
}

///
///  All constants related to routes
class Routes {
  static const String HOME_SCREEN = 'home_page';
  static const String SPLASH_SCREEN = 'splash_screen_page';
  static const String AUTH_PAGE = 'authentication_page';
  static const String SIGN_UP_SCREEN = 'signup_page';
  static const String CONVERSATION_SCREEN = 'conversation_screen';
  static const String EDIT_DETAILS_SCREEN = 'edit_details_page';
}
