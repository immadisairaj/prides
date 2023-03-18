import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// A backgroundless slide that takes only slide as a parameter.
/// This slide will have a background of the [PresentationWidget].
/// DONOT prefer to use this widget when [PresentationWidget] background is not
/// set.
class BackgroundlessSlide extends SlideWidget {
  /// Creates a backgroundless slide taking only slide.
  const BackgroundlessSlide({required Widget slide, super.key})
      : _slide = slide;

  final Widget _slide;

  @override
  Widget slide(BuildContext context) => _slide;

  @override
  Widget? background() => null;
}
