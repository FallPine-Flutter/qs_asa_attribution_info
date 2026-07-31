import 'qs_asa_attribution_info_platform_interface.dart';

class QsAsaAttributionInfo {
  static Future<String?> getAttributionToken() async {
    try {
      return await QsAsaAttributionInfoPlatform.instance.getAttributionToken();
    } catch (_) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getAttributionInfo() async {
    try {
      return await QsAsaAttributionInfoPlatform.instance.getAttributionInfo();
    } catch (_) {
      return null;
    }
  }
}
