import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  var isLoggingOut = false.obs;

  void changeTabIndex(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }

  String get currentPageTitle {
    switch (currentIndex.value) {
      case 0:
        return 'CALCULATORS';
      case 1:
        return 'PEMAINS';
      case 2:
        return 'CONTACTS';
      case 3:
        return 'PROFILS';
      default:
        return '';
    }
  }

  void logout() async {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.black, width: 3),
        ),
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Text(
            'KONFIRMASI LOGOUT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14,
            ),
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'BATAL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () async {
                Get.back(); // Close dialog
                await _performLogout();
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _performLogout() async {
    isLoggingOut.value = true;
    
    try {
      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');
      
      // Show success message
      Get.snackbar(
        "LOGOUT BERHASIL",
        "Anda telah keluar dari aplikasi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to login page and clear all previous routes
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoutes.loginApi);
    } catch (e) {
      Get.snackbar(
        "ERROR",
        "Terjadi kesalahan saat logout",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.2),
        colorText: Colors.black,
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}