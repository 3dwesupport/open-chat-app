import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_chat_app/providers/data_provider.dart' as dp;
import 'package:open_chat_app/providers/data_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await dp.init();
  runApp(MultiProvider(providers: dp.getProviders(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      navigatorKey: navigatorKey,
      routes: SetupRoutes.routes,
      initialRoute: SetupRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
    ));
  }
}
