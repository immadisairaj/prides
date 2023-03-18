import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  testWidgets('blank slide test', (tester) async {
    const backgroundKey = Key('backgroundWidget');
    final background = Container(key: backgroundKey);
    final widget = BlankSlide(background: background);
    await WidgetsTestHelper.pumpApp(tester, widget);

    // Expect: background widget
    expect(find.byKey(backgroundKey), findsOneWidget);

    // Expect: slide to be sizedbox
    final context = WidgetsTestHelper.mockContext(tester);
    final slideResult = widget.slide(context);
    expect(slideResult, isA<SizedBox>());

    // Expect: backgrund
    final backgroundResult = widget.background();
    expect(backgroundResult, background);
  });
}
