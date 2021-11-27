import 'package:get_it/get_it.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

GetIt get = GetIt.instance;

Future<void> init() async {
  get.registerLazySingleton(() => NavigationService(get()));
  get.registerFactory(() => AuthProvider());
}

getProviders() {
  return [
    ChangeNotifierProvider(create: (context) => get<AuthProvider>()),
  ];
}
