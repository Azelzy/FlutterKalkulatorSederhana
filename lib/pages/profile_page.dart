import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "PROFILS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
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
          _buildProfileCard(
            label: "NAMA ASLI",
            value: "Azka El Fachrizy",
            icon: Icons.tag_outlined,
          ),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: "日本語のユーザー名",
            value: "Azuka Takayama",
            icon: Icons.javascript_outlined,
          ),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: "EMAIL",
            value: "azkaelfachrizy@gmai.com",
            icon: Icons.email,
          ),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: "GITHUB URL",
            value: "Github.com/azelzy",
            icon: Icons.code_outlined,
          ),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: "INSTAGRAM URL",
            value: "Instagram.com/azelzy",
            icon: Icons.camera_alt_outlined,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Icon(icon, color: Colors.black, size: 20),
          ),
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
