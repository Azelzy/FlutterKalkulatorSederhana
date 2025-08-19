import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/football_controller.dart';
import '../controllers/football_edit_controller.dart';
import '../models/football_model.dart';

class FootballEditPage extends StatefulWidget {
  final int index;
  final Player player;
  final bool isNewPlayer;

  const FootballEditPage({
    super.key,
    required this.index,
    required this.player,
    this.isNewPlayer = false,
  });

  @override
  State<FootballEditPage> createState() => _FootballEditPageState();
}

class _FootballEditPageState extends State<FootballEditPage> {
  final editController = Get.put(FootballEditController());

  @override
  void initState() {
    super.initState();
    editController.initializeFields(widget.player);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FootballController>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.isNewPlayer ? "TAMBAH PEMAINS" : "EDIT PEMAINS",
          style: const TextStyle(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: editController.nameController,
                      label: "NAMA",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: editController.positionController,
                      label: "POSISI",
                      icon: Icons.sports_soccer,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: editController.numberController,
                      label: "NOMER",
                      icon: Icons.tag,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: editController.imageController,
                      label: "URL GAMBAR",
                      icon: Icons.image,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: TextButton.icon(
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  widget.isNewPlayer ? "TAMBAHKANS PEMAINS" : "SIMPANS PERUBAHANS",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                onPressed: () {
                  final player = editController.getPlayer();

                  if (widget.isNewPlayer) {
                    controller.addPlayer(player);
                  } else {
                    controller.updatePlayer(widget.index, player);
                  }

                  Get.back();
                  Get.snackbar(
                    widget.isNewPlayer ? "TERTAMBAHKAN" : "TERPERBARUI",
                    player.name.toUpperCase(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
