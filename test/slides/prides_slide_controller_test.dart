import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

import '../mock/mock_slide_listener.dart';

void main() {
  final controller = SlideController();
  group('Slide controller -', () {
    test('without listener', () {
      // Expect: both to return false as there is no listener.
      expect(controller.advanceSlide(), false);
      expect(controller.reverseSlide(), false);
    });

    test('with listener to stop advance or reverse', () {
      // add a listener to stop advance or reverse
      // i.e. returns true on both functions.
      controller.addListener(MockStopSlideListener());

      // Expect: both to return true
      expect(controller.advanceSlide(), true);
      expect(controller.reverseSlide(), true);

      // remove the listener
      controller.removeListener();
    });
  });
}
