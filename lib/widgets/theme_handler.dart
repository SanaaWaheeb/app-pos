// toggle_theme_buttons.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';

class ToggleThemeButtons extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  ToggleThemeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _themeController.changeTheme(false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: !_themeController.isDarkTheme.value
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
              ),
              child: Text(
                'Light'.tr,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: !_themeController.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _themeController.changeTheme(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _themeController.isDarkTheme.value
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
              ),
              child: Text(
                'Dark'.tr,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _themeController.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ));
  }
}
