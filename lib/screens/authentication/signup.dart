import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_chat_app/components/user_profile_input.dart';
import 'package:open_chat_app/models/user_model.dart';
import 'package:open_chat_app/providers/auth_provider.dart';
import 'package:open_chat_app/providers/navigation_provider.dart';
import 'package:open_chat_app/routes/routes.dart';
import 'package:open_chat_app/utils/custom_colors.dart';
import 'package:open_chat_app/utils/strings.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  FocusNode fNameFocusNode = FocusNode();
  FocusNode lNameFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.splashBg,
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text(
            "Add Details",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: UserProfileInput(
                    labelText: 'First Name',
                    key: Key("firstname"),
                    mobileNumController: fNameController,
                    mobileFocusNode: fNameFocusNode,
                    keyboardType: TextInputType.name,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: UserProfileInput(
                    labelText: 'Last Name',
                    key: Key("lastname"),
                    mobileNumController: lNameController,
                    mobileFocusNode: lNameFocusNode,
                    keyboardType: TextInputType.name,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: UserProfileInput(
                    labelText: 'Username',
                    key: Key("username"),
                    mobileNumController: usernameController,
                    mobileFocusNode: usernameFocusNode,
                    keyboardType: TextInputType.name,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: UserProfileInput(
                    labelText: 'Phone Number',
                    key: Key("phone"),
                    enabled: false,
                    mobileNumController: phoneController,
                    mobileFocusNode: phoneFocusNode,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        primary: Colors.white,
                        minimumSize: Size(200, 40)),
                    child: Text(
                      Strings.save_changes.toTitleCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => saveUserData(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void loadData() {
    User user = Provider.of<AuthProvider>(context, listen: false).getUserInfo();
    fNameController.text = user.firstName;
    lNameController.text = user.lastName;
    usernameController.text = user.username;
    phoneController.text = user.phone;
  }

  saveUserData() async {
    User user = User(
        uid: '',
        firstName: fNameController.text,
        lastName: lNameController.text,
        online: 'Y',
        phone: phoneController.text,
        userImgUrl: '',
        username: usernameController.text,
        appUser: true);
    await Provider.of<AuthProvider>(context, listen: false).saveUserData(user);
    await Provider.of<NavigationProvider>(context, listen: false)
        .navigateAndReplaceTo(Routes.HOME_PAGE);
  }
}
