import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StoreSettingController extends GetxController {
  TextEditingController userIdCont = TextEditingController();
  TextEditingController currencyCont = TextEditingController();

  late Box settingsBox;

  @override
  void onInit() {
    super.onInit();
    settingsBox = Hive.box('storeSettingsBox');
    loadSettings();
  }

  void loadSettings() {
    userIdCont.text = settingsBox.get('userId', defaultValue: '');
    currencyCont.text = settingsBox.get('currency', defaultValue: '');
  }

  Future<void> storeSettings() async {
    await settingsBox.put('userId', userIdCont.text);
    await settingsBox.put('currency', currencyCont.text);

    debugPrint('User ID: ${userIdCont.text}');
    debugPrint('Currency: ${currencyCont.text}');
  }

}
