import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// An abstract class helpful to create a Slide
/// to be use in [PresentationWidget].
///
/// A slide can be created by extending this class and by overriding the methods
/// [slide] (foreground of the slide) and [background] (background of the slide)
///
/// It uses a [Stack] to place the foreground and background widgets.
///
/// It also takes in a [controller] where we pass a [SlideController] to
/// handle custom methods of the advancement and reversal of the slide.
/// Take a look at [SlideController] for more information.
///
/// The below example shows how to create a slide using [SlideWidget]
///
/// ```dart
/// class CustomSlide extends SlideWidget {
///   const CustomSlide({super.key});
///
///   @override
///   Widget slide(BuildContext context) => ForegroundWidget();
///
///   @override
///   Widget background() => BackgroundWidget();
/// }
/// ```
///
/// See also:
/// * [SimpleSlide], a slide that takes a foreground widget and
///  a background widget to make a slide.
/// * [TitleSlide], a template slide that takes title and subtitle as input.
/// * [SectionHeader], a template slide that takes in just title as input.
/// * [BlankSlide], a template slide that is blank without any foreground.
/// * [CaptionSlide], a template slide that is used for captions.
abstract class SlideWidget extends StatelessWidget {
  /// Initializes [key] for subclasses.
  const SlideWidget({super.key});

  /// Override this method to add slide (foreground) widget.
  ///
  /// The widget returned by this method will be placed as foreground
  /// of that particular slide.
  // @mustBeOverridden
  Widget slide(BuildContext context);

  /// Override this method to add background widget.
  ///
  /// This widget returned by this method will be placed as background
  /// of that particular slide. Background is wrapped inside
  /// a [SizedBox.expand] widget so that it stretches to the whole.
  ///
  /// If this method returns null, then the background widget will be empty
  /// i.e. there will be an empty [SizedBox.expand] instead.
  // @mustBeOverridden
  Widget? background();

  /// Override this method. (optional)
  ///
  /// If there is a need for custom advancement and reversal of the slide,
  /// then override this method by passing a [SlideController].
  ///
  /// By default, the controller is null. It acts as a normal slide.
  ///
  /// Example override:
  /// ```dart
  /// // initialize the controller
  /// final SlideController _controller = SlideController();
  ///
  /// @override
  /// SlideController? get controller => _controller;
  /// ```
  SlideController? get controller => null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: background(),
        ),
        slide(context),
      ],
    );
  }
}
