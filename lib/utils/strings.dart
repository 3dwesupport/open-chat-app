class Strings {
  static const String app_name = "Open Chat";
  static const String login = "login";
  static const String mobile_number = "Mobile Number";
  static const String send_otp = "Send OTP";
  static const String verify_otp = "Verify OTP";
  static const String sent_a_code = "We have sent a code";
}

extension Casing on String {
  String toTitleCase() => this.toLowerCase().split(' ').map((word) {
        String leftText =
            (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText.toLowerCase();
      }).join(' ');
}
