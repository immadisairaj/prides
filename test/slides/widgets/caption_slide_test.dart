import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import 'widgets_test_helper.dart';

void main() {
  group('caption slide test', () {
    const captionKey = Key('captionWidget');
    final caption = Container(key: captionKey);
    const captionText = 'Caption Text';
    const backgroundKey = Key('backgroundWidget');
    final background = Container(key: backgroundKey);

    testWidgets('with default constructor', (tester) async {
      final widget = CaptionSlide(caption: caption, background: background);
      await WidgetsTestHelper.pumpApp(tester, widget);

      // Expect: caption and background widget
      expect(find.byKey(captionKey), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);

      // Expect: backgrund
      final backgroundResult = widget.background();
      expect(backgroundResult, background);
    });

    testWidgets('with fromText constructor', (tester) async {
      final widget =
          CaptionSlide.fromText(caption: captionText, background: background);
      await WidgetsTestHelper.pumpApp(tester, widget);

      // Expect: caption and background widget
      expect(find.text(captionText), findsOneWidget);
      expect(find.byKey(backgroundKey), findsOneWidget);
    });

    testWidgets('with default bounded size padding', (tester) async {
      final widget = Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CaptionSlide(caption: caption, background: background),
        ),
      );
      await WidgetsTestHelper.pumpApp(tester, widget);

      // Expect: proper padding
      final parentPadding = find.ancestor(
        of: find.byWidget(caption),
        matching: find.byType(Padding),
      );
      const expectPadding =
          EdgeInsets.only(left: 100 * 0.05, bottom: 100 * 0.12);
      expect(tester.widget<Padding>(parentPadding).padding, expectPadding);
    });

    testWidgets('when passing padding', (tester) async {
      const padding = EdgeInsets.only(left: 10, bottom: 10);
      final widget = CaptionSlide(
        caption: caption,
        background: background,
        padding: padding,
      );
      await WidgetsTestHelper.pumpApp(tester, widget);

      // Expect: proper padding
      final parentPadding = find.ancestor(
        of: find.byWidget(caption),
        matching: find.byType(Padding),
      );
      expect(tester.widget<Padding>(parentPadding).padding, padding);
    });
  });
}
