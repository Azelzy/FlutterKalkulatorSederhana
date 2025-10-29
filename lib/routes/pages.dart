import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:laihan01/bindings/bottom_nav_binding.dart';
import 'package:laihan01/bindings/notification_binding.dart';
import 'package:laihan01/bindings/calculator_binding.dart';
import 'package:laihan01/bindings/football_binding.dart';
import 'package:laihan01/bindings/football_edit_binding.dart';
import 'package:laihan01/bindings/contact_binding.dart';
import 'package:laihan01/pages/calculator_page.dart';
import 'package:laihan01/pages/football_edit_page.dart';
import 'package:laihan01/pages/football_page.dart';
import 'package:laihan01/pages/login_page.dart';
import 'package:laihan01/pages/contact_page.dart';
import 'package:laihan01/routes/routes.dart';
import 'package:laihan01/pages/bottom_nav_page.dart';
import 'package:laihan01/pages/splashscreen_page.dart';
import 'package:laihan01/bindings/splashscreen_binding.dart';
import 'package:laihan01/bindings/login_binding.dart';
import 'package:laihan01/bindings/example_binding.dart';
import 'package:laihan01/pages/example_page.dart';
import 'package:laihan01/pages/login_api_page.dart';
import 'package:laihan01/bindings/login_api_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.calculator,
      page: () => const CalculatorPage(),
      bindings: [CalculatorBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.footballplayers,
      page: () => Footballpage(),
      bindings: [FootballBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.footballedit,
      page: () => const FootballEditPage(),
      bindings: [FootballEditBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => BottomNavPage(),
      bindings: [BottomNavPageBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashscreenPage(),
      bindings: [SplashscreenBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      bindings: [LoginBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactPage(),
      bindings: [ContactBinding(), NotificationBinding()],
    ),
    // Add other pages here as needed
    GetPage(
      name: AppRoutes.example,
      page: () => ExamplePage(),
      bindings: [ExampleBinding(), NotificationBinding()],
    ),
    GetPage(
      name: AppRoutes.loginApi,
      page: () => const LoginApiPage(),
      bindings: [LoginApiBinding(), NotificationBinding()],
    ),
  ];
}
