part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const dashboard = _Paths.dashboard;
  static const login = _Paths.login;
  static const settingScreen = _Paths.settingScreen;
  static const storeSettingScreen = _Paths.storeSettingScreen;
  static const deviceSettingScreen = _Paths.deviceSettingScreen;
  static const resetPassScreen = _Paths.resetPassScreen;
  static const productViewScreen = _Paths.productViewScreen;
  static const addProductScreen = _Paths.addProductScreen;
  static const helpScreen = _Paths.helpScreen;
  static const informationScreen = _Paths.informationScreen;
  static const mainInfoDetailedScreen = _Paths.mainInfoDetailedScreen;
  static const paymentProcessingScreen = _Paths.paymentProcessingScreen;
  static const splash = _Paths.splash;
}

abstract class _Paths {
  static const dashboard = "/dashboard";
  static const login = "/login";
  static const settingScreen = "/settingScreen";
  static const storeSettingScreen = "/storeSettingScreen";
  static const deviceSettingScreen = "/deviceSettingScreen";
  static const resetPassScreen = "/resetPassScreen";
  static const productViewScreen = "/productViewScreen";
  static const addProductScreen = "/addProductScreen";
  static const helpScreen = "/helpScreen";
  static const informationScreen = "/informationScreen";
  static const mainInfoDetailedScreen = "/mainInfoDetailedScreen";
  static const paymentProcessingScreen = "/paymentProcessingScreen";
  static const splash = "/splash";
}
