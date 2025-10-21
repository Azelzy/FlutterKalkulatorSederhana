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
    print('🚀 LOGIN API STARTED');
    print('========================================');
    
    // Validasi input
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      print('❌ Validation Failed: Username atau password kosong');
      Get.snackbar(
        "ERROR",
        "Username dan password tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(63, 112, 111, 111),
        colorText: Colors.black,
      );
      return;
    }

    print('✅ Validation Passed');
    print('📝 Username: ${usernameController.text}');
    print('📝 Password: ${passwordController.text}');
    
    isLoading.value = true;

    try {
      // Prepare request data
      final requestData = {
        'username': usernameController.text,
        'password': passwordController.text,
      };

      print('\n----------------------------------------');
      print('📤 REQUEST DETAILS:');
      print('----------------------------------------');
      print('URL: ${ClientNetwork.login}');
      print('Method: POST');
      print('Body Parameters:');
      requestData.forEach((key, value) {
        print('  - $key: $value');
      });
      print('----------------------------------------\n');

      // Hit API
      print('⏳ Sending request to server...');
      final response = await http.post(
        Uri.parse(ClientNetwork.login),
        body: requestData,
      );

      print('\n----------------------------------------');
      print('📥 RESPONSE DETAILS:');
      print('----------------------------------------');
      print('Status Code: ${response.statusCode}');
      print('Status Message: ${response.reasonPhrase}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');
      print('Response Length: ${response.body.length} characters');
      print('----------------------------------------\n');

      // Parse response
      if (response.statusCode == 200) {
        print('✅ Status Code 200 - OK');
        
        try {
          final LoginModel loginModel = loginModelFromJson(response.body);
          
          print('\n----------------------------------------');
          print('📦 PARSED MODEL:');
          print('----------------------------------------');
          print('Status: ${loginModel.status}');
          print('Message: ${loginModel.message}');
          print('Token: ${loginModel.token}');
          print('Token Length: ${loginModel.token.length} characters');
          print('----------------------------------------\n');

          if (loginModel.status) {
            print('✅ Login Status: SUCCESS');
            
            // Simpan token ke SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', loginModel.token);
            await prefs.setString('username', usernameController.text);

            print('💾 Token saved to SharedPreferences');
            print('💾 Username saved to SharedPreferences');

            Get.snackbar(
              "BERHASIL",
              loginModel.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green[100],
              colorText: Colors.black,
            );

            isLoading.value = false;
            
            print('🔄 Navigating to: ${AppRoutes.bottomNav}');
            print('========================================');
            print('✅ LOGIN API COMPLETED SUCCESSFULLY');
            print('========================================\n');
            
            // Navigate ke halaman utama
            Get.offAllNamed(AppRoutes.bottomNav);
          } else {
            print('❌ Login Status: FAILED');
            print('📝 Reason: ${loginModel.message}');
            
            isLoading.value = false;
            Get.snackbar(
              "ERROR",
              loginModel.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[100],
              colorText: Colors.black,
            );
            
            print('========================================');
            print('❌ LOGIN API FAILED');
            print('========================================\n');
          }
        } catch (parseError) {
          isLoading.value = false;
          print('\n❌ JSON PARSE ERROR:');
          print('Error: ${parseError.toString()}');
          print('Raw Response: ${response.body}');
          
          Get.snackbar(
            "ERROR",
            "Error parsing response: ${parseError.toString()}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[100],
            colorText: Colors.black,
          );
          
          print('========================================');
          print('❌ LOGIN API FAILED - PARSE ERROR');
          print('========================================\n');
        }
      } else {
        print('❌ Status Code: ${response.statusCode} - ${response.reasonPhrase}');
        isLoading.value = false;
        
        Get.snackbar(
          "ERROR",
          "Server error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black,
        );
        
        print('========================================');
        print('❌ LOGIN API FAILED - SERVER ERROR');
        print('========================================\n');
      }
    } catch (e) {
      isLoading.value = false;
      
      print('\n❌❌❌ EXCEPTION OCCURRED ❌❌❌');
      print('Error Type: ${e.runtimeType}');
      print('Error Message: ${e.toString()}');
      print('Stack Trace:');
      print(StackTrace.current);
      
      Get.snackbar(
        "ERROR",
        "Terjadi kesalahan: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black,
      );
      
      print('========================================');
      print('❌ LOGIN API FAILED - EXCEPTION');
      print('========================================\n');
    }
  }
}