import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:prides/prides.dart';

/// It is used to control the slide movement.
///
/// Initially, the controller simply acts like it never exists.
/// Once there is a [SlideControllerListener] attached to it
/// using [addListener], is when the controller is really used.
///
/// Pass the instance of [SlideController] to [SlideWidget] by overriding
/// the getter [SlideWidget.controller]. Also, pass the same instance
/// to the class where [SlideControllerListener] is implemented. such a way
/// the listener can be attached to the controller.
///
/// Use the [removeListener] when not needed anymore.
///
/// See also
/// [SlideControllerListener] for an example usage.
@sealed
class SlideController {
  /// creates an instance of [SlideController]
  SlideController();

  SlideControllerListener? _listener;

  /// Attaches [listener], an instance of [SlideControllerListener]
  /// to the controller.
  // ignore: use_setters_to_change_properties
  void addListener(SlideControllerListener? listener) {
    _listener = listener;
  }

  /// Removes the listener from the controller.
  void removeListener() {
    _listener = null;
  }

  /// DO NOT USE THIS METHOD.
  ///
  /// This method is internally used by the [PresentationWidget] to control
  /// the advancement of the slide.
  ///
  /// returns the [SlideControllerListener.onAdvanceSlide] when a listener
  /// is attached to the controller.
  /// Otherwise, returns false - advancing the slide normally.
  @internal
  bool advanceSlide() {
    if (_listener != null) {
      return _listener!.onAdvanceSlide();
    }
    return false;
  }

  /// DO NOT USE THIS METHOD.
  ///
  /// This method is internally used by the [PresentationWidget] to control
  /// the reversal of the slide.
  ///
  /// returns the [SlideControllerListener.onReverseSlide] when a listener
  /// is attached to the controller.
  /// Otherwise, returns false - reversing the slide normally.
  @internal
  bool reverseSlide() {
    if (_listener != null) {
      return _listener!.onReverseSlide();
    }
    return false;
  }
}

/// An interface for implementing a listener which can be attached to a
/// [SlideController].
///
/// Override the [onAdvanceSlide] and [onReverseSlide] methods.
///
/// The example below shows how to create a custom widget using [SlideWidget]
/// where we override the [SlideWidget.controller] to pass a [SlideController]
/// that which is passed down to a [StatefulWidget] where the
/// [SlideControllerListener] is implemented in [State] and attached to the
/// passed down controller.
///
/// ```dart
/// // initialize the controller
/// final SlideController _controller = SlideController();
///
/// class ListenerExampleSlide extends SlideWidget {
///  const ListenerExampleSlide({super.key});
///
///   @override
///   Widget? background() => const SizedBox.shrink();
///
///   @override
///   Widget slide(BuildContext context) =>
///       StateWidget(controller: _controller); // pass controller
///
///   @override
///   SlideController? get controller => _controller; // override controller
/// }
///
/// class StateWidget extends StatefulWidget {
///   const StateWidget({super.key, required this.controller});
///   final SlideController controller;
///
///   @override
///   State<StateWidget> createState() => _StateWidgetState();
/// }
///
/// class _StateWidgetState extends State<StateWidget>
///   implements SlideControllerListener {
///   @override
///   void initState() {
///     super.initState();
///     // attach the listener to the controller
///     widget.controller.addListener(this);
///   }
///
///   @override
///   void dispose() {
///     // detach the listener from the controller
///     widget.controller.removeListener();
///     super.dispose();
///   }
///
///   @override
///   bool onAdvanceSlide() {
///     // handle advance slide
///     if (handleAdvance) return true; // stops advance
///     return false;
///   }
///
///   @override
///   bool onReverseSlide() {
///     // handle reverse slide
///     if (handleReverse) return true; // stops reverse
///     return false;
///   }
///
///   ... // omitting build method
/// }
/// ```
abstract class SlideControllerListener {
  /// Override this method to handle the advance slide event.
  ///
  /// return:
  /// - true, to stop the advance slide event.
  /// - false, to continue the advance slide event.
  @mustBeOverridden
  bool onAdvanceSlide();

  /// Override this method to handle the reverse slide event.
  ///
  /// return:
  /// - true, to stop the reverse slide event.
  /// - false, to continue the reverse slide event.
  @mustBeOverridden
  bool onReverseSlide();
}
