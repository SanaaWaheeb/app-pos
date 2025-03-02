import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class InfoController extends GetxController {
  final storage = GetStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  late Box box;
  @override
  void onInit() {
    super.onInit();
    box = Hive.box('infoBox');
    loadTextFields();
  }

  void loadTextFields() {
    titleController.text = box.get('title', defaultValue: '');
    textController.text = box.get('description', defaultValue: '');
    update();
  }
}
