import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/widgets/custom_textfield.dart'; // Import customTextField
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';

class AddProductScreen extends StatelessWidget {
  final Product product;

  final DeviceSettingController deviceController =
      Get.find<DeviceSettingController>(); // Access DeviceSettingController

  AddProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final ThemeController cont = Get.put(ThemeController());
    String imageUrl =
        "https://ava.sa/app/storage/uploads/is_cover_image/${product.imagePath}";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details'.tr,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // English Name
            _buildTitle("English Name"),
            customTextField(
              hintText: "English Name",
              controller: TextEditingController(text: product.name),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // Arabic Name
            _buildTitle("Arabic Name"),
            customTextField(
              hintText: "Arabic Name",
              controller: TextEditingController(text: product.namearabic),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // English Description
            _buildTitle("English Description"),
            customTextField(
              hintText: "English Description",
              controller: TextEditingController(text: product.description),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // Arabic Description
            _buildTitle("Arabic Description"),
            customTextField(
              hintText: "Arabic Description",
              controller:
                  TextEditingController(text: product.descriptionarabic),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // Product ID
            _buildTitle("Product ID"),
            customTextField(
              hintText: "Product ID",
              controller: TextEditingController(text: product.id.toString()),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // Price
            _buildTitle('Price (${deviceController.currencyCont.text})'),
            customTextField(
              hintText: "Price",
              controller: TextEditingController(
                  text:
                      "${product.price} ${deviceController.currencyCont.text}"),
              readOnly: true,
            ),

            const SizedBox(height: 10),

            // Timer
            _buildTitle("Timer"),
            customTextField(
              hintText: "Timer",
              controller: TextEditingController(text: product.timer.toString()),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create title for each field
  Widget _buildTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          title.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
