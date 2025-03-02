import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/views/dashboard/dashboard_main.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final storage = GetStorage();
  final ThemeController cont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Setting".tr,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  storage.read('isDarkMode') == true || cont.isDarkTheme.value
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
                customRow(
                  title: "Device Setting".tr,
                  onTap: () {
                    Get.toNamed(Routes.deviceSettingScreen);
                  },
                ),
                const SizedBox(height: 10),
                customRow(
                  title: "Store Setting".tr,
                  onTap: () {
                    Get.toNamed(Routes.storeSettingScreen);
                  },
                ),
                const SizedBox(height: 10),
                customRow(
                  title: "Products".tr,
                  onTap: () {
                    Get.toNamed(Routes.productViewScreen);
                  },
                ),
                const SizedBox(height: 10),
                customRow(
                  title: "Help".tr,
                  onTap: () {
                    Get.toNamed(Routes.helpScreen);
                  },
                ),
                const SizedBox(height: 10),
                customRow(
                  title: "Information".tr,
                  onTap: () {
                    Get.toNamed(Routes.informationScreen);
                  },
                ),
                const SizedBox(height: 10),
                customRow(
                  title: "Change Password".tr,
                  onTap: () {
                    Get.toNamed(Routes.resetPassScreen);
                  },
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 40),
                CustomButton(
                  borderRadius: 35,
                  customheight: Get.height * 0.065,
                  btnText: "Back to Home".tr,
                  btnColor: AppColors.primaryColor,
                  btnTextStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                  onTap: () {
                    Get.offAll(() => const DashboardViewScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
