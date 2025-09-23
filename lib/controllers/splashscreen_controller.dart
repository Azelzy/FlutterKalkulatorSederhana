import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laihan01/routes/routes.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    //cek if username is stored
    checkLogin();
  }

  checkLogin() async {
    await Future.delayed(Duration(seconds: 5)); // Simulate a delay for splash screen
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString("username");
    if (savedUsername != null) {
      Get.offAllNamed(AppRoutes.bottomNav);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}