import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  testWidgets('simple slide test', (tester) async {
    const slideKey = Key('slideWidget');
    final slide = Container(key: slideKey);
    const backgroundKey = Key('backgroundWidget');
    final background = Container(key: backgroundKey);
    await WidgetsTestHelper.pumpApp(
      tester,
      SimpleSlide(slide: slide, background: background),
    );

    // Expect: slide and background widgets
    expect(find.byKey(slideKey), findsOneWidget);
    expect(find.byKey(backgroundKey), findsOneWidget);
  });
}
