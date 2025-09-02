import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:laihan01/bindings/bottom_nav_binding.dart';
import 'package:laihan01/bindings/calculator_binding.dart';
import 'package:laihan01/bindings/football_binding.dart';
import 'package:laihan01/bindings/football_edit_binding.dart';
import 'package:laihan01/pages/calculator_page.dart';
import 'package:laihan01/pages/football_edit_page.dart';
import 'package:laihan01/pages/football_page.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:laihan01/pages/bottom_nav_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.calculator, page: () => CalculatorPage(),binding: CalculatorBinding()),
    GetPage(name: AppRoutes.footballplayers, page: () => Footballpage(),binding: FootballBinding()),
    GetPage(name: AppRoutes.footballedit,page: () => const FootballEditPage(),binding: FootballEditBinding()),
    GetPage(name: AppRoutes.bottomNav, page: () => BottomNavPage(),binding: BottomNavPageBinding()),
    
    // Add other pages here as needed
  ];
}