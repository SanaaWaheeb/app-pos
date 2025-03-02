import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/info_controller.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class InformationScreen extends StatelessWidget {
  InformationScreen({super.key});
  final ThemeController cont = Get.put(ThemeController());
  final InfoController infoCont = Get.put(InfoController());
  final storage = GetStorage();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Information".tr,
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: storage.read('isDarkMode') == true ||
                            cont.isDarkTheme.value
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
                            hintText: "Tittle",
                            controller: infoCont.titleController),
                        const SizedBox(height: 20),
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller: infoCont.textController,
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
                            color: storage.read('isDarkMode') == true ||
                                    cont.isDarkTheme.value
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
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var box = Hive.box('infoBox');
                      await box.put('title', infoCont.titleController.text);
                      await box.put(
                          'description', infoCont.textController.text);
                    }
                    Get.snackbar(
                      "Success".tr,
                      "Information Saved Successfully".tr,
                      snackPosition: SnackPosition.TOP,
                    );
                    Get.toNamed(Routes.settingScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
