// language_controller.dart
import 'package:get/get.dart';
import 'dart:ui';

import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();
  RxString selectedLanguage = "en".obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = box.read('selectedLanguage') ?? "en";
    if (selectedLanguage.value == "en") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ar', 'SA'));
    }
  }

//For Main DashBoard
  void toggleLanguage() {
    if (selectedLanguage.value == "en") {
      selectedLanguage.value = "ar";
      box.write('selectedLanguage', "ar");
    } else {
      selectedLanguage.value = "en";
      box.write('selectedLanguage', "en");
    }
    _updateLocale(selectedLanguage.value);
  }

  void _updateLocale(String languageCode) {
    if (languageCode == "en") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ar', 'SA'));
    }
  }

//For Store Settings
  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    box.write('selectedLanguage', languageCode);
    if (languageCode == "en") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ar', 'SA'));
    }
  }
}
