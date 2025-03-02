import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  RxBool isDarkTheme = true.obs; // Set initial state to true for dark theme

  final storage = GetStorage();

  ThemeMode get theme => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _getCurrentTheme();
  }

  void _getCurrentTheme() {
    isDarkTheme.value = storage.read('isDarkMode') ?? true; // Read from storage
  }

  void switchTheme(bool isDark) {
    isDarkTheme.value = isDark;
    _updateThemeSetting(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void _updateThemeSetting(bool boolData) {
    storage.write('isDarkMode', boolData); // Store theme preference
  }

    void changeTheme(bool isDark) {
    isDarkTheme.value = isDark;
    storage.write('isDarkMode', isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
