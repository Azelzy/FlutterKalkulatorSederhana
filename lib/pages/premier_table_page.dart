import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laihan01/controllers/premier_table_contoller.dart';

class PremierTablePage extends StatelessWidget {
  PremierTablePage({super.key});

  final controller = Get.find<PremierTableContoller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premier League Table')),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Obx(() {
          if (controller.isloading.value) {
            return Center(child: CircularProgressIndicator());
          }
          // Placeholder for content that reacts to controller's state
          return RefreshIndicator(
            onRefresh: () { 
              return controller.fetchPremierTable();
            },
            child: ListView.builder(
              itemCount: controller.standings.length,
              itemBuilder: (context, index) {
                final team = controller.standings[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(team.strBadge),),
                    trailing: Text(team.intPoints),
                    subtitle: Text("Played: ${team.intPlayed}\nW: ${team.intWin} D: ${team.intDraw} L: ${team.intLoss}"),
                    title: Text(team.strTeam.toString())
                    ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
