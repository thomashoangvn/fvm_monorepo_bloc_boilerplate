import 'package:flutter/material.dart';

/// Configuration class that holds settings for how the dialog should be displayed.
/// This class is used by the `DialogBuilder` to apply specific configurations
/// when building a dialog route.
class DialogConfig {
  const DialogConfig({
    this.anchorPoint,
    this.barrierLabel,
    this.settings,
    this.themes,
    this.traversalEdgeBehavior,
    this.barrierColor = Colors.black54,
    this.isBarrierDismissible = true,
    this.shouldUseSafeArea = true,
  });

  /// Optional anchor point for the dialog (top-left corner).
  final Offset? anchorPoint;

  /// Color of the dialog's barrier.
  final Color? barrierColor;

  /// Determines if the dialog can be dismissed by tapping outside the dialog.
  final bool isBarrierDismissible;

  /// Optional label for the barrier, used for accessibility.
  final String? barrierLabel;

  /// Additional route settings.
  final RouteSettings? settings;

  /// Captured themes to apply to the dialog.
  final CapturedThemes? themes;

  /// Determines how the dialog behaves when traversing edges.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// Indicates whether to apply safe area insets.
  final bool shouldUseSafeArea;
}
