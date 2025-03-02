import 'dart:io';

import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/help/help_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void showHelpDialog(BuildContext context, Help helpModel) {
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor:
            storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? AppColors.secondaryColor.withOpacity(0.8)
                : AppColors.whiteColor,
        surfaceTintColor:
            storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? AppColors.secondaryColor.withOpacity(0.8)
                : AppColors.whiteColor,
        content: Container(
          width: Get.width,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? AppColors.secondaryColor.withOpacity(0.4)
                : Colors.transparent,
            border: Border.all(color: AppColors.whiteColor),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      helpModel.title,
                      textAlign: TextAlign.center,
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
                    const SizedBox(height: 20),
                    Text(
                      helpModel.description,
                      textAlign: TextAlign.center,
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
                            height: Get.height * 0.3,
                            width: Get.width,
                            fit: BoxFit.contain,
                          ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: storage.read('isDarkMode') == true ||
                                cont.isDarkTheme.value
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
