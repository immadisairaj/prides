import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:prides/prides.dart';

/// This is a slide that is shown at the end of the presentation.
///
/// This class extends the [SlideWidget] class to create the slide.
@internal
class EndSlide extends SlideWidget {
  /// Use this slide to show at the end of the presentation.
  const EndSlide({super.key});

  // adds an additional material widget as a fail safe.
  @override
  Widget slide(BuildContext context) => const Material(
        color: Colors.transparent,
        child: Center(
          child: Text(
            'End of the presentation',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget? background() => Container(color: Colors.black);
}
