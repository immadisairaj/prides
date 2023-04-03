import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// A caption slide is where you write a caption that is shown
/// at the left bottom corner (with some padding using the
/// [LayoutBuilder] - bottom: height\*0.12, left: width\*0.05).
class CaptionSlide extends SlideWidget {
  /// Creates a Caption slide using the [caption] widget with
  /// an optional [background] widget.
  ///
  /// There is also an option for adjusting the required padding
  /// (left and bottom preferred).
  const CaptionSlide({
    required Widget this.caption,
    EdgeInsetsGeometry? padding,
    Widget? background,
    super.key,
  })  : _background = background,
        _captionText = null,
        _padding = padding;

  /// Creates a Caption slide with just using the string for caption.
  /// It uses [Text] with the [TextTheme.headlineLarge] style.
  ///
  /// You can always use the defaut constructor of [CaptionSlide] for more
  /// customization.
  const CaptionSlide.fromText({
    required String caption,
    EdgeInsetsGeometry? padding,
    Widget? background,
    super.key,
  })  : _background = background,
        caption = null,
        _captionText = caption,
        _padding = padding;

  /// caption widget shown at the left bottom corner
  final Widget? caption;

  final String? _captionText;

  /// padding given to the [caption] widget
  final EdgeInsetsGeometry? _padding;

  final Widget? _background;

  @override
  Widget slide(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        late EdgeInsetsGeometry padding;
        // only when padding is null
        if (_padding == null) {
          // left and bottom paddings when unbounded size
          var left = 40.0;
          var bottom = 80.0;
          if (constraints.hasBoundedHeight) {
            bottom = constraints.maxHeight * 0.12;
          }
          if (constraints.hasBoundedWidth) {
            left = constraints.maxWidth * 0.05;
          }
          padding = EdgeInsets.only(left: left, bottom: bottom);
        }
        return Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: _padding ?? padding,
            child: caption ??
                Text(
                  _captionText!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget? background() => _background;
}
