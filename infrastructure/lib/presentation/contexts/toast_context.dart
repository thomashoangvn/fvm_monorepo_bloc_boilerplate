// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/_core/toast/toast.dart';
import 'package:infrastructure/presentation/_core/toast/toast_wrapper.dart';
import 'package:infrastructure/presentation/super_class.dart';

enum ToastAlignment { bottom, top }

enum ToastLength { ages, long, medium, never, short }

enum ToastDismissDirection { down, horizontal, up }

/// A model that holds the state and properties of a toast message.
class ToastModel {
  ToastModel({
    required this.controller,
    this.overlayEntry,
    this.isExpanded = false,
    this.position = 10,
  });

  /// The animation controller used to animate the toast appearance and dismissal.
  AnimationController controller;

  /// Whether the toast is expanded.
  bool isExpanded;

  /// The vertical position of the toast.
  double position;

  /// The [OverlayEntry] that represents the toast widget in the overlay.
  OverlayEntry? overlayEntry;

  /// Disposes of the toast and its resources, removing it from the overlay.
  void dispose() {
    overlayEntry
      ?..remove()
      ..dispose();
    controller.dispose();
  }
}

/// The [ToastContext] class manages the display and dismissal of toast messages.
/// It allows for multiple toasts to be shown in a stack, with configurable
/// properties such as alignment, duration, and dismissal direction.
final class ToastContext {
  ToastContext();

  /// List of active toast overlays.
  final List<ToastModel> _overlays = <ToastModel>[];

  /// The current overlay state.
  OverlayState? _overlayState;

  /// Maximum number of toasts that can be displayed at a time.
  final int _showMaxToastNumber = 5;

  /// Gets the default dismiss direction based on the alignment.
  ToastDismissDirection _getDefaultDismissDirection(
    ToastAlignment alignment,
    ToastDismissDirection? dismissDirection,
  ) {
    if (dismissDirection == null) {
      switch (alignment) {
        case ToastAlignment.top:
          return ToastDismissDirection.up;
        case ToastAlignment.bottom:
          return ToastDismissDirection.down;
        default:
          return ToastDismissDirection.horizontal;
      }
    } else {
      return dismissDirection;
    }
  }

  /// Displays a toast with text.
  Future<void> pushToast({
    Color? backgroundColor,
    ToastDismissDirection? dismissDirection,
    Widget? leading,
    String? message,
    TextStyle? messageStyle,
    Color? shadowColor,
    Curve? slideCurve,
    ToastAlignment alignment = ToastAlignment.top,
    double expandedHeight = 50,
    bool isClosable = false,
    ToastLength length = ToastLength.short,
    Curve positionCurve = Curves.elasticOut,
    bool shouldUseSafeArea = true,
  }) async {
    await _showToast(
      backgroundColor: backgroundColor,
      dismissDirection: dismissDirection,
      leading: leading,
      message: message,
      messageStyle: messageStyle,
      shadowColor: shadowColor,
      slideCurve: slideCurve,
      alignment: alignment,
      expandedHeight: expandedHeight,
      isClosable: isClosable,
      length: length,
      positionCurve: positionCurve,
      shouldUseSafeArea: shouldUseSafeArea,
    );
  }

  /// Displays a toast with a custom widget.
  Future<void> pushWidgetToast({
    Color? backgroundColor,
    Widget? child,
    ToastDismissDirection? dismissDirection,
    Color? shadowColor,
    Curve? slideCurve,
    ToastAlignment alignment = ToastAlignment.top,
    double expandedHeight = 50,
    bool isClosable = false,
    ToastLength length = ToastLength.short,
    Curve positionCurve = Curves.elasticOut,
    bool shouldUseSafeArea = true,
  }) async {
    await _showToast(
      backgroundColor: backgroundColor,
      child: child,
      dismissDirection: dismissDirection,
      shadowColor: shadowColor,
      slideCurve: slideCurve,
      alignment: alignment,
      expandedHeight: expandedHeight,
      isClosable: isClosable,
      length: length,
      positionCurve: positionCurve,
      shouldUseSafeArea: shouldUseSafeArea,
    );
  }

  /// Core method to show a toast with various configurable options.
  Future<void> _showToast({
    Color? backgroundColor,
    Widget? child,
    ToastDismissDirection? dismissDirection,
    Widget? leading,
    String? message,
    TextStyle? messageStyle,
    Color? shadowColor,
    Curve? slideCurve,
    ToastAlignment alignment = ToastAlignment.top,
    double expandedHeight = 50,
    bool isClosable = false,
    ToastLength length = ToastLength.medium,
    Curve positionCurve = Curves.elasticOut,
    bool shouldUseSafeArea = true,
  }) async {
    // Assertions to ensure valid configurations.
    assert(
      expandedHeight >= 0.0,
      'Expanded height should not be a negative number!',
    );
    assert(
      (alignment == ToastAlignment.top &&
              dismissDirection != ToastDismissDirection.down) ||
          (alignment == ToastAlignment.bottom &&
              dismissDirection != ToastDismissDirection.up) ||
          (dismissDirection == ToastDismissDirection.horizontal),
      'If ToastAlignment is top then ToastDismissDirection must not be down. If ToastAlignment is bottom then ToastDismissDirection must not be up.',
    );

    final BuildContext context = await $.navigator.ensuredContext;

    if (context.mounted) {
      _overlayState = Overlay.of(context);
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 1000),
        vsync: _overlayState!,
      );

      final ToastModel toast = ToastModel(controller: controller);

      final OverlayEntry overlayEntry = OverlayEntry(
        builder: (_) => AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return ToastWrapper(
              alignment: alignment,
              animatedOpacity: _calculateOpacity(toast),
              child: Toast(
                controller: controller,
                onTap: () => _handleToggleExpand(toast),
                backgroundColor: backgroundColor,
                child: child,
                curve: slideCurve,
                isClosable: isClosable,
                leading: leading,
                message: message,
                messageStyle: messageStyle,
                onClose: () {
                  _removeOverlayEntry(toast);
                  _updateOverlayPositions(true, toast);
                },
                shadowColor: shadowColor,
                isInFront: _isToastInFront(toast),
              ),
              controller: controller,
              dismissDirection: dismissDirection ??
                  _getDefaultDismissDirection(alignment, dismissDirection),
              expandedPaddingHorizontal:
                  (toast.isExpanded ? 10 : math.max(toast.position - 35, 0)),
              expandedPositionedPadding:
                  toast.position + (toast.isExpanded ? expandedHeight : 0.0),
              onDismissed: () {
                _removeOverlayEntry(toast);
                _updateOverlayPositions(true, toast);
              },
              positionCurve: positionCurve,
              shouldUseSafeArea: shouldUseSafeArea,
            );
          },
        ),
      );

      toast.overlayEntry = overlayEntry;
      _overlays.add(toast);

      _updateOverlayPositions(false, toast);
      _forwardAnimation(toast);
      await Future<dynamic>.delayed(_toastDuration(length));
      await _reverseAnimation(toast);
    }
  }

  /// Plays the reverse animation to hide the toast.
  Future<void> _reverseAnimation(ToastModel toast) async {
    if (!_overlays.contains(toast)) {
      return;
    }

    await toast.controller.reverse();
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    _removeOverlayEntry(toast);
  }

  /// Removes the overlay entry for the toast and disposes its resources.
  void _removeOverlayEntry(ToastModel toast) {
    toast.dispose();
    _overlays.remove(toast);
  }

  /// Plays the forward animation to show the toast.
  void _forwardAnimation(ToastModel toast) {
    _overlayState?.insert(toast.overlayEntry!);
    toast.controller.forward();
  }

  /// Calculates the opacity of the toast based on the number of toasts being shown.
  double _calculateOpacity(ToastModel toast) {
    final int noOfShowToast = _showMaxToastNumber;
    if (_overlays.length <= noOfShowToast) {
      return 1;
    }

    final List<ToastModel> recentOverlays =
        _overlays.sublist(_overlays.length - noOfShowToast);

    return recentOverlays.contains(toast) ? 1 : 0;
  }

  /// Determines whether the toast is in front of the other toasts.
  bool _isToastInFront(ToastModel toast) {
    final int noOfShowToast = _showMaxToastNumber;

    return _overlays.indexOf(toast) >= _overlays.length - noOfShowToast;
  }

  /// Updates the positions of all visible toasts when a new toast is added or removed.
  void _updateOverlayPositions(bool isReverse, ToastModel toast) {
    if (isReverse) {
      _reverseUpdatePositions(toast);
    } else {
      _forwardUpdatePositions();
    }
  }

  /// Forces all toast overlays to rebuild.
  void _rebuildPositions() {
    for (final ToastModel overlayInfo in _overlays) {
      overlayInfo.overlayEntry?.markNeedsBuild();
    }
  }

  /// Adjusts the positions of existing toasts when a toast is removed.
  void _reverseUpdatePositions(ToastModel toast) {
    final int currentIndex = _overlays.indexOf(toast);
    for (int i = currentIndex - 1; i >= 0; i -= 1) {
      _overlays.elementAtOrNull(i)?.position -= 10;
      _overlays.elementAtOrNull(i)?.overlayEntry?.markNeedsBuild();
    }
  }

  /// Adjusts the positions of existing toasts when a new toast is added.
  void _forwardUpdatePositions() {
    for (final ToastModel overlayInfo in _overlays) {
      overlayInfo.position += 10;
      overlayInfo.overlayEntry?.markNeedsBuild();
    }
  }

  /// Toggles the expanded state of a toast, causing it to rebuild and adjust its size.
  void _handleToggleExpand(ToastModel toast) {
    toast.isExpanded = !toast.isExpanded;
    _rebuildPositions();
  }

  /// Determines the duration for how long a toast should be shown based on the [ToastLength].
  Duration _toastDuration(ToastLength length) {
    switch (length) {
      case ToastLength.short:
        return const Duration(milliseconds: 2000);
      case ToastLength.medium:
        return const Duration(milliseconds: 3500);
      case ToastLength.long:
        return const Duration(milliseconds: 5000);
      case ToastLength.ages:
        return const Duration(minutes: 2);
      default:
        return const Duration(hours: 24);
    }
  }
}
