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
      appBar: AppBar(
        title: const Text("Football Players"),
        backgroundColor: Colors.lightBlue,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPlayer,
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Obx(
          () => footballController.players.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sports_soccer,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No players added yet",
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: footballController.players.length,
                  itemBuilder: (context, index) {
                    final player = footballController.players[index];
                    return Dismissible(
                      key: Key(player.name + index.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        footballController.deletePlayer(index);
                        Get.snackbar(
                          "Player Deleted",
                          "Successfully removed ${player.name}",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Hero(
                            tag: 'player-${player.name}-$index',
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(player.imageUrl),
                              radius: 28,
                            ),
                          ),
                          title: Text(
                            player.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                "${player.position} • #${player.number}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.lightBlue,
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
                          onTap: () {
                            Get.snackbar(
                              "Player Selected",
                              player.name,
                              snackPosition: SnackPosition.BOTTOM,
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