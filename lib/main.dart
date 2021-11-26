import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_chat_app/routes.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      routes: SetupRoutes.routes,
      initialRoute: SetupRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
