import 'package:flutter/cupertino.dart';
import 'package:open_chat_app/screens/authentication/authentication.dart';
import 'package:open_chat_app/screens/authentication/signup.dart';
import 'package:open_chat_app/screens/splash_screen.dart';

import '../screens/homepage.dart';

class SetupRoutes {
  /// Set initial route here
  static String initialRoute = Routes.SPLASH_SCREEN;

  /// Add entry for new route here
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME_PAGE: (context) => Homepage(),
      Routes.SPLASH_SCREEN: (context) => SplashScreen(),
      Routes.AUTH_PAGE: (context) => Authentication(),
      Routes.SIGN_UP: (context) => SignUp(),
    };
  }
}

///
///  All constants related to routes
class Routes {
  static const String HOME_PAGE = 'home_page';
  static const String SPLASH_SCREEN = 'splash_screen_page';
  static const String AUTH_PAGE = 'authentication_page';
  static const String SIGN_UP = 'signup_page';
}

///Navigation Service to navigate user to the desired screen without using context.
class NavigationService extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this.navigatorKey);

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateAndReplaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
