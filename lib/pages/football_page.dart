import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/football_controller.dart';
import '../models/football_model.dart';
import '../routes/routes.dart';

class Footballpage extends StatelessWidget {
  Footballpage({super.key});
  final FootballController footballController = Get.put(FootballController());

  void _addNewPlayer() {
    final newPlayer = Player(name: "", position: "", number: 0, imageUrl: "");
    Get.toNamed(
      AppRoutes.footballedit,
      arguments: {
        'index': footballController.players.length,
        'player': newPlayer,
        'isNewPlayer': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "LISTS PEMAINS",
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
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,
        ),
        child: IconButton(
          onPressed: _addNewPlayer,
          icon: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => footballController.players.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "LIST PEMAIN KOSONG",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: footballController.players.length,
                  itemBuilder: (context, index) {
                    final player = footballController.players[index];
                    return Dismissible(
                      key: Key(player.name + index.toString()),
                      background: Container(
                        color: Colors.black,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        footballController.deletePlayer(index);
                        Get.snackbar(
                          "TELAH DIHAPUS",
                          player.name.toUpperCase(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color.fromARGB(63, 112, 111, 111),
                          colorText: Colors.black,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: player.imageUrl.isNotEmpty
                                ? Image.network(
                                    player.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.person,
                                        color: Colors.grey[600],
                                      );
                                    },
                                  )
                                : Icon(Icons.person, color: Colors.grey[600]),
                          ),
                          title: Text(
                            player.name.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "${player.position.toUpperCase()} • ${player.number}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 18,
                              ),
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.footballedit,
                                  arguments: {
                                    'index': index,
                                    'player': player,
                                    'isNewPlayer': false,
                                  },
                                );
                              },
                            ),
                          ),
                          onTap: () {
                            Get.snackbar(
                              "ANDA MENEKAN",
                              player.name.toUpperCase(),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color.fromARGB(63, 112, 111, 111),
                              colorText: Colors.black,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
