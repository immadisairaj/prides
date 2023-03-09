import 'package:flutter/material.dart';
import 'package:prides/prides.dart';

/// This is a title slide that takes a title and an optional sub title
/// to make a slide from [SlideWidget].
///
/// When a sub title is null, only title is shown
///
/// The gap between the title and sub title is of height 16.
class TitleSlide extends SlideWidget {
  /// Creates a title slide using the [title] and [subtitle] widgets
  /// with an optional background widget [background].
  ///
  /// See also:
  /// - [TitleSlide.fromText] where we can pass just string.
  const TitleSlide({
    required Widget this.title,
    this.subtitle,
    Widget? background,
    super.key,
  })  : _background = background,
        _titleText = null,
        _subtitleText = null;

  /// Creates a title slide with only string of title and sub title.
  /// It uses the [TextTheme] from the context and and set the:
  /// - [title] with [TextTheme.displayMedium]
  /// - [subtitle] with [TextTheme.titleMedium]
  ///
  /// You can always use the defaut constructor of [TitleSlide] for more
  /// customization.
  const TitleSlide.fromText({
    required String title,
    String? subtitle,
    Widget? background,
    super.key,
  })  : _background = background,
        title = null,
        _titleText = title,
        subtitle = null,
        _subtitleText = subtitle;

  /// A title widget for the slide
  final Widget? title;

  /// A string to be used in place of title.
  /// This is set from the [TitleSlide.fromText] constructor.
  ///
  /// This is always null when [title] is set.
  final String? _titleText;

  /// A subtitle widget for the slide
  final Widget? subtitle;

  /// A string to be used in place of subtitle.
  /// This is set from the [TitleSlide.fromText] constructor.
  ///
  /// This is always null when [subtitle] is set.
  /// This can be null even when [subtitle] is null.
  final String? _subtitleText;

  /// Optional background widget
  final Widget? _background;

  /// A constant height to be set as a gap between title and sub title
  double get _height => 16;

  /// A sized box with constant [_height]
  Widget get _gap => SizedBox(height: _height);

  @override
  Widget slide(BuildContext context) {
    // when a sub title from all constructors are null, we show no subtitle
    final hasSubtitle = !(subtitle == null && _subtitleText == null);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title ??
              Text(
                _titleText!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
          if (hasSubtitle) _gap,
          if (hasSubtitle)
            subtitle ??
                Text(
                  _subtitleText!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
        ],
      ),
    );
  }

  @override
  Widget? background() => _background;
}
