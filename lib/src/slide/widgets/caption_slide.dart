import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// A caption slide is where you write a caption that is shown
/// at the left bottom corner (with some padding).
class CaptionSlide extends SlideWidget {
  /// Creates a Caption slide using the [caption] widget with
  /// an optional [background] widget.
  ///
  /// There is also an option for adjusting the required padding.
  const CaptionSlide({
    required Widget this.caption,
    this.padding = const EdgeInsets.only(left: 40, bottom: 80),
    Widget? background,
    super.key,
  })  : _background = background,
        _captionText = null;

  /// Creates a Caption slide with just using the string for caption.
  /// It uses [Text] with the [TextTheme.displaySmall] style.
  ///
  /// You can always use the defaut constructor of [CaptionSlide] for more
  /// customization.
  const CaptionSlide.fromText({
    required String caption,
    this.padding = const EdgeInsets.only(left: 40, bottom: 80),
    Widget? background,
    super.key,
  })  : _background = background,
        caption = null,
        _captionText = caption;

  /// caption widget shown at the left bottom corner
  final Widget? caption;

  final String? _captionText;

  /// padding given to the [caption] widget
  final EdgeInsetsGeometry padding;

  final Widget? _background;

  @override
  Widget slide(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: padding,
        child: caption ??
            Text(
              _captionText!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
      ),
    );
  }

  @override
  Widget? background() => _background;
}
