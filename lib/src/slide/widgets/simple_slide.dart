import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// This is a simple slide that takes a foreground widget and
/// a background widget to make a slide from [SlideWidget].
class SimpleSlide extends SlideWidget {
  /// Creates a simple slide with a foreground widget [slide] and
  /// an optional background widget [background].
  const SimpleSlide({
    required Widget slide,
    Widget? background,
    super.key,
  })  : _slide = slide,
        _background = background;

  final Widget _slide;

  final Widget? _background;

  @override
  Widget slide(BuildContext context) => _slide;

  @override
  Widget? background() => _background;
}
