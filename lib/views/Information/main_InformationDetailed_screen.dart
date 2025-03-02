
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class MainInformationDetailedScreen extends StatelessWidget {
  MainInformationDetailedScreen({super.key});
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 30), () {
    //   Get.toNamed(Routes.dashboard);
    // });
    var box = Hive.box('infoBox');
    var description =
        box.get('description', defaultValue: 'No description saved');
    var title = box.get('title', defaultValue: 'No title saved');

    return Scaffold(
      body: Stack(
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
                          title,
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
                        const SizedBox(height: 20),
                        Text(
                          description,
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
    );
  }
}
