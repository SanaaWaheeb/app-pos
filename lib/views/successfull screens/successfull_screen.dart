import 'dart:io';

import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/store_setting_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/controllers/timer_controller.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/widgets/ava_url_openView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
import 'package:get_storage/get_storage.dart';

class SuccessfullScreen extends StatelessWidget {
  final Product product;
  SuccessfullScreen({super.key, required this.product});
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();
  final deviceSettingController = Get.put(DeviceSettingController());
  final storeSettingController = Get.put(StoreSettingController());
  final LanguageController languageController = Get.put(LanguageController());
  final ThemeController themeCont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    // Calculate the total wait time in seconds from Hive database
    final int secondsBefore = int.tryParse(deviceSettingController.settingsBox
            .get('secondBefore', defaultValue: '')) ??
        0;
    final int secondsAfter = int.tryParse(deviceSettingController.settingsBox
            .get('secondAfter', defaultValue: '')) ??
        0;
    // Retrieve the latest product from Hive database
    //final Box<Product> productBox = Hive.box<Product>('productsBox');
    final Product latestProduct = product;
    final int productTimerMinutes = int.tryParse(latestProduct.timer) ?? 0;

    //final int totalWaitTime = 30;

    final int totalWaitTime =
        secondsBefore + (productTimerMinutes * 60) + secondsAfter;

    // secondsBefore + productTimerMinutes + secondsAfter;
    Get.delete<TimerController>(force: true);
    Get.put(TimerController(
      totalWaitTime: totalWaitTime,
      themeCont: cont,
      languageController: languageController,
    ));
    // Future.delayed(Duration(seconds: totalWaitTime), () {
    //   themeCont.changeTheme(true);
    //   languageController.changeLanguage("en");
    //   Get.to(() => const DashboardViewScreen());
    // });

    final String url = 'https://ava.com.sa/pos/?'
        'board_id=${deviceSettingController.settingsBox.get('boardId', defaultValue: '')}&'
        'machine_id=${deviceSettingController.settingsBox.get('machineId', defaultValue: '')}&'
        'user_id=${deviceSettingController.settingsBox.get('createdBy', defaultValue: '')}&' //'user_id=${storeSettingController.settingsBox.get('userId', defaultValue: '')}&'
        'currency=${deviceSettingController.settingsBox.get('currency', defaultValue: 'SAR')}&'
        'product_name=${latestProduct.name}&'
        'product_id=${latestProduct.id}&'
        'track_id=${latestProduct.tid}&'
        'product_price=${latestProduct.price}&'
        'product_timer=${latestProduct.timer}&'
        'reference=${storage.read('transactionId') ?? '0'}';

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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: latestProduct.imagePath.isNotEmpty
                                  ? Image.network(
                                      "https://ava.sa/app/storage/uploads/is_cover_image/${latestProduct.imagePath}",
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const Placeholder(),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      languageController
                                                  .selectedLanguage.value ==
                                              'ar'
                                          ? latestProduct.namearabic
                                          : latestProduct.name,
                                      style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontFamily: "Roboto",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      languageController
                                                  .selectedLanguage.value ==
                                              'ar'
                                          ? latestProduct.descriptionarabic
                                          : latestProduct.description,
                                      style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontFamily: "Roboto",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'SAR ${latestProduct.price}'.tr,
                                          style: TextStyle(
                                              color:
                                                  storage.read('isDarkMode') ==
                                                              true ||
                                                          cont.isDarkTheme.value
                                                      ? AppColors.primaryColor
                                                      : AppColors.whiteColor,
                                              fontFamily: "Roboto",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(30, 36),
                                            backgroundColor:
                                                AppColors.greenColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            'Paid'.tr,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Roboto",
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: Get.height * 0.42,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: UrlViewScreen(
                                url: url,
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
