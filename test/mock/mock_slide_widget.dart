import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// This is a mock class that extends [SlideWidget] to be used in tests.
///
/// It implements the [slide] and [background] methods
/// to return a red color container and [SizedBox.expand].
class MockSlideWidget extends SlideWidget {
  /// creates a mock slide to test.
  const MockSlideWidget({super.key});

  @override
  Widget slide(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  Widget? background() => const SizedBox.expand();
}

/// This is a mock class that extends [SlideWidget] to be used in tests.
///
/// It implements the [slide] to return a text with 'No background'
/// and [background] to return null. (no background)
class MockSlideWidgetNoBackground extends SlideWidget {
  /// creates a mock slide with no background to test.
  const MockSlideWidgetNoBackground({super.key});

  @override
  Widget slide(BuildContext context) {
    return const Center(
      child: Text(
        'No background',
      ),
    );
  }

  @override
  Widget? background() => null;
}

// * The below 3 classes correnpond to the MockSlideWidgetWithController

/// This is a mock widget that stops once on advance
/// and once on reverse. This is to test the functionality
/// of the controller.
class MockSlideWidgetWithController extends SlideWidget {
  /// creates a mock slide that stops one time on advance or reverse.
  MockSlideWidgetWithController({super.key});

  @override
  Widget slide(BuildContext context) =>
      MockOneStopWidget(controller: _controller);

  @override
  Widget? background() => const SizedBox.expand();

  final SlideController _controller = SlideController();

  @override
  SlideController get controller => _controller;
}

class MockOneStopWidget extends StatefulWidget {
  const MockOneStopWidget({required this.controller, super.key});

  final SlideController controller;

  @override
  State<MockOneStopWidget> createState() => _MockOneStopWidgetState();
}

class _MockOneStopWidgetState extends State<MockOneStopWidget>
    implements SlideControllerListener {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = 0;
    widget.controller.addListener(this);
  }

  @override
  void dispose() {
    widget.controller.removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  bool onAdvanceSlide() {
    // when counter is 1, move to next slide
    if (counter == 1) return false;
    // when counter is 0, increment the counter and stay on the same slide
    counter++;
    return true;
  }

  @override
  bool onReverseSlide() {
    // when counter is 0, move to previous slide
    if (counter == 0) return false;
    // when counter is 1, decrement the counter and stay on the same slide
    counter--;
    return true;
  }
}
