import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenPage extends StatelessWidget {
  SplashscreenPage({super.key});

  final SplashscreenController controller = Get.find<SplashscreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("INI SPLASHSCREEN")),
    );
  }
}
