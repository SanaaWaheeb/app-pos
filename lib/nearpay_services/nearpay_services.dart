import 'package:demo_nfc/Routes/app_pages.dart';
import 'package:demo_nfc/models/nearpay_Model.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/nearpay_services/nearpay_authentication.dart';
import 'package:demo_nfc/views/successfull%20screens/successfull_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nearpay_flutter_sdk/errors/purchase_error/purchase_error.dart';
import 'package:nearpay_flutter_sdk/models/transaction_receipt/transaction_receipt.dart';
import 'package:nearpay_flutter_sdk/nearpay.dart';
import 'package:uuid/uuid.dart';

class NearpayService {
  static final NearpayService _instance = NearpayService._internal();
  factory NearpayService() => _instance;

  NearpayService._internal();

  static final Nearpay nearpay = Nearpay(
    authType: AuthenticationType.email,
    authValue: "info@ava.com.sa",
    env: Environments.production,
    locale: Locale.localeDefault,
  );

  Future<void> initializeNearpay() async {
    await nearpay.initialize().catchError((e) {
      debugPrint("Nearpay initialization error: $e");
    });
    debugPrint("After Nearpay initialization");
  }

  Future<void> loginUser(String input) async {
    Map<String, dynamic> authData;

    if (input.startsWith("jwt")) {
      authData = AuthenticationData.loginWithJWT(input);
    } else if (input.startsWith("+")) {
      authData = AuthenticationData.loginWithMobile(input);
    } else {
      authData = AuthenticationData.loginWithEmail(input);
    }

    await nearpay.setup().catchError((e) {
      debugPrint(e.toString());
    });
  }

  NearPayModel? nearPayData;
  Future<void> makePurchase(
      int amount, String customerReferenceNumber, Product product,
      {Function()? onSuccess, Function(String error)? onFailure}) async {
    try {
      final TransactionData response = await nearpay.purchase(
        amount: amount,
        transactionId: const Uuid().v4(),
        customerReferenceNumber: customerReferenceNumber,
        enableReceiptUi: true,
        enableReversalUi: true,
        enableUiDismiss: true,
        finishTimeout: 0,
      );
      debugPrint("Transaction Data: ${response.toJson()}");

      if (response.receipts != null && response.receipts!.isNotEmpty) {
        final transactionId = response.receipts![0].transaction_uuid;
        final box = GetStorage();
        await box.write('transactionId', transactionId);
        debugPrint("Transaction ID: $transactionId");

        Map<String, dynamic> jsonResponse = response.toJson();
        nearPayData = NearPayModel.fromJson(jsonResponse);

        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null) onFailure("No receipts found in the response");
        debugPrint("No receipts found in the response");
      }
    } catch (error) {
      if (error is PurchaseAuthenticationFailed) {
        debugPrint('Purchase authentication failed');
      } else if (error is PurchaseGeneralFailure) {
        debugPrint('General purchase failure');
      } else if (error is PurchaseInvalidStatus) {
        debugPrint('Invalid purchase status');
      } else if (error is PurchaseDeclined) {
        debugPrint('Purchase declined');
      } else if (error is PurchaseRejected) {
        debugPrint('Purchase rejected');
      } else {
        debugPrint('Unexpected error occurred: $error');
      }
      if (onFailure != null) onFailure(error.toString());
    }
  }
}
