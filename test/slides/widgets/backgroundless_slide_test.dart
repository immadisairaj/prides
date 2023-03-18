import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  testWidgets('backgroundless slide test', (tester) async {
    const slideKey = Key('slideWidget');
    final slide = Container(key: slideKey);
    final widget = BackgroundlessSlide(slide: slide);
    await WidgetsTestHelper.pumpApp(tester, widget);

    // Expect: slide widget
    expect(find.byKey(slideKey), findsOneWidget);

    // Expect: slide
    final context = WidgetsTestHelper.mockContext(tester);
    final slideResult = widget.slide(context);
    expect(slideResult, slide);

    // Expect: backgrund to be null
    final backgroundResult = widget.background();
    expect(backgroundResult, null);
  });
}
