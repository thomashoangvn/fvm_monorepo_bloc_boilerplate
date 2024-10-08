// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//
// https://github.com/letsar/gap

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

part 'atoms/sliver_gap_rendering.dart';

/// A widget that creates a gap inside a sliver, which can be used within
/// a [CustomScrollView] or other sliver-based scrollable widgets.
///
/// The [SliverGap] widget inserts a gap with a specific [mainAxisExtent] (height for vertical scroll,
/// width for horizontal scroll). An optional [color] can be applied to the gap.
class SliverGap extends LeafRenderObjectWidget {
  /// Creates a sliver-based gap with a given [mainAxisExtent] (size in the main axis).
  ///
  /// The [mainAxisExtent] defines the size of the gap along the main axis (e.g., height in a vertical
  /// scrolling view or width in a horizontal scrolling view). The gap can optionally have a [color].
  ///
  /// The [mainAxisExtent] must be a non-negative number and smaller than infinity.
  const SliverGap(
    this.mainAxisExtent, {
    this.color,
    super.key,
  }) : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity);

  /// The background color of the gap.
  ///
  /// If null, no background color is applied to the gap.
  final Color? color;

  /// The size of the gap in the main axis direction (e.g., height in a vertical scroll, width in a horizontal scroll).
  ///
  /// Must be a non-negative number and smaller than infinity.
  final double mainAxisExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SliverGapRendering(
      mainAxisExtent: mainAxisExtent,
      color: color,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent))
      ..add(ColorProperty('color', color));
  }

  @override
  void updateRenderObject(
      BuildContext context, SliverGapRendering renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..color = color;
  }
}
