import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/controllers/language_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/help/help_model.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/nearpay_services/nearpay_services.dart';
import 'package:demo_nfc/views/language/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  await NearpayService().initializeNearpay();

  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(HelpAdapter());

  await Hive.openBox<Product>('productsBox');
  await Hive.openBox<Help>('helpBox');
  await Hive.openBox('settingsBox');
  await Hive.openBox('storeSettingsBox');
  await Hive.openBox('infoBox');
  await Hive.openBox('passwordBox');
  await Hive.openBox('appBox');

  Get.put(LanguageController());
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MyTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'AVA POS',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeController.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
