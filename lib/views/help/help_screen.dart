import 'dart:io';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/help_controller.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  final HelpController controller = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Help".tr,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: controller.storage.read('isDarkMode') == true ||
                    controller.cont.isDarkTheme.value
                ? AppColors.whiteColor
                : AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: GetBuilder<HelpController>(
            builder: (_) => Column(
              children: [
                Container(
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: controller.storage.read('isDarkMode') == true ||
                            controller.cont.isDarkTheme.value
                        ? AppColors.secondaryColor.withOpacity(0.4)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        customTextField(
                            hintText: "Title".tr,
                            controller: controller.titleCont),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.descCont,
                          textAlign: TextAlign.center,
                          maxLines: 8,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: 'Enter Text Here'.tr,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color:
                                controller.storage.read('isDarkMode') == true ||
                                        controller.cont.isDarkTheme.value
                                    ? Colors.grey
                                    : AppColors.primaryColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: controller.imagePickPath != null
                              ? Container(
                                  height: Get.height * 0.25,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Image.file(
                                    File(controller.imagePickPath!),
                                    height: Get.height * 0.25,
                                  ),
                                )
                              : Container(
                                  height: Get.height * 0.25,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child:
                                      const Icon(Icons.camera_alt, size: 100),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  borderRadius: 35,
                  customheight: Get.height * 0.065,
                  btnText: "Save".tr,
                  btnColor: AppColors.primaryColor,
                  btnTextStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                  onTap: controller.saveHelp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
