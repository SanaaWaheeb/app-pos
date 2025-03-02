import 'dart:async';
import 'package:demo_nfc/config/colors.dart';
import 'package:demo_nfc/config/images.dart';
import 'package:demo_nfc/controllers/theme_controller.dart';
import 'package:demo_nfc/models/product_model.dart';
import 'package:demo_nfc/nearpay_services/nearpay_services.dart';
import 'package:demo_nfc/views/dashboard/dashboard_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'mqtt_service.dart';
import 'package:demo_nfc/views/successfull%20screens/successfull_screen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final double productPrice;
  final Product itemProduct;
  PaymentProcessingScreen(
      {super.key, required this.productPrice, required this.itemProduct});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  final ThemeController cont = Get.put(ThemeController());

  final storage = GetStorage();

  // connection and data communication channels
  late StreamSubscription<MqttConnectionState> mqttConnectionStateSubscription;
  late StreamSubscription<EspMessage> espMessageSubscription;

  // create mqtt service instance
  final mqttService = MqttService();

  // timeouts
  int connectionTimeOut = 10; // seconds
  int returnToHomeTimeout = 20; // seconds

  int connectState = 0;

  @override
  void dispose() {
    // cancel subscriptions
    mqttConnectionStateSubscription.cancel();
    espMessageSubscription.cancel();

    // close mqtt connection
    mqttService.disconnect();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // subscribe to connection state stream
    mqttConnectionStateSubscription =
        mqttService.mqttConnectionStateStream.listen(null);
    mqttConnectionStateSubscription.onData(onMqttConnectionState);

    // subscribe to MQTT message stream
    espMessageSubscription = mqttService.espMessageStream.listen(null);
    espMessageSubscription.onData(onEspMessage);

    // make mqtt connection if not already connected
    Future.delayed(Duration.zero, () async {
      await connectMqttService();
      // send connection message over mqtt
      mqttService.publishMessage(mqttService.MQTT_PING, "ping");

      // connection timeout - if no response is received, navigate to show error
      Future.delayed(Duration(seconds: connectionTimeOut), () {
        if (connectState == 0) {
          print('MQTT: Connection failed.');
          setState(() {
            connectState = 2;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              storage.read('isDarkMode') == true || cont.isDarkTheme.value
                  ? DefaultImages.darkBgImage
                  : DefaultImages.backgImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  DefaultImages.logo,
                  width: Get.width * 0.4,
                  height: Get.height * 0.2,
                ),
                SizedBox(height: 20),
                getConnectionStatus(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center getConnectionStatus() {
    // Checking connection widget
    Center connectionChecking = Center(
      child: Container(
        width: 300, // Fixed width for proper centering
        decoration: BoxDecoration(
          color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
              ? AppColors.secondaryColor.withOpacity(0.4)
              : AppColors.whiteColor,
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 80.0), // Add padding to move it to the left
                child: Lottie.asset(
                  'assets/json/check.json', // Path to your first Lottie JSON file
                  width: 100, // You can adjust the size as needed
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Machine Checking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor,
                ),
              ),
              Text(
                'فحص الجهاز',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // connection failed widget
    Center connectionFail = Center(
      child: Container(
        width: 300, // Fixed width for proper centering
        decoration: BoxDecoration(
          color: storage.read('isDarkMode') == true || cont.isDarkTheme.value
              ? AppColors.secondaryColor.withOpacity(0.4)
              : AppColors.whiteColor,
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 50.0), // Add padding to move it to the left
                child: Lottie.asset(
                  'assets/json/fail.json', // Path to your first Lottie JSON file
                  width: 150, // You can adjust the size as needed
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Machine Failure',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor,
                ),
              ),
              Text(
                'هناك خلل في الجهاز',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: storage.read('isDarkMode') == true ||
                          cont.isDarkTheme.value
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (connectState == 0) {
      // show connecting widget
      return connectionChecking;
    } else if (connectState == 1) {
      // on successful connection and response, show nearpay dialog
      Future.delayed(Duration(milliseconds: 500), () {
        NearpayService().makePurchase(
          widget.productPrice.toInt(),
          '123',
          widget.itemProduct,
          onSuccess: () {
            Get.offAll(() => SuccessfullScreen(product: widget.itemProduct));
          },
          onFailure: (error) {
            Get.offAll(() => DashboardViewScreen());
            debugPrint("Purchase failed with error: $error");
          },
        );
      });
      // Disconnect the MQTT client after the purchase is made
      mqttService.disconnect();
      return Center();
    } else if (connectState == 2) {
      // wait for set timeout and return to home
      Future.delayed(Duration(seconds: returnToHomeTimeout), () {
        Get.offAll(() => DashboardViewScreen());
        dispose();
      });

      // connection timed out
      return connectionFail;
    }

    // default empty widget
    return Center();
  }

  /// Connect mqttService
  connectMqttService() async {
    if (mqttService.connectionState == MqttConnectionState.connected) {
      return true;
    }

    bool connected = await mqttService.connect(
      mqttBroker: '87eed7305e314a3d8fd7beab1933abe8.s1.eu.hivemq.cloud',
      port: 8883, // Use 1883 for non-TLS
      login: 'avamqtt',
      password: 'Ava@1234',
      deviceId: mqttService.MQTT_DEVICE_ID,
    );

    return connected;
  }

  void onMqttConnectionState(MqttConnectionState mqttConnectionState) {
    print('Connection State: ${mqttConnectionState.toString().split('.')[1]}');
  }

  /// process ESP Message data
  void onEspMessage(EspMessage espMessage) {
    print(
        '=====> MQTT Topic: ${espMessage.command}, Payload: ${espMessage.parameter}');

    if (espMessage.command == mqttService.MQTT_RESPONSE) {
      print('MQTT: Got MQTT response. Successfully connected.');
      setState(() {
        connectState = 1;
      });
    }
  }
}
