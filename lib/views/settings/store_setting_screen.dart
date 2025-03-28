import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/store_setting_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart'; // Import DeviceSettingController
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart';
import 'package:demo_nfc/widgets/theme_handler.dart';
import 'package:demo_nfc/widgets/toggle_language_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreSettingScreen extends StatelessWidget {
  StoreSettingScreen({super.key});
  final StoreSettingController storeController =
      Get.put(StoreSettingController());
  final DeviceSettingController deviceController =
      Get.find<DeviceSettingController>(); // Fetch device settings
  final storage = GetStorage();
  final ThemeController cont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Store Setting".tr,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? AppColors.whiteColor
                : AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.secondaryColor.withOpacity(0.4)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      // Title for User ID
                      Text(
                        "User ID".tr,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // User ID - Auto-filled & Readonly
                      customTextField(
                        hintText: "User ID".tr,
                        controller: TextEditingController(
                            text: deviceController.createdByCont.text),
                        readOnly: true, // Prevent editing
                      ),

                      const SizedBox(height: 20),

                      // Title for Currency
                      Text(
                        "Currency".tr,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Currency
                      customTextField(
                        hintText: "Currency".tr,
                        controller: TextEditingController(
                            text: deviceController.currencyCont.text),
                        readOnly: true, // Prevent editing
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.secondaryColor.withOpacity(0.4)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Language".tr,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ToggleLanguageButtons(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(4),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.secondaryColor.withOpacity(0.4)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Theme".tr,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ToggleThemeButtons(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                borderRadius: 35,
                customheight: Get.height * 0.065,
                btnText: "Save".tr,
                btnColor: AppColors.primaryColor,
                btnTextStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
                onTap: () async {
                  storeController.userIdCont.text =
                      deviceController.createdByCont.text; // Auto-fill User ID
                  storeController.currencyCont.text =
                      "SAR"; // Auto-fill Currency

                  await storeController.storeSettings();

                  Get.snackbar(
                    "Success".tr,
                    "Store settings saved successfully".tr,
                    snackPosition: SnackPosition.TOP,
                  );
                  Get.toNamed(Routes.settingScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
