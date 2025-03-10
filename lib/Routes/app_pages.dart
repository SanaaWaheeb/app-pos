// ignore_for_file: prefer_const_constructors

import 'package:demo_nfc/splash/splash_screen.dart';
import 'package:demo_nfc/views/Information/information_screen.dart';
import 'package:demo_nfc/views/Information/main_InformationDetailed_screen.dart';
import 'package:demo_nfc/views/dashboard/dashboard_main.dart';
import 'package:demo_nfc/views/help/help_screen.dart';
import 'package:demo_nfc/views/login/loginScreen.dart';
import 'package:demo_nfc/views/products/add_product_screen.dart';
import 'package:demo_nfc/views/products/products_screen.dart';
import 'package:demo_nfc/views/settings/device_setting_screen.dart';
import 'package:demo_nfc/views/settings/reset_password_screen.dart';
import 'package:demo_nfc/views/settings/setting_screen.dart';
import 'package:demo_nfc/views/settings/store_setting_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.splash;
  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardViewScreen(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _Paths.settingScreen,
      page: () {
        bool isAuthenticated() {
          final storage = GetStorage();
          return storage.hasData('isLoggedIn') &&
              storage.read('isLoggedIn') == true;
        }

        if (isAuthenticated()) {
          return SettingScreen();
        } else {
          return LoginScreen();
        }
      },
    ),
    GetPage(
      name: _Paths.deviceSettingScreen,
      page: () => DeviceSettingScreen(),
    ),
    GetPage(
      name: _Paths.storeSettingScreen,
      page: () => StoreSettingScreen(),
    ),
    GetPage(
      name: _Paths.resetPassScreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: _Paths.productViewScreen,
      page: () => ProductViewScreen(),
    ),
   GetPage(
  name: _Paths.addProductScreen,
  page: () => AddProductScreen(product: Get.arguments), // Pass the product from Get.arguments
),
    GetPage(
      name: _Paths.helpScreen,
      page: () => HelpScreen(),
    ),
    GetPage(
      name: _Paths.informationScreen,
      page: () => InformationScreen(),
    ),
    //  GetPage(
    //   name: _Paths.helpDetailedScreen,
    //   page: () => MainHelpDetailedScreen(),
    // ),
    GetPage(
      name: _Paths.mainInfoDetailedScreen,
      page: () => MainInformationDetailedScreen(),
    ),
  ];
}
