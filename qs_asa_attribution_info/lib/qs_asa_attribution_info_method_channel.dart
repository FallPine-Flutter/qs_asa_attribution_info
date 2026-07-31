import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qs_asa_attribution_info_platform_interface.dart';

/// An implementation of [QsAsaAttributionInfoPlatform] that uses method channels.
class MethodChannelQsAsaAttributionInfo extends QsAsaAttributionInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qs_asa_attribution_info');

  @override
  Future<String?> getAttributionToken() {
    return methodChannel.invokeMethod<String>('getAttributionToken');
  }

  @override
  Future<Map<String, dynamic>?> getAttributionInfo() async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
      'getAttributionInfo',
    );
    return result;
  }
}
