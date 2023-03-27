import 'package:flutter_test/flutter_test.dart';
import 'package:prides/prides.dart';

void main() {
  group('slide change data - ', () {
    test('initialization', () {
      const initialSlide = 1;
      final slideChangeData = SlideChangeData(slide: initialSlide);
      expect(slideChangeData.slide, initialSlide);
      expect(slideChangeData.previousSlide, null);
    });

    test('set slide', () {
      const initialSlide = 1;
      final slideChangeData = SlideChangeData(slide: initialSlide);
      // ignore: cascade_invocations
      slideChangeData.slide = initialSlide + 1;
      expect(slideChangeData.slide, initialSlide + 1);
      expect(slideChangeData.previousSlide, initialSlide);
    });
  });
}
