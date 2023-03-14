import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// A section header slide that takes in a title widget and wraps
/// a center around the widget to make a slide from [SlideWidget].
class SectionHeader extends SlideWidget {
  /// Creates a Section Header slide using the [title] widget with
  /// an optional [background] widget.
  const SectionHeader({
    required Widget this.title,
    Widget? background,
    super.key,
  })  : _background = background,
        _titleText = null;

  /// Creates a Section Header slide with just using the string for title.
  /// It uses [Text] with the [TextTheme.displayMedium] style.
  ///
  /// You can always use the defaut constructor of [SectionHeader] for more
  /// customization.
  const SectionHeader.fromText({
    required String title,
    Widget? background,
    super.key,
  })  : _background = background,
        title = null,
        _titleText = title;

  /// A title widget shown at the center of the slide
  final Widget? title;

  /// A text shown in the place of title.
  /// This is set from the [SectionHeader.fromText] constructor.
  ///
  /// This is always be null when [title] is set.
  final String? _titleText;

  /// Optional background widget
  final Widget? _background;

  @override
  Widget slide(BuildContext context) {
    return Center(
      child: title ??
          Text(
            _titleText!,
            style: Theme.of(context).textTheme.displayMedium,
          ),
    );
  }

  @override
  Widget? background() => _background;
}
