import 'package:flutter/cupertino.dart';

import 'homepage.dart';

class SetupRoutes {
  /// Set initial route here
  static String initialRoute = Routes.HOME_PAGE;

  /// Add entry for new route here
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME_PAGE: (context) => Homepage(),
    };
  }
}

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

class Routes {
  static const String HOME_PAGE = 'home_page';
}
