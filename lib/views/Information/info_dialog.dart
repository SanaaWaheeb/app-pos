import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

void showInfoDialog(BuildContext context) {
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();
  var box = Hive.box('infoBox');
  var description =
      box.get('description', defaultValue: 'No description saved');
  var title = box.get('title', defaultValue: 'No title saved');

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
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
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
                        title,
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
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: storage.read('isDarkMode') == true ||
                              cont.isDarkTheme.value
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
