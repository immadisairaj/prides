import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

void main() {
  Future<void> pumpApp(
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

  testWidgets('simple slide test', (tester) async {
    const slideKey = Key('slideWidget');
    final slide = Container(key: slideKey);
    const backgroundKey = Key('backgroundWidget');
    final background = Container(key: backgroundKey);
    await pumpApp(tester, SimpleSlide(slide: slide, background: background));

    // Expect: slide and background widgets
    expect(find.byKey(slideKey), findsOneWidget);
    expect(find.byKey(backgroundKey), findsOneWidget);
  });
}
