import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool auth = false;

  @override
  void initState() {
    checkAuthAndRedirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.splashBg,
      body: Container(
          margin: EdgeInsets.all(50),
          child: Center(
              child: Image(
                  image: AssetImage(
                      'assets/logos/open_chat_logo_with_text.png')))),
    );
  }

  void checkAuthAndRedirect() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (auth) {
        Navigator.of(context).pushNamed(Routes.HOME_PAGE);
      } else {
        Navigator.of(context).pushNamed(Routes.AUTH_PAGE);
      }
    });
  }
}
