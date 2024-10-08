// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/contexts/toast_context.dart';

/// A [ToastWrapper] is a stateful widget responsible for managing the animation,
/// position, and dismiss behavior of a toast notification in the app. It wraps
/// the toast content and applies necessary transitions and dismiss logic.
class ToastWrapper extends StatefulWidget {
  const ToastWrapper({
    required this.alignment,
    required this.animatedOpacity,
    required this.child,
    required this.controller,
    required this.dismissDirection,
    required this.expandedPaddingHorizontal,
    required this.expandedPositionedPadding,
    required this.onDismissed,
    required this.positionCurve,
    required this.shouldUseSafeArea,
    super.key,
  });

  /// Defines the alignment of the toast, either top or bottom.
  final ToastAlignment alignment;

  /// Controls the opacity animation for the toast.
  final double animatedOpacity;

  /// The actual widget content of the toast.
  final Widget child;

  /// Animation controller for controlling slide transitions.
  final AnimationController controller;

  /// Defines the direction in which the toast can be dismissed.
  final ToastDismissDirection dismissDirection;

  /// Padding applied horizontally for the toast content.
  final double expandedPaddingHorizontal;

  /// Padding applied to the position of the toast.
  final double expandedPositionedPadding;

  /// Callback triggered when the toast is dismissed.
  final VoidCallback onDismissed;

  /// Curve used for controlling the position animation.
  final Curve positionCurve;

  /// Whether the toast should respect the device's safe area (like status bar, notch).
  final bool shouldUseSafeArea;

  @override
  State<ToastWrapper> createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper> {
  final GlobalKey<State<StatefulWidget>> _childKey = GlobalKey();
  bool _isHeightCalculated = false;
  double _widgetHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _calculateChildHeight());
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !_isHeightCalculated,
      child: SlideTransition(
        position: _position.animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: widget.positionCurve,
            reverseCurve: widget.positionCurve,
          ),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              child: _buildDismissibleContent,
              left: 10,
              top: _isTopAligned
                  ? widget.expandedPositionedPadding + _safeAreaPadding
                  : null,
              right: 10,
              bottom: _isTopAligned
                  ? null
                  : widget.expandedPositionedPadding + _safeAreaPadding,
              curve: widget.positionCurve,
              duration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildDismissibleContent {
    return Dismissible(
      key: UniqueKey(),
      child: AnimatedPadding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.expandedPaddingHorizontal),
        child: AnimatedOpacity(
          child: SizedBox(key: _childKey, child: widget.child),
          opacity: widget.animatedOpacity,
          duration: const Duration(milliseconds: 500),
        ),
        curve: widget.positionCurve,
        duration: const Duration(milliseconds: 500),
      ),
      onDismissed: (_) => widget.onDismissed(),
      direction: _mapToastDismissToDismissDirection,
    );
  }

  bool get _isTopAligned => widget.alignment == ToastAlignment.top;

  DismissDirection get _mapToastDismissToDismissDirection {
    switch (widget.dismissDirection) {
      case ToastDismissDirection.up:
        return DismissDirection.up;
      case ToastDismissDirection.down:
        return DismissDirection.down;
      case ToastDismissDirection.horizontal:
        return DismissDirection.horizontal;
    }
  }

  double get _mediaQueryHeight => MediaQuery.sizeOf(context).height;

  Offset get _offset => Offset(
        0,
        (_widgetHeight + widget.expandedPositionedPadding + _safeAreaPadding) /
            _mediaQueryHeight *
            (_isTopAligned ? -1 : 1),
      );

  Tween<Offset> get _position =>
      Tween<Offset>(begin: _offset, end: Offset.zero);

  double get _safeAreaPadding {
    return widget.shouldUseSafeArea
        ? _isTopAligned
            ? MediaQuery.paddingOf(context).top
            : MediaQuery.paddingOf(context).bottom
        : 0;
  }

  void _calculateChildHeight() {
    final RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _widgetHeight = renderBox.size.height;
        _isHeightCalculated = true;
      });
    }
  }
}
