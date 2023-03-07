import 'package:prides/prides.dart';

class MockStopSlideListener implements SlideControllerListener {
  @override
  bool onAdvanceSlide() {
    return true;
  }

  @override
  bool onReverseSlide() {
    return true;
  }
}
