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
  bool existingUser = false;
  bool appUser = false;
  String otp = "";
  int formIndex = 0;

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
      existingUser = result["existinguser"];
      appUser = result["existingsource"];
      setState(() {
        formIndex = 1;
      });
    }
  }

  submitOTP() {
    if (otpController.text == otp) {
      Provider.of<NavigationService>(context,listen: false)
          .navigateAndReplaceTo(Routes.HOME_PAGE);
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
