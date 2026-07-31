// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:qs_asa_attribution_info/qs_asa_attribution_info.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('static plugin api can be called', (WidgetTester tester) async {
    final String? token = await QsAsaAttributionInfo.getAttributionToken();

    expect(token, isA<String?>());
  });
}
