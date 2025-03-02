import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/reset_password_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final ThemeController cont = Get.put(ThemeController());
   final ResetPassController controller = Get.put(ResetPassController());
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reset Password".tr,
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
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
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
                      customTextField(hintText: "Old Password".tr,
                      controller: controller.oldPasswordController),
                      const SizedBox(height: 20),
                      customTextField(hintText: "New Password".tr,
                       controller: controller.newPasswordController),
                      const SizedBox(height: 20),
                      customTextField(hintText: "New Password Confirmation".tr,
                       controller: controller.confirmPasswordController),
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
                onTap: () {

                   if (!controller.validateOldPassword(controller.oldPasswordController.text)) {
                    debugPrint(controller.oldPasswordController.text);
                    Get.snackbar(
                      "Error".tr,
                      "Old Password is incorrect".tr,
                      snackPosition: SnackPosition.TOP,
                    );
                    return;
                  }

                  if (!controller.validateNewPassword(
                      controller.newPasswordController.text,
                      controller.confirmPasswordController.text)) {
                    Get.snackbar(
                      "Error".tr,
                      "New Passwords do not match".tr,
                      snackPosition: SnackPosition.TOP,
                    );
                    return;
                  }

                  controller.updatePassword(controller.newPasswordController.text);
                  Get.snackbar(
                    "Success".tr,
                    "Password Updated Successfully".tr,
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
