import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_chat_app/providers/data_provider.dart' as dp;
import 'package:open_chat_app/providers/data_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  dp.init();
  runApp(MultiProvider(providers: dp.getProviders(), child: MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      navigatorKey: navigatorKey,
      routes: SetupRoutes.routes,
      initialRoute: SetupRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
    ));
  }
}
