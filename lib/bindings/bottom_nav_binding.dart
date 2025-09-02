import 'package:get/get.dart';
import 'package:laihan01/controllers/bottom_nav_controller.dart';

class BottomNavPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put (BottomNavController());
    // hanya dipanggil sekali saat pertama kali halaman diakses

  }

}