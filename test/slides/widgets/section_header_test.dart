import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  const titleKey = Key('titleWidget');
  final title = Container(key: titleKey);
  const titleText = 'Title';
  const backgroundKey = Key('backgroundWidget');
  final background = Container(key: backgroundKey);

  group('section header slide test', () {
    testWidgets('with default constructor', (tester) async {
      await WidgetsTestHelper.pumpApp(
        tester,
        SectionHeader(title: title, background: background),
      );

      // Expect: title and background widgets
      expect(find.byKey(titleKey), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);
    });

    testWidgets('with fromText constructor', (tester) async {
      await WidgetsTestHelper.pumpApp(
        tester,
        SectionHeader.fromText(
          title: titleText,
          background: background,
        ),
      );

      // Expect: title text and background widgets
      expect(find.text(titleText), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);
    });
  });
}
