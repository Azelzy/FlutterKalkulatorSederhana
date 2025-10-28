import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laihan01/models/login_model.dart';
import 'package:laihan01/networks/client_network.dart';
import 'package:laihan01/routes/routes.dart';

class LoginApiController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginApi() async {
    print('\n========================================');
    print('LOGIN API STARTED');
    print('========================================');

    // Validasi input
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "ERROR [VALIDATION]",
        "Username dan password tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[300],
        colorText: Colors.black,
        icon: const Icon(Icons.warning, color: Colors.red),
      );
      return;
    }

    isLoading.value = true;

    try {
      final requestData = {
        'username': usernameController.text,
        'password': passwordController.text,
      };

      print('\nSending request...');
      final response = await http.post(
        Uri.parse(ClientNetwork.login),
        body: requestData,
      );

      print('\nRESPONSE DETAILS:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}\n');

      LoginModel? loginModel;
      try {
        loginModel = loginModelFromJson(response.body);
      } catch (e) {
        print('JSON Parse Error: $e');
      }

      // Snackbar builder helper (biar rapi)
      void showSnackbar(String title, String message, Color bgColor, IconData icon) {
        Get.snackbar(
          title,
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: bgColor,
          colorText: Colors.black,
          icon: Icon(icon, color: Colors.black87),
          duration: const Duration(seconds: 3),
        );
      }

      // Tangani berdasarkan status code
      switch (response.statusCode) {
        case 200:
          print('Status 200 OK');
          if (loginModel != null && loginModel.status) {
            // Simpan token
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', loginModel.token);

            showSnackbar(
              "SUCCESS [${response.statusCode}]",
              "Pesan: ${loginModel.message}",
              Colors.green[200]!,
              Icons.check_circle,
            );

            isLoading.value = false;
            Get.offAllNamed(AppRoutes.bottomNav);
          } else {
            showSnackbar(
              "FAILED [${response.statusCode}]",
              "Pesan: ${loginModel?.message ?? 'Login gagal tanpa pesan JSON'}",
              Colors.orange[200]!,
              Icons.warning_amber_rounded,
            );
            isLoading.value = false;
          }
          break;

        case 400:
          showSnackbar(
            "ERROR [400]",
            "Bad Request — ${loginModel?.message ?? 'Periksa kembali data yang dikirim'}",
            Colors.orange[200]!,
            Icons.error_outline,
          );
          isLoading.value = false;
          break;

        case 401:
          showSnackbar(
            "ERROR [401]",
            "Unauthorized — ${loginModel?.message ?? 'Username atau password salah!'}",
            Colors.red[200]!,
            Icons.lock_outline,
          );
          isLoading.value = false;
          break;

        case 404:
          showSnackbar(
            "ERROR [404]",
            "Not Found — ${loginModel?.message ?? 'Endpoint tidak ditemukan di server'}",
            Colors.red[200]!,
            Icons.search_off,
          );
          isLoading.value = false;
          break;

        case 500:
          showSnackbar(
            "ERROR [500]",
            "Server Error — ${loginModel?.message ?? 'Terjadi kesalahan pada server'}",
            Colors.red[300]!,
            Icons.warning_amber,
          );
          isLoading.value = false;
          break;

        default:
          showSnackbar(
            "ERROR [${response.statusCode}]",
            "Terjadi kesalahan — ${loginModel?.message ?? 'Tidak diketahui'}",
            Colors.red[100]!,
            Icons.error,
          );
          isLoading.value = false;
      }

      print('========================================');
      print('LOGIN API FINISHED');
      print('========================================\n');
    } catch (e) {
      isLoading.value = false;
      print('Exception: $e');
      Get.snackbar(
        "ERROR [EXCEPTION]",
        "Terjadi kesalahan: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline, color: Colors.black),
      );
    }
  }
}
