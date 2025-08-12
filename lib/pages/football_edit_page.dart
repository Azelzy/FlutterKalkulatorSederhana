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
      appBar: AppBar(
        title: Text(widget.isNewPlayer ? "Add New Player" : "Edit Player"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: editController.formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: editController.nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: editController.validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: editController.positionController,
                  decoration: InputDecoration(
                    labelText: "Position",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.sports_soccer),
                  ),
                  validator: editController.validatePosition,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: editController.numberController,
                  decoration: InputDecoration(
                    labelText: "Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.tag),
                  ),
                  keyboardType: TextInputType.number,
                  validator: editController.validateNumber,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: editController.imageController,
                  decoration: InputDecoration(
                    labelText: "Image URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.image),
                    suffixIcon: Obx(
                      () => editController.isImageValid.value
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  onChanged: editController.validateImageUrl,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(
                    widget.isNewPlayer ? "Add Player" : "Save Changes",
                  ),
                  onPressed: () {
                    final player = editController.getValidatedPlayer();
                    if (player != null) {
                      if (widget.isNewPlayer) {
                        controller.addPlayer(player);
                      } else {
                        controller.updatePlayer(widget.index, player);
                      }

                      Get.back();
                      Get.snackbar(
                        widget.isNewPlayer ? "Player Added" : "Player Updated",
                        "${player.name} has been ${widget.isNewPlayer ? 'added' : 'updated'} successfully",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green[100],
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}