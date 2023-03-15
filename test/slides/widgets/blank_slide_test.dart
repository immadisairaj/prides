import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  testWidgets('blank slide test', (tester) async {
    const backgroundKey = Key('backgroundWidget');
    final background = Container(key: backgroundKey);
    await WidgetsTestHelper.pumpApp(
      tester,
      BlankSlide(background: background),
    );

    // Expect: background widget
    expect(find.byKey(backgroundKey), findsOneWidget);
  });
}
