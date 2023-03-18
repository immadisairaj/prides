import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  testWidgets('backgroundless slide test', (tester) async {
    const slideKey = Key('slideWidget');
    final slide = Container(key: slideKey);
    await WidgetsTestHelper.pumpApp(
      tester,
      BackgroundlessSlide(slide: slide),
    );

    // Expect: background widget
    expect(find.byKey(slideKey), findsOneWidget);
  });
}
