import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetsTestHelper {
  static Future<void> pumpApp(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: widget,
        ),
      ),
    );
  }
}
