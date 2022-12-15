import 'package:flutter/services.dart';

class SharedMethodChannel {
  const SharedMethodChannel._();

  static const MethodChannel _channel = MethodChannel('shared_method_channel');

  static Future<void> setSharedValue(String key, String value) async {
    await _channel.invokeMethod('setSharedValue', {
      'key': key,
      'value': value,
    });
  }

  static Future<String?> getSharedValue(String key) async {
    try {
      final getSharedValue =
          await _channel.invokeMethod('getSharedValue', {'key': key});
      return getSharedValue;
    } catch (e) {
      return null;
    }
  }
}
