import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/football_model.dart';

class FootballEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final numberController = TextEditingController();
  final imageController = TextEditingController();
  final isImageValid = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    positionController.dispose();
    numberController.dispose();
    imageController.dispose();
    super.onClose();
  }

  void initializeFields(Player player) {
    nameController.text = player.name;
    positionController.text = player.position;
    numberController.text = player.number.toString();
    imageController.text = player.imageUrl;
    validateImageUrl(player.imageUrl);
  }

  Future<void> validateImageUrl(String url) async {
    if (url.isEmpty) {
      isImageValid.value = false;
      return;
    }

    try {
      await NetworkImage(url).resolve(ImageConfiguration.empty);
      isImageValid.value = true;
    } catch (e) {
      isImageValid.value = false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a position';
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    final number = int.tryParse(value);
    if (number == null || number < 1 || number > 99) {
      return 'Please enter a valid number (1-99)';
    }
    return null;
  }

  Player? getValidatedPlayer() {
    if (!formKey.currentState!.validate()) return null;

    return Player(
      name: nameController.text,
      position: positionController.text,
      number: int.parse(numberController.text),
      imageUrl: imageController.text,
    );
  }
}
