import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/colors.dart';

Widget customRow({
  required String title,
  GestureTapCallback? onTap,
}) {
  final storage = GetStorage();
  final ThemeController cont = Get.put(ThemeController());
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
            ? AppColors.secondaryColor.withOpacity(0.4)
            : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
