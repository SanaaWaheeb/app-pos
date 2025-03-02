import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget customTextField({TextEditingController? controller, String? hintText}) {
  final storage = GetStorage();
   final ThemeController cont = Get.put(ThemeController());
  return SizedBox(
    height: Get.height * 0.065,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
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
    ),
  );
}
