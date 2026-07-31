import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qs_asa_attribution_info/qs_asa_attribution_info_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('qs_asa_attribution_info');
  final platform = MethodChannelQsAsaAttributionInfo();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getAttributionToken':
              return 'token';
            case 'getAttributionInfo':
              return <String, dynamic>{
                'attribution': true,
                'campaignId': 542370539,
              };
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getAttributionToken returns native token', () async {
    expect(await platform.getAttributionToken(), 'token');
  });

  test('getAttributionInfo returns native attribution map', () async {
    final result = await platform.getAttributionInfo();

    expect(result, isNotNull);
    expect(result?['attribution'], isTrue);
    expect(result?['campaignId'], 542370539);
  });
}
