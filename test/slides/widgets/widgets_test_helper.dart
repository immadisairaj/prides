import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetsTestHelper {
  /// Pump app for testing widgets. This pumps the app with the [widget]
  /// using the [tester]
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

  /// Returns the mock context using [tester].
  /// Ensure [pumpApp] is already called before.
  static BuildContext mockContext(WidgetTester tester) {
    return tester.element(find.byType(Material));
  }
}
