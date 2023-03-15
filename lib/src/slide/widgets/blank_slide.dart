import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// A blank slide that contains nothing. Just shows a background.
///
/// As this has to override the [slide] method, this slide passes a [SizedBox].
class BlankSlide extends SlideWidget {
  /// Creates a blank slide with an option for background widget.
  const BlankSlide({super.key, Widget? background}) : _background = background;

  final Widget? _background;

  @override
  Widget slide(BuildContext context) => const SizedBox();

  @override
  Widget? background() => _background;
}
