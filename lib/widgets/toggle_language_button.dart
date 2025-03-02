// toggle_language_buttons.dart
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleLanguageButtons extends StatelessWidget {
  final LanguageController _languageController = Get.put(LanguageController());

  ToggleLanguageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _languageController.changeLanguage("en");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _languageController.selectedLanguage.value == "en"
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
              ),
              child: Text(
                'English'.tr,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _languageController.selectedLanguage.value == "en"
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _languageController.changeLanguage("ar");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _languageController.selectedLanguage.value == "ar"
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
              ),
              child: Text(
                'Arabic'.tr,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _languageController.selectedLanguage.value == "en"
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),);
  }
}
