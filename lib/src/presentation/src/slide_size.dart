import 'package:prides/prides.dart';

/// Provides an option to set the slide resolution in the [PresentationWidget].
///
/// This class provides a few constant sizes used widely:
/// [standardSmall], [standardBig], [widescreenSmall], [widescreenBig],
/// [widescreenOldSmall] and [widescreenOldBig].
///
/// Also set a custom size using the [SlideSize] constructor
class SlideSize {
  /// creates an object which is utilized by [PresentationWidget] to
  /// determine the size of a [SlideWidget] while presenting.
  const SlideSize({required int width, required int height})
      : _width = width,
        _height = height;

  /// 4:3 aspect ratio; 960 x 720 pixels
  static const SlideSize standardSmall = SlideSize(width: 960, height: 720);

  /// 4:3 aspect ratio; 1024 x 768 pixels
  static const SlideSize standardBig = SlideSize(width: 1024, height: 768);

  /// 16:9 aspect ratio; 960 x 540 pixels
  static const SlideSize widescreenSmall = SlideSize(width: 960, height: 540);

  /// 16:9 aspect ratio; 1920 x 1080 pixels (default)
  static const SlideSize widescreenBig = SlideSize(width: 1920, height: 1080);

  /// 16:10 aspect ratio; 960 x 600 pixels
  static const SlideSize widescreenOldSmall =
      SlideSize(width: 960, height: 600);

  /// 16:10 aspect ratio; 1920 x 1200 pixels
  static const SlideSize widescreenOldBig =
      SlideSize(width: 1920, height: 1200);

  final int _width;
  final int _height;

  /// get the width of the preferred slide size
  int get width => _width;

  /// get the height of the preferred slide size
  int get height => _height;
}
