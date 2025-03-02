import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/signIn_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SignInController signInController = Get.put(SignInController());
  final ThemeController cont = Get.put(ThemeController());
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: AppColors.whiteColor,
        title: Text(
          "Login".tr,
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
              const SizedBox(height: 10),
              Image.asset(
                DefaultImages.loginImage,
                height: Get.height * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
               const SizedBox(height: 5),
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
                      const SizedBox(height: 40),
                      passwordTextField(),
                      const SizedBox(height: 20),
                      CustomButton(
                        borderRadius: 35,
                        customheight: Get.height * 0.065,
                        btnText: "Login".tr,
                        btnColor: AppColors.primaryColor,
                        btnTextStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                        onTap: () {
                          // if (signInController.passwordController.text ==
                          //     _defaultPass) {
                          if (signInController.validatePassword(signInController.passwordController.text)) {
                            storage.write('isLoggedIn', true);
                            Get.toNamed(Routes.settingScreen);
                            signInController.passwordController.clear();
                          } else {
                            Get.snackbar(
                              "Error".tr,
                              "Wrong Password".tr,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => SizedBox(
        height: Get.height * 0.062,
        child: TextField(
          controller: signInController.passwordController,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          obscureText: !signInController.showPassword.value,
          decoration: InputDecoration(
            hintText: 'Enter Password'.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(signInController.showPassword.value
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                signInController.togglePasswordVisibility();
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
                ? AppColors.whiteColor
                : AppColors.primaryColor,
          ),
          onSubmitted: (value) {
                if (signInController.validatePassword(signInController.passwordController.text)) {
           // if (signInController.passwordController.text == _defaultPass) {
              storage.write('isLoggedIn', true);
              Get.toNamed(Routes.settingScreen);
              signInController.passwordController.clear();
            }
          },
        ),
      ),
    );
  }
}
