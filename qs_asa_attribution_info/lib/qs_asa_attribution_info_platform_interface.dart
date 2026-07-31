import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qs_asa_attribution_info_method_channel.dart';

abstract class QsAsaAttributionInfoPlatform extends PlatformInterface {
  /// Constructs a QsAsaAttributionInfoPlatform.
  QsAsaAttributionInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static QsAsaAttributionInfoPlatform _instance =
      MethodChannelQsAsaAttributionInfo();

  /// The default instance of [QsAsaAttributionInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelQsAsaAttributionInfo].
  static QsAsaAttributionInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QsAsaAttributionInfoPlatform] when
  /// they register themselves.
  static set instance(QsAsaAttributionInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getAttributionToken() {
    throw UnimplementedError('getAttributionToken() has not been implemented.');
  }

  Future<Map<String, dynamic>?> getAttributionInfo() {
    throw UnimplementedError('getAttributionInfo() has not been implemented.');
  }
}
