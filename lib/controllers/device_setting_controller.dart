import 'package:demo_nfc/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:demo_nfc/models/product_model.dart';

class DeviceSettingController extends GetxController {
  TextEditingController boardIdCont = TextEditingController();
  TextEditingController machineIdCont = TextEditingController();
  TextEditingController createdByCont = TextEditingController();
  TextEditingController secondBeforeCont = TextEditingController();
  TextEditingController secondAfterCont = TextEditingController();

  late Box settingsBox;

  // Observable list to store products fetched from the API
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    settingsBox = Hive.box('settingsBox');
    loadSettings();
  }

  void loadSettings() {
    boardIdCont.text = settingsBox.get('boardId', defaultValue: '');
    machineIdCont.text = settingsBox.get('machineId', defaultValue: '');
    createdByCont.text = settingsBox.get('createdBy', defaultValue: '');
    secondBeforeCont.text = settingsBox.get('secondBefore', defaultValue: '');
    secondAfterCont.text = settingsBox.get('secondAfter', defaultValue: '');

    // If board ID exists, fetch machine ID automatically
    if (boardIdCont.text.isNotEmpty) {
      fetchMachineDetails(boardIdCont.text);
    }
  }

  Future<void> saveSettings() async {
    String boardId = boardIdCont.text.trim();
    if (boardId.isEmpty) {
      return;
    }

    await settingsBox.put('boardId', boardId);
    await settingsBox.put('secondBefore', secondBeforeCont.text);
    await settingsBox.put('secondAfter', secondAfterCont.text);
    debugPrint('Board ID: $boardId');
    debugPrint('Second Before Starting: ${secondBeforeCont.text}');
    debugPrint('Second After Starting: ${secondAfterCont.text}');

    try {
      // Fetch Machine details first
      Map<String, dynamic>? machineDetails =
          await ApiService.fetchMachineDetails(boardId);

      if (machineDetails != null) {
        String machineId = machineDetails["id"].toString();
        String createdBy = machineDetails["created_by"].toString();

        // Update UI fields
        machineIdCont.text = machineId;
        createdByCont.text = createdBy;

        // Save settings after fetching machine details
        await settingsBox.put('machineId', machineId);
        await settingsBox.put('createdBy', createdBy);

        debugPrint('Settings saved successfully:');
        debugPrint('Machine ID: $machineId');
        debugPrint('Created By: $createdBy');
      } else {
        Get.snackbar("Error", "Machine not found for this Board ID.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save settings: ${e.toString()}");
    }
  }

  // Fetch machine ID based on Board ID and store it
  Future<void> fetchMachineDetails(String boardId) async {
    try {
      Map<String, dynamic>? response =
          await ApiService.fetchMachineDetails(boardId);
      if (response != null) {
        String machineId = response["id"].toString();
        String createdBy = response["created_by"].toString();

        machineIdCont.text = machineId;
        createdByCont.text = createdBy;

        await settingsBox.put('machineId', machineId);
        await settingsBox.put('createdBy', createdBy);

        debugPrint("Fetched Machine ID: $machineId");
        debugPrint("Fetched Created By: $createdBy");
      } else {
        Get.snackbar("Error", "Machine ID not found for this Board ID");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch Machine ID: ${e.toString()}");
    }
  }

  // Fetch products based on entered Board ID
  Future<void> fetchProducts() async {
    String boardId = boardIdCont.text.trim();

    if (boardId.isEmpty) {
      Get.snackbar("Error", "Board ID cannot be empty");
      return;
    }

    try {
      var response = await ApiService.fetchProducts(boardId);
      products.value =
          response.map<Product>((json) => Product.fromJson(json)).toList();

      debugPrint("Fetched ${products.length} products.");
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products: ${e.toString()}");
    }
  }
}
