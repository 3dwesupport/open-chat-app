import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/components/custom_text_field.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:open_chat_app/utils/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MobileNumDetails extends StatelessWidget {
  final FocusNode mobileFocusNode;
  final TextEditingController mobileNumController;
  final onSendOTP;

  MobileNumDetails(
      this.mobileNumController, this.mobileFocusNode, this.onSendOTP);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/logos/open_chat_logo.png'),
            height: 126,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Strings.login.toTitleCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30),
          child: CustomTextField(
            labelText: Strings.mobile_number.toTitleCase(),
            mobileFocusNode: mobileFocusNode,
            mobileNumController: mobileNumController,
            key: Key(Strings.mobile_number),
            prefixIcon: Icon(
              Icons.local_phone,
              color: CustomColors.themeOrange,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                primary: Colors.white,
                minimumSize: Size(double.infinity, 40)),
            child: Text(
              Strings.send_otp,
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => onSendOTP(),
          ),
        ),
      ],
    );
  }
}

class OTPDetails extends StatelessWidget {
  final otpFocusNode;
  final otpController;
  final submitOTP;

  OTPDetails(this.otpController, this.otpFocusNode, this.submitOTP);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/logos/open_chat_logo.png'),
            height: 126,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Strings.sent_a_code.toTitleCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        PinCodeTextField(
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.scale,
          cursorColor: Colors.black,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 45,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            activeColor: Colors.white,
            inactiveFillColor: Colors.grey[300],
            inactiveColor: Colors.grey[300],
            selectedColor: Colors.grey[200],
            selectedFillColor: Colors.grey[200],
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          boxShadows: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                color: Colors.black26,
                offset: Offset.fromDirection(90, 4))
          ],
          enableActiveFill: true,
          controller: otpController,
          onCompleted: (v) {
            submitOTP();
          },
          onChanged: (String value) {},
          appContext: context,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                primary: Colors.white,
                minimumSize: Size(double.infinity, 40)),
            child: Text(
              Strings.verify_otp,
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => submitOTP(),
          ),
        ),
      ],
    );
  }
}
