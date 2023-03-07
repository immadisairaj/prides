import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import '../mock/mock_slide_widget.dart';

void main() {
  group('Assertion for slide length in presentation widget -', () {
    test('Assert when PresentationWidget has 0 slides', () {
      expect(
        () => PresentationWidget(slides: const <SlideWidget>[]),
        throwsAssertionError,
      );
    });

    test('Do not assert when PresentationWidget has more slides', () {
      expect(
        () => PresentationWidget(slides: const [MockSlideWidget()]),
        isNot(throwsAssertionError),
      );
    });
  });
}
