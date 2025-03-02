import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DeviceSettingController extends GetxController {
  TextEditingController boardIdCont = TextEditingController();
  TextEditingController machineIdCont = TextEditingController();
  TextEditingController secondBeforeCont = TextEditingController();
  TextEditingController secondAfterCont = TextEditingController();

  late Box settingsBox;

  @override
  void onInit() {
    super.onInit();
    settingsBox = Hive.box('settingsBox');
    loadSettings();
  }

  void loadSettings() {
    boardIdCont.text = settingsBox.get('boardId', defaultValue: '');
    machineIdCont.text = settingsBox.get('machineId', defaultValue: '');
    secondBeforeCont.text = settingsBox.get('secondBefore', defaultValue: '');
    secondAfterCont.text = settingsBox.get('secondAfter', defaultValue: '');
  }

  Future<void> saveSettings() async {
    await settingsBox.put('boardId', boardIdCont.text);
    await settingsBox.put('machineId', machineIdCont.text);
    await settingsBox.put('secondBefore', secondBeforeCont.text);
    await settingsBox.put('secondAfter', secondAfterCont.text);
    debugPrint('Board ID: ${boardIdCont.text}');
    debugPrint('Machine ID: ${machineIdCont.text}');
    debugPrint('Second Before Starting: ${secondBeforeCont.text}');
    debugPrint('Second After Starting: ${secondAfterCont.text}');
  }
}
