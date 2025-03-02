import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/views/dashboard/dashboard_main.dart';

class TimerController extends GetxController {
  final int totalWaitTime;
  final ThemeController themeCont;
  final LanguageController languageController;

  TimerController({
    required this.totalWaitTime,
    required this.themeCont,
    required this.languageController,
  });

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    print("TimerController initialized");
    startTimer();
  }

  void startTimer() {
    _timer = Timer(Duration(seconds: totalWaitTime), () {
      print("Timer finished");
      themeCont.changeTheme(true);
      languageController.changeLanguage("en");
      print("Navigating to DashboardViewScreen");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.currentRoute != '/DashboardViewScreen') {
          Get.offAll(() => const DashboardViewScreen());
        }
      });
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    print("TimerController disposed");
    super.onClose();
  }
}
