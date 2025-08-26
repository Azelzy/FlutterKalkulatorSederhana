import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import 'calculator_page.dart';
import 'football_page.dart';
import 'profile_page.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [CalculatorPage(), Footballpage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 2)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 0
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.calculate,
                    size: 16,
                    color: controller.currentIndex.value == 0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "CALC",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 1
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 16,
                    color: controller.currentIndex.value == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "PLAYERS",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == 2
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: controller.currentIndex.value == 2
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                label: "PROFILE",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
