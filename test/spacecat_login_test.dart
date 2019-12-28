import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacecat_login/spacecat_login.dart';

void main() {
  const MethodChannel channel = MethodChannel('spacecat_login');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await SpacecatLogin.platformVersion, '42');
  });
}
