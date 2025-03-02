// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SignInController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final RxBool showPassword = false.obs;

  final _defaultPass = "0000";
  late Box passwordBox;
 late Box appBox;

  @override
  void onInit() {
    super.onInit();
    passwordBox = Hive.box('passwordBox');
    appBox = Hive.box('appBox');
    _initializePassword();
  }

  void _initializePassword() {
    bool? isFirstLaunch = appBox.get('isFirstLaunch', defaultValue: true);
    
    if (isFirstLaunch == true) {
      // Set the default password and update the flag
      passwordBox.put('userPassword', _defaultPass);
      appBox.put('isFirstLaunch', false);
      debugPrint('Default password set: $_defaultPass');
    } else {
      debugPrint('Password already set: ${passwordBox.get('userPassword')}');
    }
  }


  String get currentPassword =>
      passwordBox.get('userPassword', defaultValue: _defaultPass);

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  bool validatePassword(String inputPassword) {
    debugPrint('Validating password: $inputPassword against stored password: $currentPassword');
    return inputPassword == currentPassword;
  }

  void updatePassword(String newPassword) {
    passwordBox.put('userPassword', newPassword);
  }

  void resetPassword() {
    passwordBox.delete('userPassword');
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
