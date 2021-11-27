import 'package:flutter/cupertino.dart';
import 'package:open_chat_app/screens/authentication.dart';
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
    };
  }
}

///
///  All constants related to routes
class Routes {
  static const String HOME_PAGE = 'home_page';
  static const String SPLASH_SCREEN = 'splash_screen_page';
  static const String AUTH_PAGE = 'authentication_page';
}

///Navigation Service to navigate user to the desired screen without using context.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateAndReplaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
