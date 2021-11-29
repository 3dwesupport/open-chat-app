import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:open_chat_app/request_handler/request_handler.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_provider.dart';

GetIt get = GetIt.instance;
final navigatorKey = new GlobalKey<NavigatorState>();

Future<void> init() async {
  get.registerLazySingleton(() => NavigationService(navigatorKey));
  get.registerLazySingleton(() => Api(get(), get()));
  final sharedPreferences = await SharedPreferences.getInstance();
  get.registerLazySingleton(() => sharedPreferences);
  get.registerLazySingleton(() => http.Client());
  get.registerFactory(() => AuthProvider(sharedPreferences: get(), api: get()));
}

getProviders() {
  return [
    ChangeNotifierProvider(create: (context) => get<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => get<NavigationService>()),
  ];
}
