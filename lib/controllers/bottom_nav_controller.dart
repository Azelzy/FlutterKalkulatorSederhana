import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    if (index >= 0 && index <= 2) {
      currentIndex.value = index;
    }
  }

  String get currentPageTitle {
    switch (currentIndex.value) {
      case 0:
        return 'CALCULATORS';
      case 1:
        return 'PEMAINS';
      case 2:
        return 'PROFILS';
      default:
        return '';
    }
  }
}
