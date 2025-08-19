import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:laihan01/pages/calculator_page.dart';
import 'package:laihan01/pages/football_edit_page.dart';
import 'package:laihan01/pages/football_page.dart';
import 'package:laihan01/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.calculator, page: () => CalculatorPage()),
    GetPage(name: AppRoutes.footballplayers, page: () => Footballpage()),
    GetPage(
      name: AppRoutes.footballedit,
      page: () => const FootballEditPage(),
    ),
  ];
}