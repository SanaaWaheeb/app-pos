// import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
// import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/views/products/add_product_screen.dart';
import 'package:demo_nfc/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  final storage = GetStorage();
  final ThemeController cont = Get.put(ThemeController());
  final DeviceSettingController devController =
      Get.put(DeviceSettingController());

  @override
  void initState() {
    super.initState();
    devController.fetchProducts(); // Fetch products when the page opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products".tr,
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
      body: Obx(() {
        if (devController.products.isEmpty) {
          return Center(
            child: Text(
              "No products available".tr,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                color:
                    storage.read('isDarkMode') == true || cont.isDarkTheme.value
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: devController.products.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final product = devController.products[index];
            return Dismissible(
              key: Key(product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                devController.products.removeAt(index);
                Get.snackbar(
                  "Deleted".tr,
                  "Product removed".tr,
                  snackPosition: SnackPosition.TOP,
                );
              },
              background: Container(
                color: AppColors.primaryColor,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.secondaryColor.withOpacity(0.4)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    customRow(
                      title: product.name,
                      onTap: () {
                        Get.to(() => AddProductScreen(
                              product: product,
                              
                            ));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor:
      //       storage.read('isDarkMode') == true || cont.isDarkTheme.value
      //           ? AppColors.whiteColor
      //           : AppColors.primaryColor,
      //   onPressed: () {
      //     Get.toNamed(Routes.addProductScreen);
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
      //         ? AppColors.primaryColor
      //         : AppColors.whiteColor,
      //   ),
      // ),
    );
  }
}
