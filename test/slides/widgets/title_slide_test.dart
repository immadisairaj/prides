import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  const titleKey = Key('titleWidget');
  final title = Container(key: titleKey);
  const titleText = 'Title';
  const subtitleKey = Key('subtitleWidget');
  final subtitle = Container(key: subtitleKey);
  const subtitleText = 'Subtitle';
  const backgroundKey = Key('backgroundWidget');
  final background = Container(key: backgroundKey);

  group('title slide test', () {
    testWidgets('with default constructor', (tester) async {
      await WidgetsTestHelper.pumpApp(
        tester,
        TitleSlide(title: title, subtitle: subtitle, background: background),
      );

      // Expect: title, subtitle and background widgets
      expect(find.byKey(titleKey), findsOneWidget);
      expect(find.byKey(subtitleKey), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);
    });

    testWidgets('with fromText constructor', (tester) async {
      await WidgetsTestHelper.pumpApp(
        tester,
        TitleSlide.fromText(
          title: titleText,
          subtitle: subtitleText,
          background: background,
        ),
      );

      // Expect: title text, subtitle text and background widgets
      expect(find.text(titleText), findsOneWidget);
      expect(find.text(subtitleText), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);
    });
  });
}
