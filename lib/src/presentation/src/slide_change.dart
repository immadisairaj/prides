import 'package:meta/meta.dart';
import 'package:prides/prides.dart';

/// Data that is used for event callback from the [PresentationWidget] when
/// a slide is changed. It gives the current slide ([slide]) and
/// previous slide ([previousSlide]).
class SlideChangeData {
  /// creates a slide change data. This is mostly used by [PresentationWidget]
  /// internally and is created only once per the widget.
  @internal
  SlideChangeData({required int slide}) : _slide = slide;

  /// keeps track of the current slide the user is in.
  int _slide;

  /// keeps track of the previous slide the user was in.
  int? _previousSlide;

  /// sets the current slide to the given value, while setting the
  /// previous slide value to the already existing slide value.
  @internal
  set slide(int slide) {
    _previousSlide = _slide;
    _slide = slide;
  }

  /// get the current slide index
  int get slide => _slide;

  /// get the previous slide index
  int? get previousSlide => _previousSlide;
}
