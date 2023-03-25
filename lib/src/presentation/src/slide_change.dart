import 'package:meta/meta.dart';

@immutable
class SlideChangeEvent {
  const SlideChangeEvent({required this.data});

  final SlideChangeData data;
}

class SlideChangeData {
  SlideChangeData({required int slide}) : _slide = slide;
  int _slide;
  int? _previousSlide;

  @internal
  set slide(int slide) {
    _previousSlide = _slide;
    _slide = slide;
  }

  int get slide => _slide;

  int? get previousSlide => _previousSlide;
}
