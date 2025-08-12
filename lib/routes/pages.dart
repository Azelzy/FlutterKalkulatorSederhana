import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:laihan01/pages/calculator_page.dart';
import 'package:laihan01/pages/football_edit_page.dart';
import 'package:laihan01/pages/football_page.dart';
import 'package:laihan01/routes/routes.dart';
import '../models/football_model.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.calculator, page: () => CalculatorPage()),
    GetPage(name: AppRoutes.footballplayers, page: () => Footballpage()),
    GetPage(
      name: AppRoutes.footballedit,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return FootballEditPage(
          index: args['index'] as int,
          player: args['player'] as Player,
          isNewPlayer: args['isNewPlayer'] as bool? ?? false,
        );
      },
    ),
  ];
}
