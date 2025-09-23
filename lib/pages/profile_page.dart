import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/NavDrawer.dart';
import '../controllers/bottom_nav_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    
    return Scaffold(
      drawer: const NavDrawer(), 
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "PROFILS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2), // tinggi garis
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 32),

          // Profile Avatar
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                shape: BoxShape.rectangle,
                image: const DecorationImage(
                  image: AssetImage("assets/images/miyano.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Profile Info Cards
          _buildProfileCard(label: "NAMA ASLI", value: "Azka El Fachrizy"),
          const SizedBox(height: 16),

          _buildProfileCard(label: "日本語のユーザー名", value: "Azuka Takayama"),
          const SizedBox(height: 16),

          _buildProfileCard(label: "EMAIL", value: "azkaelfachrizy@gmail.com"),
          const SizedBox(height: 16),

          _buildProfileCard(label: "GITHUB URL", value: "github.com/azelzy"),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: "INSTAGRAM URL",
            value: "Instagram.com/azelzy",
          ),
          const SizedBox(height: 32),

          // Logout Button Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                Text(
                  "PENGATURAN AKUN",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[600],
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: controller.isLoggingOut.value 
                          ? Colors.grey[400] 
                          : Colors.red,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: TextButton.icon(
                      icon: controller.isLoggingOut.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        controller.isLoggingOut.value 
                            ? "LOGGING OUT..." 
                            : "KELUAR DARI AKUN",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: controller.isLoggingOut.value 
                          ? null 
                          : controller.logout,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Anda akan keluar dari aplikasi dan kembali ke halaman login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileCard({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[600],
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}