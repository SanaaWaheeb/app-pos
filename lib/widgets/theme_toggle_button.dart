import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:get/get.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  ThemeToggleButton({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  void changeTheme() {
    bool newThemeValue = !_themeController.isDarkTheme.value;
    _themeController.switchTheme(newThemeValue);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        child: SizedBox(
          height: 45,
          child: AnimatedToggleSwitch<bool>.dual(
            transitionType: ForegroundIndicatorTransitionType.fading,
            innerColor: _themeController.isDarkTheme.value ? const Color(0xFF101828) : Colors.white,
            current: _themeController.isDarkTheme.value,
            indicatorSize: const Size(60, double.infinity),
            first: false,
            second: true,
            dif: 1,
            borderColor: Colors.black.withOpacity(0.04),
            borderWidth: 5.0,
            height: 50,
            onChanged: (isDark) {
              changeTheme(); // Call changeTheme method on toggle switch change
            },
            colorBuilder: (isDark) {
              if (isDark) {
                return const Color.fromARGB(255, 203, 170, 170);
              } else {
                return const Color(0xFFEAECF0);
              }
            },
            customIconBuilder: (context, local, global) => Text(
              _themeController.isDarkTheme.value ? "Dark".tr : "Light".tr,
              style: TextStyle(
                color: _themeController.isDarkTheme.value ? Colors.white : Colors.red, // Adjust colors for dark and light themes
                fontSize: 18,
                fontFamily: 'Spline Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            textBuilder: (value) => value
                ? Center(
                    child: Text(
                      'Light'.tr,
                      style: TextStyle(
                        color: _themeController.isDarkTheme.value ? Colors.red : const Color(0xFF344054),
                        fontSize: 18,
                        fontFamily: 'Spline Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Dark'.tr,
                      style: TextStyle(
                        color: _themeController.isDarkTheme.value ? Colors.red : const Color(0xFF344054),
                        fontSize: 18,
                        fontFamily: 'Spline Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
