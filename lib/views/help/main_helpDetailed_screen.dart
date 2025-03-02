// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/help/help_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainHelpDetailedScreen extends StatelessWidget {
  final Help helpModel;
  MainHelpDetailedScreen({super.key, required this.helpModel});
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    //    Timer(Duration(seconds: 30), () {
    //   Get.toNamed(Routes.dashboard);
    // });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                storage.read('isDarkMode') == true || cont.isDarkTheme.value
                    ? DefaultImages.darkBgImage
                    : DefaultImages.backgImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    DefaultImages.logo,
                    width: Get.width * 0.4,
                    height: Get.height * 0.2,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: storage.read('isDarkMode') == true ||
                              cont.isDarkTheme.value
                          ? AppColors.secondaryColor.withOpacity(0.4)
                          : const Color(0xff000000).withOpacity(0.6),
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            helpModel.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: storage.read('isDarkMode') == true ||
                                      cont.isDarkTheme.value
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            helpModel.description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: storage.read('isDarkMode') == true ||
                                      cont.isDarkTheme.value
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          helpModel.imagePath.isEmpty
                              ? const Placeholder()
                              : Image.file(
                                  File(helpModel.imagePath),
                                  // width: Get.width * 0.4,
                                  height: Get.height * 0.4,
                                  fit: BoxFit.cover,
                                ),
                          const SizedBox(height: 40),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30, 36),
                                backgroundColor:
                                    storage.read('isDarkMode') == true ||
                                            cont.isDarkTheme.value
                                        ? AppColors.primaryColor
                                        : AppColors.greenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Close'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _delayedNavigation() async {
//   await Future.delayed(Duration(seconds: 30));
//   Get.toNamed(Routes.dashboard);
// }
