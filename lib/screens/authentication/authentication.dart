import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';

import 'get_login_details.dart';

class Authentication extends StatefulWidget {
  AuthenticationState createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  TextEditingController mobileNumController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  String otp = "";
  int formIndex = 0;
  bool appUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.splashBg,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: IndexedStack(
          index: formIndex,
          children: [
            MobileNumDetails(mobileNumController, mobileFocusNode, sendOTP),
            OTPDetails(otpController, otpFocusNode, submitOTP)
          ],
        ),
      ),
    );
  }

  sendOTP() async {
    otp = randomOtp().toString();
    print(otp);
    var result = await Provider.of<AuthProvider>(context, listen: false)
        .sendOTP(mobileNumController.text, otp);
    if (result["otp_sent"]) {
      appUser = result["existingsource"];
      setState(() {
        formIndex = 1;
      });
    }
  }

  submitOTP() async {
    if (otpController.text == otp) {
      await Provider.of<AuthProvider>(context, listen: false)
          .otpVerified(mobileNumController.text);
      if (appUser) {
        Provider.of<NavigationService>(context, listen: false)
            .navigateAndReplaceTo(Routes.HOME_PAGE);
      } else {
        Provider.of<NavigationService>(context, listen: false)
            .navigateAndReplaceTo(Routes.SIGN_UP);
      }
    }
  }

  int randomOtp() {
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);
    return rNum;
  }
}
