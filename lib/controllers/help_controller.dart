import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../models/help/help_model.dart';

class HelpController extends GetxController {
  final ThemeController cont = Get.find();
  final storage = GetStorage();
  TextEditingController titleCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final Box<Help> helpBox = Hive.box<Help>('helpBox');
  String? imagePickPath;


 @override
  void onInit() {
    super.onInit();
    loadHelpData();
  }

  void loadHelpData() {
    titleCont.text = storage.read('helpTitle') ?? '';
    descCont.text = storage.read('helpDescription') ?? '';
    imagePickPath = storage.read('helpImagePath');
    update();
  }



  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final String imagePath = pickedFile.path;
      helpBox.add(Help(
        title: titleCont.text,
        description: descCont.text,
        imagePath: imagePath,
      ));
      storage.write('helpTitle', titleCont.text);
      storage.write('helpDescription', descCont.text);
      storage.write('helpImagePath', imagePickPath);
      imagePickPath = pickedFile.path;
      update();
    }
  }

  void saveHelp() {
    Get.snackbar(
      "Success".tr,
      "Help Instructions Saved Successfully".tr,
      snackPosition: SnackPosition.TOP,
    );
    Get.toNamed(Routes.settingScreen);
  }
}
