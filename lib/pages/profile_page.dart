import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "PROFILE",
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Profile Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Image.asset("assets/images/miyano.jpg", fit: BoxFit.cover),
            ),

            // Profile Info Cards
            const SizedBox(height: 32),
            _buildProfileCard(
              label: "NAMA",
              value: "AZUKA",
              icon: Icons.person,
            ),
            const SizedBox(height: 32),
            _buildProfileCard(
              label: "ABSEN",
              value: "6",
              icon: Icons.numbers_outlined,
            ),
            const SizedBox(height: 16),

            _buildProfileCard(
              label: "EMAIL",
              value: "azkaelfachrizy@gmail.com",
              icon: Icons.email,
            ),
            const SizedBox(height: 16),

            _buildProfileCard(
              label: "NOMOR TELEPON",
              value: "+62 857-415-058-08",
              icon: Icons.phone,
            ),
            const SizedBox(height: 16),

            _buildProfileCard(
              label: "ALAMAT SEKOLAH",
              value: "SMK RADEN UMAR SAID KUDUS",
              icon: Icons.school_sharp,
            ),
            _buildProfileCard(
              label: "KELAS",
              value: "XI PPLG 1",
              icon: Icons.class_sharp,
            ),

            const Spacer(),

            // Action buttons
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: TextButton.icon(
                icon: const Icon(Icons.edit, color: Colors.black),
                label: const Text(
                  "EDIT PROFILE",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                onPressed: () {
                  // TODO: Implement edit profile
                },
              ),
            ),

            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: TextButton.icon(
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "SIMPAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                onPressed: () {
                  // TODO: Implement SAVE
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
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
