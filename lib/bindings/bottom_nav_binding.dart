import 'package:get/get.dart';
import 'package:laihan01/controllers/bottom_nav_controller.dart';
import 'package:laihan01/controllers/calculator_controller.dart';
import 'package:laihan01/controllers/football_controller.dart';

class BottomNavPageBinding extends Bindings {
  @override
  void dependencies() {
    // Use put for main bottom nav controller to ensure it's available immediately
    Get.put<BottomNavController>(BottomNavController());
    
    // Lazily register all tab controllers
    Get.lazyPut<CalculatorController>(() => CalculatorController());
    Get.lazyPut<FootballController>(() => FootballController());
  }
}