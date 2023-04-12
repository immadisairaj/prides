import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prides/prides.dart';
import 'package:prides/src/slide/widgets/end_slide.dart';

/// A widget that can present the slides.
///
/// It is as simple as just passing the list of slides to be displayed
/// to the [slides] in the required order. We can also pass (optional) a widget
/// to [background] that is displayed when a slide doesn't have
/// a background. This enables use of a common background all over
/// the presentation.
/// to [showSlideNumber] to show the current slide number.
///
/// It is best to use a [Material] widget as a parent of this widget.
/// And always use this widget inside a [MaterialApp].
///
/// This widget will add an "End of the presentation" slide at the end.
///
/// This widget automatically handles all the key events and tap events
/// to advance or reverse the slides (as below).
///
/// Key Events:
/// - Arrow Right key to advance the slide
/// - Arrow Left key to reverse the slide
///
/// Tap Events:
/// - Tap on the 2/3rd right part of the screen* to advance the slide
/// - Tap on the 1/3rd left part of the screen* to reverse the slide
///
/// *screen here is the area where this widget is displayed.
///
/// Note1: It is recomended to use this widget as a complete page
/// as the presentations are usually full screen.
///
/// Note2: When a slide doesn't have a background, this widget's background
/// is considered. And, when this widget doesn't have a background, the
/// default flutter app background is displayed (white or black based on theme).
///
/// Note3: Currently using textTheme.labelLarge in the slide number
/// 
/// See also:
/// * [SlideWidget], a widget that can be used to create a slide.
/// The list of this widget is passed to [slides] in [PresentationWidget].
/// * [SlideController], a controller that can be used to handle custom
/// methods of the advancement and reversal of the slide.
class PresentationWidget extends StatefulWidget {
  /// creates a [PresentationWidget] to present the [slides].
  const PresentationWidget({
    required this.slides,
    super.key,
    this.background,
    this.showSlideNumber = false,
    this.onSlideChange,
  }) : assert(slides.length > 0, 'slides cannot be empty');

  /// The list of slides made from or using [SlideWidget] to present.
  final List<SlideWidget> slides;

  /// Show the current slide number when is to true
  final bool showSlideNumber;

  /// The background widget for the presentation.
  /// It will displayed when a slide doesn't have a background.
  final Widget? background;

  /// An event callback when a slide is changed. The data passed in this
  /// callback is [SlideChangeData]. The callback happens only when
  /// a slide is changed. The index of slides start from 1.
  /// current slide value is (slidesLength + 1) when reaching the
  /// end of the presentation slide.
  ///
  /// Usage:
  /// ```dart
  /// PresentationWidget(
  ///   onSlideChange: (data) => doSomething,
  ///   slides: [...],
  /// ),
  /// ```
  final ValueChanged<SlideChangeData>? onSlideChange;
  @override
  State<PresentationWidget> createState() => _PresentationWidgetState();
}

class _PresentationWidgetState extends State<PresentationWidget> {
  /// This is couter variable that keeps track of the current displaying slide.
  ///
  /// it advances or reverses from the methods
  /// [_advanceSlide] and [_reverseSlide] respectively.
  late ValueNotifier<int> _currentSlide;
  late FocusNode _focusNode;
  late SlideChangeData slideChangeData;
  void _initialize() {
    _currentSlide = ValueNotifier(0);
    _focusNode = FocusNode();
    // + 1 is for the index to start from 1
    slideChangeData = SlideChangeData(slide: _currentSlide.value + 1);
    _currentSlide.addListener(_slideChangeListener);
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _currentSlide
      ..removeListener(_slideChangeListener)
      ..dispose();
    super.dispose();
  }

  void _slideChangeListener() {
    // + 1 is for the index to start from 1
    slideChangeData.slide = _currentSlide.value + 1;
    if (widget.onSlideChange != null) {
      widget.onSlideChange!.call(slideChangeData);
    }
  }

  /// increases the [_currentSlide] by 1
  ///
  /// When slide controller of current slide is not null:
  /// it will call the advanceSlide of the controller.
  /// - if it returns true, it will stop the slide from advancing.
  /// - if it returns false, it will advance the slide normally.
  void _advanceSlide() {
    if (_currentSlide.value < widget.slides.length) {
      final controller = widget.slides[_currentSlide.value].controller;
      if (controller != null) {
        final stopAdvance = controller.advanceSlide();
        if (stopAdvance) {
          return;
        }
      }
      setState(() {
        _currentSlide.value++;
      });
    }
  }

  /// reduces the [_currentSlide] by 1
  ///
  /// When slide controller of current slide is not null:
  /// it will call the reverseSlide of the controller.
  /// - if it returns true, it will stop the slide from reversing.
  /// - if it returns false, it will reverse the slide normally.
  void _reverseSlide() {
    if (_currentSlide.value > 0) {
      if (_currentSlide.value < widget.slides.length) {
        final controller = widget.slides[_currentSlide.value].controller;
        if (controller != null) {
          final stopReverse = controller.reverseSlide();
          if (stopReverse) {
            return;
          }
        }
      }
      setState(() {
        _currentSlide.value--;
      });
    }
  }

  /// This is a handler method for on key events
  ///
  /// It calls [_advanceSlide] when the right arrow key is pressed
  /// and [_reverseSlide] when the left arrow key is pressed.
  void _onKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final keyPressed = event.logicalKey;
      if (keyPressed == LogicalKeyboardKey.arrowRight) {
        _advanceSlide();
      } else if (keyPressed == LogicalKeyboardKey.arrowLeft) {
        _reverseSlide();
      }
    }
  }

  /// This is a handler method for on tap down event
  ///
  /// It calls [_advanceSlide] when the tap is on the right 2/3 of the screen
  /// and [_reverseSlide] when the tap is on the left 1/3 of the screen.
  void _onTapDownEvent(TapDownDetails details) {
    // 1/3 for previous, 2/3 for next
    if (details.globalPosition.dx > 1 * MediaQuery.of(context).size.width / 3) {
      _advanceSlide();
    } else {
      _reverseSlide();
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Container(
      key: widget.key,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _onKeyEvent,
        child: GestureDetector(
          onTapDown: _onTapDownEvent,
          child: Stack(
            children: List<Widget>.generate(
                  widget.slides.length + 2, // +2 for background and end slide
                  (index) {
                    // if the slide position is later to the current slide,
                    // we return a blank widget to display nothing.
                    if (index - 1 > _currentSlide.value) {
                      return const SizedBox.shrink();
                    }
                    // show the end slide after all the slides (topmost)
                    if (index - 1 == widget.slides.length) {
                      // end of the presentation
                      return const EndSlide(
                        key: ValueKey('EndSlide'),
                      );
                    }
                    // show the presentation background at
                    // the bottom most in the stack
                    if (index == 0) {
                      return SizedBox.expand(child: widget.background);
                    }
                    // if slide position is before to the current slide,
                    // we add the widges in stack on top of another with
                    // the current slide being at the top, them being transparent.
                    return Stack(
                      children: [
                        Opacity(
                          opacity: _currentSlide.value == index - 1 ? 1 : 0,
                          child: widget.slides[index - 1],
                        ),
                      ],
                    );
                  },
                ) +
                // show the current slide number when is to true
                // and the current slide is not the end slide
                // Adding it to the stack so that it is always on top
                [
                  if (widget.showSlideNumber == true &&
                      _currentSlide.value < widget.slides.length)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '${_currentSlide.value + 1}',
                          //
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                ],
          ),
        ),
      ),
    );
  }
}
