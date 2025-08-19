import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import 'calculator_page.dart';
import 'football_page.dart';
import 'profile_page.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({super.key});
  // Initialize the BottomNavController
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    CalculatorPage(),   // Tab 1
    Footballpage(),     // Tab 2
    ProfilePage(),      // Tab 3
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: "Calculator",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer),
                label: "Football",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ));
  }
}
