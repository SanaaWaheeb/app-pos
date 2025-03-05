import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeviceSettingScreen extends StatelessWidget {
  DeviceSettingScreen({super.key});
  final DeviceSettingController devController =
      Get.put(DeviceSettingController());
  final storage = GetStorage();
  final ThemeController cont = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Device Setting".tr,
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
                    children: [
                      const SizedBox(height: 20),
                      customTextField(
                          hintText: "Board ID".tr,
                          controller: devController.boardIdCont),
                      // const SizedBox(height: 20),
                      // customTextField(
                      //     hintText: "Meachine ID".tr,
                      //     controller: devController.machineIdCont),
                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.secondaryColor.withOpacity(0.4)
                      : AppColors.whiteColor,
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
                        "Timer".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      customTextField(
                          hintText: "Second Before Starting".tr,
                          controller: devController.secondBeforeCont),
                      const SizedBox(height: 20),
                      customTextField(
                          hintText: "Second After Starting".tr,
                          controller: devController.secondAfterCont),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
                  await devController.saveSettings();
                  // devController.clearFields();
                  Get.snackbar(
                    "Success".tr,
                    "Device settings saved successfully".tr,
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
