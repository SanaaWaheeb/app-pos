import 'dart:io';
import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;
  final int? productIndex;

  const AddProductScreen({super.key, this.product, this.productIndex});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final storage = GetStorage();
  late Box<Product> productBox;
  final ThemeController cont = Get.put(ThemeController());

  late TextEditingController _nameController;
  late TextEditingController _nameArabicController;
  late TextEditingController _descriptionController;
  late TextEditingController _descrArabicController;
  late TextEditingController _priceController;
  late TextEditingController _productIdController;
  late TextEditingController _trackIdController;
  late TextEditingController _timeController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<Product>('productsBox');
    _nameController = TextEditingController(text: widget.product?.name);
    _nameArabicController =
        TextEditingController(text: widget.product?.namearabic);
    _descriptionController =
        TextEditingController(text: widget.product?.description);
    _descrArabicController =
        TextEditingController(text: widget.product?.descriptionarabic);
    _priceController = TextEditingController(
        text: widget.product?.price.toDouble().toString());
    _timeController = TextEditingController(text: widget.product?.timer);
    _productIdController = TextEditingController(text: widget.product?.id);
    _trackIdController = TextEditingController(text: widget.product?.tid);
    _imagePath = widget.product?.imagePath;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      double? parsedPrice = double.tryParse(_priceController.text);
      final newProduct = Product(
        name: _nameController.text,
        description: _descriptionController.text,
        price: parsedPrice!.toDouble(),
        timer: _timeController.text,
        imagePath: _imagePath ?? '',
        id: _productIdController.text,
        tid: _trackIdController.text,
        namearabic: _nameArabicController.text,
        descriptionarabic: _descrArabicController.text,
      );

      if (widget.productIndex != null) {
        productBox.putAt(widget.productIndex!, newProduct);
      } else {
        productBox.add(newProduct);
      }

      Get.toNamed(Routes.productViewScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product != null ? 'Edit Product'.tr : 'Add Product'.tr,
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
        child: Form(
          key: _formKey,
          child: ListView(
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
                    side: const BorderSide(width: 1, color: Color(0xFFF0F1F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'Product Name'.tr,
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
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product name'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _nameArabicController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'Product Name (Arabic)'.tr,
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
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product name (Arabic)'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 4,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Product Description'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descrArabicController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Product Description (Arabic)'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description (Arabic)'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _productIdController,
                        decoration: InputDecoration(
                          labelText: 'Product ID'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a ID'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _trackIdController,
                        decoration: InputDecoration(
                          labelText: 'Selection ID'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Selection ID'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Product Price'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          labelText: 'Timer'.tr,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: storage.read('isDarkMode') == true ||
                                  cont.isDarkTheme.value
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the time'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickImage,
                        child: _imagePath != null
                            ? Container(
                                height: Get.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Image.file(
                                  File(_imagePath!),
                                  height: Get.height * 0.25,
                                ),
                              )
                            : Container(
                                height: Get.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: const Icon(Icons.camera_alt, size: 100),
                              ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        borderRadius: 35,
                        customheight: Get.height * 0.065,
                        btnText: widget.product != null
                            ? 'Save Changes'.tr
                            : 'Add Product'.tr,
                        btnColor: AppColors.primaryColor,
                        btnTextStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                        onTap: () {
                          _saveProduct();
                          Get.snackbar(
                            "Success".tr,
                            "Product settings saved successfully".tr,
                            snackPosition: SnackPosition.TOP,
                          );
                          Get.toNamed(Routes.settingScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
