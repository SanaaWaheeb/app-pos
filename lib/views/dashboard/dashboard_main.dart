import 'dart:async';
import 'dart:io';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/help/help_model.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/views/Information/info_dialog.dart';
import 'package:demo_nfc/views/help/help_dialog.dart';
import 'package:demo_nfc/views/successfull%20screens/payment_processing_screen.dart';
import 'package:demo_nfc/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';

class DashboardViewScreen extends StatefulWidget {
  const DashboardViewScreen({super.key});

  @override
  State<DashboardViewScreen> createState() => _DashboardViewScreenState();
}

class _DashboardViewScreenState extends State<DashboardViewScreen> {
  final LanguageController languageController = Get.put(LanguageController());
  int _tapCount = 0;
  Timer? _tapTimer;
  ThemeController cont = Get.put(ThemeController());
  final ThemeToggleButton themeToggleButton = ThemeToggleButton();
  final DeviceSettingController devController =
      Get.put(DeviceSettingController());
  final storage = GetStorage();
  _SelectedTab? _selectedTab;
  final Box<Help> helpBox = Hive.box<Help>('helpBox');
  late Box<Product> productBox;

  @override
  void initState() {
    super.initState();
    print("DashboardViewScreen initialized");
    productBox = Hive.box<Product>('productsBox');
    devController.fetchProducts(); // Fetch products when the page opens
  }

  void _handleTap() {
    setState(() {
      _tapCount += 1;
    });

    // Cancel any existing timer and start a new one
    _tapTimer?.cancel();
    _tapTimer = Timer(Duration(seconds: 1), () {
      setState(() {
        _tapCount = 0;
      });
    });

    if (_tapCount == 5) {
      Get.toNamed(Routes.login);
      debugPrint('Hidden button tapped 5 times');
      _tapCount = 0;
      _tapTimer?.cancel(); // Cancel the timer when the condition is met
    }
  }

  @override
  void dispose() {
    _tapTimer?.cancel();
    super.dispose();
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      if (_selectedTab == _SelectedTab.language) {
        languageController.toggleLanguage();
      } else if (_selectedTab == _SelectedTab.discount) {
        // Handle discount tab tap
      } else if (_selectedTab == _SelectedTab.info) {
        showInfoDialog(context);
      } else if (_selectedTab == _SelectedTab.theme) {
        themeToggleButton.changeTheme();
      } else if (_selectedTab == _SelectedTab.support) {
        showHelpDialog(context, helpBox.values.last);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Image.asset(
            width: double.infinity,
            storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? DefaultImages.darkBgImage
                : DefaultImages.backgImage,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      DefaultImages.logo,
                      width: Get.width * 0.4,
                      height: Get.height * 0.2,
                    ),
                    GestureDetector(
                      onTap: _handleTap,
                      child: Container(
                        width: Get.width * 0.5,
                        height: Get.height * 0.1,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: devController.products.length + 1,
                    itemBuilder: (context, index) {
                      if (index == devController.products.length) {
                        // Return a SizedBox with the desired padding for the last item
                        return SizedBox(height: 100);
                      }

                      final product = devController.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            double displayedPrice = product.price;
                            int priceInCents = (displayedPrice * 100).toInt();

                            Get.to(() => PaymentProcessingScreen(
                                  productPrice: priceInCents.toDouble(),
                                  itemProduct: product,
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: storage.read('isDarkMode') == true ||
                                      cont.isDarkTheme.value
                                  ? AppColors.secondaryColor.withOpacity(0.4)
                                  : AppColors.whiteColor,
                              border: Border.all(color: AppColors.whiteColor),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: product.imagePath.isNotEmpty
                                        ? Image.file(
                                            File(product.imagePath),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            fit: BoxFit.cover,
                                          )
                                        : const Placeholder(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            languageController.selectedLanguage
                                                        .value ==
                                                    'ar'
                                                ? product.namearabic
                                                : product.name.tr,
                                            style: TextStyle(
                                                color: storage.read(
                                                                'isDarkMode') ==
                                                            true ||
                                                        cont.isDarkTheme.value
                                                    ? AppColors.whiteColor
                                                    : AppColors.secondaryColor,
                                                fontFamily: "Roboto",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            languageController.selectedLanguage
                                                        .value ==
                                                    'ar'
                                                ? product.descriptionarabic
                                                : product.description.tr,
                                            style: TextStyle(
                                                color: storage.read(
                                                                'isDarkMode') ==
                                                            true ||
                                                        cont.isDarkTheme.value
                                                    ? AppColors.whiteColor
                                                    : AppColors.secondaryColor,
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
                                                '${product.price.toStringAsFixed(2)} SAR'
                                                    .tr,
                                                style: TextStyle(
                                                    color: storage.read(
                                                                    'isDarkMode') ==
                                                                true ||
                                                            cont.isDarkTheme
                                                                .value
                                                        ? AppColors.primaryColor
                                                        : AppColors
                                                            .secondaryColor,
                                                    fontFamily: "Roboto",
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  double displayedPrice =
                                                      product.price;
                                                  int priceInCents =
                                                      (displayedPrice * 100)
                                                          .toInt();
                                                  Get.to(() =>
                                                      PaymentProcessingScreen(
                                                        productPrice:
                                                            priceInCents
                                                                .toDouble(),
                                                        itemProduct: product,
                                                      ));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(30, 36),
                                                  backgroundColor: storage.read(
                                                                  'isDarkMode') ==
                                                              true ||
                                                          cont.isDarkTheme.value
                                                      ? AppColors.primaryColor
                                                      : AppColors.greenColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Buy'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Roboto",
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: CrystalNavigationBar(
          currentIndex: _selectedTab == null
              ? -1
              : _SelectedTab.values.indexOf(_selectedTab!),
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [
            CrystalNavigationBarItem(
              icon: Icons.language_outlined,
              unselectedIcon: Icons.language_outlined,
              selectedColor: AppColors.primaryColor,
            ),
            CrystalNavigationBarItem(
              icon: Icons.discount_outlined,
              unselectedIcon: Icons.discount_outlined,
              selectedColor: AppColors.primaryColor,
            ),
            CrystalNavigationBarItem(
              icon: Icons.info,
              unselectedIcon: Icons.info,
              selectedColor: AppColors.primaryColor,
            ),
            CrystalNavigationBarItem(
                icon: Icons.light_mode_outlined,
                unselectedIcon: Icons.light_mode_outlined,
                selectedColor: AppColors.primaryColor),
            CrystalNavigationBarItem(
                icon: Icons.support_agent,
                unselectedIcon: Icons.support_agent,
                selectedColor: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { language, discount, info, theme, support }
