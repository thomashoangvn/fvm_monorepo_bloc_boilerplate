// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A widget that provides fade-in and fade-out animations for its child widget.
///
/// The [WidgetFader] can be controlled manually using the [FadeInController].
/// You can trigger fade-in or fade-out animations, specify the animation duration,
/// and customize the curve of the animation.
class WidgetFader extends StatefulWidget {
  /// A controller to manually control the fade-in and fade-out actions.
  final FadeInController? controller;

  /// The widget to apply the fade effect to.
  final Widget? child;

  /// The duration of the fade animation. Defaults to 250 milliseconds.
  final Duration duration;

  /// The animation curve for the fade transition. Defaults to [Curves.easeIn].
  final Curve curve;

  const WidgetFader({
    super.key,
    this.controller,
    this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeIn,
  });

  @override
  State<WidgetFader> createState() => _FadeInState();
}

/// The available actions for the [FadeInController].
///
/// You can either trigger a fade-in or fade-out animation.
enum FadeInAction {
  fadeIn,
  fadeOut,
}

/// A controller to manage the fade-in and fade-out actions of the [WidgetFader].
///
/// Use the [fadeIn] and [fadeOut] methods to control the fade animations. You can
/// also set [autoStart] to `true` to trigger the fade-in automatically on initialization.
class FadeInController {
  /// Internal stream controller to handle fade-in and fade-out events.
  final StreamController<FadeInAction> _streamController =
      StreamController<FadeInAction>();

  /// If set to true, the widget will automatically start the fade-in animation upon initialization.
  final bool autoStart;

  FadeInController({this.autoStart = false});

  /// Disposes the controller and closes the internal stream.
  void dispose() => _streamController.close();

  /// Triggers the fade-in animation.
  void fadeIn() => run(FadeInAction.fadeIn);

  /// Triggers the fade-out animation.
  void fadeOut() => run(FadeInAction.fadeOut);

  /// Sends the provided action (fade-in or fade-out) to the stream.
  void run(FadeInAction action) => _streamController.add(action);

  /// Provides a stream of [FadeInAction]s to listen for fade-in and fade-out events.
  Stream<FadeInAction> get stream => _streamController.stream;
}

class _FadeInState extends State<WidgetFader> with TickerProviderStateMixin {
  late AnimationController _controller;
  StreamSubscription<FadeInAction>? _listener;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the provided duration.
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Set up the curve for the animation.
    _setupCurve();

    // Automatically start fade-in if autoStart is enabled.
    if (widget.controller?.autoStart ?? true) {
      fadeIn();
    }

    // Listen for actions from the controller.
    _listen();
  }

  /// Configures the curve for the fade animation.
  void _setupCurve() {
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: widget.curve);

    Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
  }

  /// Subscribes to the [FadeInController] to listen for fade-in and fade-out actions.
  void _listen() {
    // Cancel any previous listener.
    _listener?.cancel();
    _listener = null;

    // Listen to the stream if a controller is provided.
    if (widget.controller != null) {
      _listener = widget.controller!.stream.listen(_onAction);
    }
  }

  /// Handles the actions triggered by the [FadeInController].
  ///
  /// Depending on the action, it will either start a fade-in or a fade-out.
  void _onAction(FadeInAction action) {
    switch (action) {
      case FadeInAction.fadeIn:
        fadeIn();
      case FadeInAction.fadeOut:
        fadeOut();
    }
  }

  @override
  void didUpdateWidget(WidgetFader oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Re-subscribe to the controller if it has changed.
    if (oldWidget.controller != widget.controller) {
      _listen();
    }

    // Update the duration of the animation if it has changed.
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    // Update the curve if it has changed.
    if (oldWidget.curve != widget.curve) {
      _setupCurve();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }

  /// Starts the fade-in animation.
  void fadeIn() => _controller.forward();

  /// Starts the fade-out animation.
  void fadeOut() => _controller.reverse();
}
