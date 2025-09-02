import 'package:get/get.dart';
import 'package:laihan01/controllers/bottom_nav_controller.dart';
import 'package:laihan01/controllers/calculator_controller.dart';
import 'package:laihan01/controllers/football_controller.dart';

class BottomNavPageBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut for main bottom nav controller
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    
    // Lazily register all tab controllers
    Get.lazyPut<CalculatorController>(() => CalculatorController());
    Get.lazyPut<FootballController>(() => FootballController());
  }
}