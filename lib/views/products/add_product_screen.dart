import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddProductScreen extends StatelessWidget {
  final Product product;

  const AddProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final ThemeController cont = Get.put(ThemeController());
    String imageUrl = "https://ava.sa/app/storage/uploads/is_cover_image/${product.imagePath}";

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
      body: Padding(
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
            // Product Name
            Text("English Name: ${product.name}", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
                    ? AppColors.whiteColor
                    : AppColors.primaryColor,
              ),
            ),
                  Text("Arabic Name: ${product.namearabic}",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // Description

             Text("English Description: ${product.description}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),

              
            Text("Arabic Description: ${product.descriptionarabic}",
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Product ID & Price
            
     
             
                Text("Product ID: ${product.id}", 
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),
                
                // Text("Selection ID: ${product.tid}", style: const TextStyle(fontSize: 16)),
              
            
            const SizedBox(height: 10),
            Text("Price: ${product.price}\SR",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(height: 10),
            Text("Timer: ${product.timer}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}