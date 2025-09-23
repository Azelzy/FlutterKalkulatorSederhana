import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  //save username ke shared preferences
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    if (usernameController.text.toString() == "admin" &&
        passwordController.text.toString() == "admin") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", usernameController.text.toString());
    } else {
      Get.snackbar("error", "incorrect username and password");
    }
  }
}
