import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';
import 'package:prides/src/slide/widgets/end_slide.dart';

import 'mock/mock_slide_widget.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester,
    PresentationWidget presentationWidget,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: presentationWidget,
        ),
      ),
    );
  }

  group('Navigate the default PresentationWidget with one slide -', () {
    final presentationWidget = PresentationWidget(
      slides: const [MockSlideWidget()],
    );
    testWidgets('with tap events', (tester) async {
      await pumpApp(tester, presentationWidget);

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);

      // find the size of the widget needed to do the taps
      final size = tester.getSize(find.byType(PresentationWidget));
      final leftOffset = Offset(size.width / 4, size.height / 2);
      final rightOffset = Offset(size.width * 3 / 4, size.height / 2);

      // tap on the left side of the screen
      await tester.tapAt(leftOffset);
      await tester.pumpAndSettle();

      // The state should remain same when tapping left side

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);

      // tap on the right side of the screen
      await tester.tapAt(rightOffset);
      await tester.pumpAndSettle();

      // The state should change to end slide when tapping right side

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget behind the end slide (on a stack)
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: an end of the presentation slide
      expect(find.byType(EndSlide), findsOneWidget);

      // tap on the right side of the screen
      await tester.tapAt(rightOffset);
      await tester.pumpAndSettle();

      // The state should not change when tapping right side

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget behind the end slide (on a stack)
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: an end of the presentation slide
      expect(find.byType(EndSlide), findsOneWidget);

      // tap on the left side of the screen
      await tester.tapAt(leftOffset);
      await tester.pumpAndSettle();

      // The state should change to initial when tapping right side

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);
    });

    testWidgets('with arrow key events', (tester) async {
      await pumpApp(tester, presentationWidget);

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);

      // key down left arrow
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();

      // The state should remain same on key down left arrow

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);

      // key down right arrow
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // The state should change to end slide on key down right arrow

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget behind the end slide (on a stack)
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: an end of the presentation slide
      expect(find.byType(EndSlide), findsOneWidget);

      // key down right arrow
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // The state should not change on key down right arrow

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget behind the end slide (on a stack)
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: an end of the presentation slide
      expect(find.byType(EndSlide), findsOneWidget);

      // key down left arrow
      await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();

      // The state should change to initial on key down left arrow

      // Expect: a presentation widget
      expect(find.byType(PresentationWidget), findsOneWidget);

      // Expect: a slide widget
      expect(find.byType(MockSlideWidget), findsOneWidget);

      // Expect: no end of the presentation slide
      expect(find.byType(EndSlide), findsNothing);
    });
  });

  testWidgets(
      'Display the presentation background when slide has no background',
      (tester) async {
    const backgroundKey = Key('backgroundWidget');
    final presentationWidget = PresentationWidget(
      slides: const [MockSlideWidgetNoBackground()],
      background: Container(
        key: backgroundKey,
        color: Colors.blue,
      ),
    );
    await pumpApp(tester, presentationWidget);

    // Expect: a background widget passed to presentation widget when
    // the slide has no background
    expect(find.byKey(backgroundKey), findsOneWidget);
  });

  testWidgets('Display the slide number when set to true', (tester) async {
    final presentationWidget = PresentationWidget(
      slides: const [MockSlideWidgetNoBackground()],
      showSlideNumber: true,
    );
    await pumpApp(tester, presentationWidget);

    // Expect: a slide number widget
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets(
    'Navigate the PresentationWidget when a slide is having controller',
    (tester) async {
      final presentationWidget = PresentationWidget(
        slides: [const MockSlideWidget(), MockSlideWidgetWithController()],
      );
      await pumpApp(tester, presentationWidget);

      // Expect: no controller slide as we are on the first slide
      expect(find.byType(MockSlideWidgetWithController), findsNothing);

      // advance - go to the second slide
      await tester.tap(find.byType(PresentationWidget));
      await tester.pumpAndSettle();

      // Expect: controller slide
      expect(find.byType(MockSlideWidgetWithController), findsOneWidget);
      // Expect: not an end slide as it is not on the last slide
      expect(find.byType(EndSlide), findsNothing);

      // advance
      await tester.tap(find.byType(PresentationWidget));
      await tester.pumpAndSettle();

      // Expect: not an end slide as it holds the slide for one time
      expect(find.byType(EndSlide), findsNothing);

      // advance
      await tester.tap(find.byType(PresentationWidget));
      await tester.pumpAndSettle();

      // Expect: and end slide as now it will move to the next
      expect(find.byType(EndSlide), findsOneWidget);

      // reverse
      await tester.tapAt(
        tester.getTopLeft(find.byType(PresentationWidget)) +
            const Offset(10, 10),
      );
      await tester.pumpAndSettle();

      // Expect: controller slide
      expect(find.byType(MockSlideWidgetWithController), findsOneWidget);
      // Expect: not an end slide as it is not on the last slide
      expect(find.byType(EndSlide), findsNothing);

      // reverse
      await tester.tapAt(
        tester.getTopLeft(find.byType(PresentationWidget)) +
            const Offset(10, 10),
      );
      await tester.pumpAndSettle();

      // Expect: controller slide as it holds the slide for one time
      expect(find.byType(MockSlideWidgetWithController), findsOneWidget);

      // reverse
      await tester.tapAt(
        tester.getTopLeft(find.byType(PresentationWidget)) +
            const Offset(10, 10),
      );
      await tester.pumpAndSettle();

      // Expect: no controller slide as we are on first slide
      expect(find.byType(MockSlideWidgetWithController), findsNothing);
    },
  );

  testWidgets(
    'Previous slide is transparent',
    (tester) async {
      const slideOneKey = Key('slideOne');
      const slideTwoKey = Key('slideTwo');
      const slideOne = MockSlideWidget(key: slideOneKey);
      const slideTwo = MockSlideWidget(key: slideTwoKey);
      final presentationWidget = PresentationWidget(
        slides: const [slideOne, slideTwo],
      );
      await pumpApp(tester, presentationWidget);

      // advance - go to the second slide
      await tester.tap(find.byType(PresentationWidget));
      await tester.pumpAndSettle();

      // Expect: opacity of previous slide is 0 and current slide is 1
      final parentOpacityOne = find.ancestor(
        of: find.byWidget(slideOne),
        matching: find.byType(Opacity),
      );
      final parentOpacityTwo = find.ancestor(
        of: find.byWidget(slideTwo),
        matching: find.byType(Opacity),
      );
      expect(tester.widget<Opacity>(parentOpacityOne).opacity, 0);
      expect(tester.widget<Opacity>(parentOpacityTwo).opacity, 1);
    },
  );

  testWidgets(
    'slide change callback',
    (tester) async {
      late int currentSlide;
      late int previousSlide;
      final presentationWidget = PresentationWidget(
        slides: const [MockSlideWidget(), MockSlideWidget()],
        onSlideChange: (value) {
          currentSlide = value.slide;
          previousSlide = value.previousSlide!;
        },
      );
      await pumpApp(tester, presentationWidget);

      // advance - go to the second slide
      await tester.tap(find.byType(PresentationWidget));
      await tester.pumpAndSettle();

      // Expect the current slide and previous slide
      expect(currentSlide, 2);
      expect(previousSlide, 1);
    },
  );

  testWidgets('slide size in presentation widget', (tester) async {
    const slideKey = Key('slideOne');
    const slide = MockSlideWidget(key: slideKey);
    final presentationWidget = PresentationWidget(
      slides: const [slide],
    );
    await pumpApp(tester, presentationWidget);

    // Expect the slide having defualt size resolution of 1080p
    final parentSizedBox = find.ancestor(
      of: find.byWidget(slide),
      matching: find.byType(SizedBox),
    );
    expect(
      tester.widget<SizedBox>(parentSizedBox).width,
      SlideSize.widescreenBig.width,
    );
    expect(
      tester.widget<SizedBox>(parentSizedBox).height,
      SlideSize.widescreenBig.height,
    );
  });

  testWidgets('custom slide size in presentation widget', (tester) async {
    const slideKey = Key('slideOne');
    const slide = MockSlideWidget(key: slideKey);
    const slideSize = SlideSize(width: 900, height: 900);
    final presentationWidget = PresentationWidget(
      slides: const [slide],
      slideSize: slideSize,
    );
    await pumpApp(tester, presentationWidget);

    // Expect the slide having defualt size resolution of 1080p
    final parentSizedBox = find.ancestor(
      of: find.byWidget(slide),
      matching: find.byType(SizedBox),
    );
    expect(tester.widget<SizedBox>(parentSizedBox).width, slideSize.width);
    expect(tester.widget<SizedBox>(parentSizedBox).height, slideSize.height);
  });

  testWidgets('slide fit in presentation widget', (tester) async {
    const slideKey = Key('slideOne');
    const slide = MockSlideWidget(key: slideKey);
    final presentationWidget = PresentationWidget(
      slides: const [slide],
    );
    await pumpApp(tester, presentationWidget);

    // Expect the slide having defualt fit of BoxFit.contain
    final parentFittedBox = find.ancestor(
      of: find.byWidget(slide),
      matching: find.byType(FittedBox),
    );
    expect(tester.widget<FittedBox>(parentFittedBox).fit, BoxFit.contain);
  });

  testWidgets('custom slide fit in presentation widget', (tester) async {
    const slideKey = Key('slideOne');
    const slide = MockSlideWidget(key: slideKey);
    final presentationWidget = PresentationWidget(
      slides: const [slide],
      slideFit: BoxFit.fill,
    );
    await pumpApp(tester, presentationWidget);

    // Expect the slide having defualt fit of BoxFit.contain
    final parentFittedBox = find.ancestor(
      of: find.byWidget(slide),
      matching: find.byType(FittedBox),
    );
    expect(tester.widget<FittedBox>(parentFittedBox).fit, BoxFit.fill);
  });
}
