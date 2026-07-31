import 'package:flutter_test/flutter_test.dart';
import 'package:qs_asa_attribution_info/qs_asa_attribution_info.dart';
import 'package:qs_asa_attribution_info/qs_asa_attribution_info_platform_interface.dart';
import 'package:qs_asa_attribution_info/qs_asa_attribution_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQsAsaAttributionInfoPlatform
    with MockPlatformInterfaceMixin
    implements QsAsaAttributionInfoPlatform {
  MockQsAsaAttributionInfoPlatform({this.isThrowError = false});

  final bool isThrowError;

  @override
  Future<String?> getAttributionToken() async {
    if (isThrowError) {
      throw Exception('get attribution token failed');
    }
    return 'token';
  }

  @override
  Future<Map<String, dynamic>?> getAttributionInfo() async {
    if (isThrowError) {
      throw Exception('get attribution info failed');
    }
    return <String, dynamic>{'attribution': true, 'campaignId': 542370539};
  }
}

void main() {
  final QsAsaAttributionInfoPlatform initialPlatform =
      QsAsaAttributionInfoPlatform.instance;

  test('$MethodChannelQsAsaAttributionInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQsAsaAttributionInfo>());
  });

  test('getAttributionToken', () async {
    MockQsAsaAttributionInfoPlatform fakePlatform =
        MockQsAsaAttributionInfoPlatform();
    QsAsaAttributionInfoPlatform.instance = fakePlatform;

    expect(await QsAsaAttributionInfo.getAttributionToken(), 'token');
  });

  test('getAttributionInfo', () async {
    MockQsAsaAttributionInfoPlatform fakePlatform =
        MockQsAsaAttributionInfoPlatform();
    QsAsaAttributionInfoPlatform.instance = fakePlatform;

    final result = await QsAsaAttributionInfo.getAttributionInfo();

    expect(result, isNotNull);
    expect(result?['attribution'], isTrue);
    expect(result?['campaignId'], 542370539);
  });

  test('getAttributionToken returns null when platform throws', () async {
    MockQsAsaAttributionInfoPlatform fakePlatform =
        MockQsAsaAttributionInfoPlatform(isThrowError: true);
    QsAsaAttributionInfoPlatform.instance = fakePlatform;

    expect(await QsAsaAttributionInfo.getAttributionToken(), isNull);
  });

  test('getAttributionInfo returns null when platform throws', () async {
    MockQsAsaAttributionInfoPlatform fakePlatform =
        MockQsAsaAttributionInfoPlatform(isThrowError: true);
    QsAsaAttributionInfoPlatform.instance = fakePlatform;

    expect(await QsAsaAttributionInfo.getAttributionInfo(), isNull);
  });
}
