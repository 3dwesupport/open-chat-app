import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // checkAuthAndRedirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
      body: Center(child: Text("Hello World! I am Splash Screen")),
    );
  }

  void checkAuthAndRedirect() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      bool auth = true;
      if (auth) {
        Navigator.of(context).pushNamed(Routes.HOME_PAGE);
      } else {
        Navigator.of(context).pushNamed(Routes.AUTH_PAGE);
      }
    });
  }
}
