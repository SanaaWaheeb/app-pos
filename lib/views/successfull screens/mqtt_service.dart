import 'dart:async';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:demo_nfc/controllers/device_setting_controller.dart';
import 'package:get/get.dart';

/// This class is used to carry MQTT commands and Responses
class EspMessage {
  String? command;
  String? parameter;

  EspMessage({this.command, this.parameter});
}

class MqttService {
  // Get the deviceSettingController instance
  final deviceSettingController = Get.put(DeviceSettingController());

  // IoT MQTT Topics
  late String MQTT_PING;
  late String MQTT_RESPONSE;
  late String MQTT_DEVICE_ID;

  String? deviceId;

  // mqtt client
  late MqttServerClient _mqttClient;
  // stream controllers for easy connection state and message handling anywhere in app
  late StreamController<EspMessage> _espMessageStream;
  late StreamController<MqttConnectionState> _mqttConnectionStateStream;

  // streams init
  Stream<MqttPublishMessage> get mqttMessageStream => _mqttClient.published!;
  Stream<EspMessage> get espMessageStream => _espMessageStream.stream;
  Stream<MqttConnectionState> get mqttConnectionStateStream =>
      _mqttConnectionStateStream.stream;
  MqttConnectionState get connectionState =>
      _mqttClient.connectionStatus!.state;

  // constructor
  MqttService() {
    // Fetch the machine ID from deviceSettingController
    String machineId =
        deviceSettingController.settingsBox.get('boardId', defaultValue: '');

    // Initialize the topics using the fetched machine ID
    MQTT_PING = "/PING/$machineId";
    MQTT_RESPONSE = "/RESPONSE/$machineId";
    MQTT_DEVICE_ID = machineId;

    _mqttClient = new MqttServerClient('', '');
    _espMessageStream = new BehaviorSubject();
    _mqttConnectionStateStream = new BehaviorSubject();
  }

  // clean up on dispose
  dispose() {
    _mqttClient.disconnect();
    _espMessageStream.close();
    _mqttConnectionStateStream.close();
  }

  // connect to mqtt broker
  Future<bool> connect({
    String mqttBroker = "",
    int port = 0,
    String login = "",
    String password = "",
    String deviceId = "",
  }) async {
    // cleanup
    if (_mqttClient.connectionStatus!.state == MqttConnectionState.connected)
      _mqttClient.disconnect();

    this.deviceId = deviceId;

    // set initial connection state
    _mqttConnectionStateStream.sink.add(MqttConnectionState.connecting);

    // setup mqtt client options
    _mqttClient = MqttServerClient.withPort(mqttBroker, deviceId, port);
    _mqttClient.logging(on: true);
    _mqttClient.keepAlivePeriod = 20;
    _mqttClient.secure = true; // Enable TLS/SSL
    _mqttClient.onConnected = _onConnected;
    _mqttClient.onDisconnected = _onDisconnected;
    _mqttClient.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(deviceId)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    _mqttClient.connectionMessage = connMessage;

    try {
      // attempt connection
      await _mqttClient.connect(login, password);
    } on Exception catch (e) {
      print('_mqttClient::client exception - $e');
      _mqttClient.disconnect();
      return false;
    }

    if (_mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      return true;
    } else {
      print(
          '_mqttClient::ERROR connection failed - disconnecting, status is ${_mqttClient.connectionStatus}');
      _mqttClient.disconnect();
      return false;
    }
  }

  // disconnect from mqtt broker
  void disconnect() {
    _mqttClient.disconnect();
  }

  // event handler for successful connection
  void _onConnected() {
    print('_mqttClient::_OnConnected Client connection was successful');

    // subscribe to topics
    _mqttClient.subscribe(
      MQTT_RESPONSE,
      MqttQos.atMostOnce,
    );

    _mqttConnectionStateStream.sink.add(MqttConnectionState.connected);

    _mqttClient.updates!.listen(_onData);
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    print(
      '_mqttClient::_OnDisconnected client callback - Client disconnection',
    );
    if (_mqttClient.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print(
        '_mqttClient::_OnDisconnected callback is solicited, this is correct',
      );
    }
    _mqttConnectionStateStream.sink.add(MqttConnectionState.disconnected);
  }

  // event handler for on topic subscription
  void _onSubscribed(String topic) {
    print('_mqttClient::_onSubscribed confirmed for topic $topic');
  }

  // publish message to mqtt broker on given topic with payload
  void publishMessage(String topic, String payload) {
    if (_mqttClient.connectionStatus!.state != MqttConnectionState.connected) {
      print(
        '_mqttClient::sendCommand called while MqttConnectionState is not Connected',
      );
      return;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    _mqttClient.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  // mqtt on data callback handler
  void _onData(List<MqttReceivedMessage<MqttMessage>> messages) {
    messages.forEach((listItem) {
      MqttPublishMessage message = listItem.payload as MqttPublishMessage;

      final topic = listItem.topic;
      final payload = MqttPublishPayload.bytesToStringAsString(
        message.payload.message,
      );

      print('_mqttClient::_onData topic: $topic, payload: $payload');

      _espMessageStream.sink.add(EspMessage(
        command: topic,
        parameter: payload,
      ));
    });
  }
}
