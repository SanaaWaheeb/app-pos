import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';

class ResetPassController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late Box passwordBox;

  @override
  void onInit() {
    super.onInit();
    passwordBox = Hive.box('passwordBox');
  
  }
  String get currentPassword =>
      passwordBox.get('userPassword', defaultValue: "0000");

  bool validateOldPassword(String inputPassword) {
    return inputPassword == currentPassword;
  }

  bool validateNewPassword(String newPassword, String confirmPassword) {
    return newPassword == confirmPassword;
  }

  void updatePassword(String newPassword) {
    passwordBox.put('userPassword', newPassword);
  }
  
 @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
