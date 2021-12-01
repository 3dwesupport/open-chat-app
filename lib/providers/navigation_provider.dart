import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationProvider(this.navigatorKey);

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateAndReplaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
