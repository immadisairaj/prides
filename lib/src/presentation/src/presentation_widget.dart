import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prides/prides.dart';

import 'package:prides/src/slide/widgets/end_slide.dart';

/// A widget that can present the slides.
///
/// It is as simple as just passing the list of slides to be displayed
/// to the [slides] in the required order. We can also pass (optional) a widget
/// to [background] that can be displayed when a slide doesn't have
/// a background. This enables use of a common background all over
/// the presentation.
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
/// is considered. And, when this widget doesn't have a background, it will be
/// like the background is transparent and previous slide will be displayed
/// due the the usage of stack for slides.
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
  }) : assert(slides.length > 0, 'slides cannot be empty');

  /// The list of slides made from or using [SlideWidget] to present.
  final List<SlideWidget> slides;

  /// The background widget for the presentation.
  /// It will displayed when a slide doesn't have a background.
  final Widget? background;

  @override
  State<PresentationWidget> createState() => _PresentationWidgetState();
}

class _PresentationWidgetState extends State<PresentationWidget> {
  /// This is couter variable that keeps track of the current displaying slide.
  ///
  /// it advances or reverses from the methods
  /// [_advanceSlide] and [_reverseSlide] respectively.
  late int _currentSlide;

  late FocusNode _focusNode;

  void _initialize() {
    _currentSlide = 0;
    _focusNode = FocusNode();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  /// increases the [_currentSlide] by 1
  ///
  /// When slide controller of current slide is not null:
  /// it will call the advanceSlide of the controller.
  /// - if it returns true, it will stop the slide from advancing.
  /// - if it returns false, it will advance the slide normally.
  void _advanceSlide() {
    if (_currentSlide < widget.slides.length) {
      final controller = widget.slides[_currentSlide].controller;
      if (controller != null) {
        final stopAdvance = controller.advanceSlide();
        if (stopAdvance) {
          return;
        }
      }
      setState(() {
        _currentSlide++;
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
    if (_currentSlide > 0) {
      if (_currentSlide < widget.slides.length) {
        final controller = widget.slides[_currentSlide].controller;
        if (controller != null) {
          final stopReverse = controller.reverseSlide();
          if (stopReverse) {
            return;
          }
        }
      }
      setState(() {
        _currentSlide--;
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
              widget.slides.length + 1, // +1 for end slide
              (index) {
                // if the slide position is later to the current slide,
                // we return a blank widget to display nothing.
                if (index > _currentSlide) {
                  return const SizedBox.shrink();
                }
                // show the end slide after all the slides (topmost)
                if (index == widget.slides.length) {
                  // end of the presentation
                  return const EndSlide(
                    key: ValueKey('EndSlide'),
                  );
                }
                // if slide position is before to the current slide,
                // we add the widges in stack on top of another with
                // the current slide being at the top.
                final hasBackground = widget.slides[index].hasBackground;
                return Stack(
                  children: [
                    // if slide has no background, use presentation background
                    if (!hasBackground)
                      // background widget if specified expands to the parent
                      SizedBox.expand(
                        child: widget.background,
                      ),
                    widget.slides[index],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
