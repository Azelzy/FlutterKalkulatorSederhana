// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: const Text(
              "BURGIR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(Icons.calculate, color: Colors.black),
            ),
            title: const Text(
              "CALCULATOR",
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
            onTap: () {
              final controller = Get.find<BottomNavController>();
              controller.changeTabIndex(0);
              Get.back();
            },
          ),
          const Divider(height: 1, color: Colors.black),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(Icons.sports_soccer, color: Colors.black),
            ),
            title: const Text(
              "FOOTBALL",
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
            onTap: () {
              final controller = Get.find<BottomNavController>();
              controller.changeTabIndex(1);
              Get.back();
            },
          ),
          const Divider(height: 1, color: Colors.black),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(Icons.person, color: Colors.black),
            ),
            title: const Text(
              "PROFILE",
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
            onTap: () {
              final controller = Get.find<BottomNavController>();
              controller.changeTabIndex(2);
              Get.back();
            },
          ),
          const Divider(height: 1, color: Colors.black),
        ],
      ),
    );
  }
}
