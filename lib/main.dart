import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:laihan01/routes/pages.dart';
import 'package:laihan01/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splashscreen, // arahkan ke bottom nav
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
