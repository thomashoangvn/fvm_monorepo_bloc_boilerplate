// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//
// https://github.com/letsar/gap

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

part 'atoms/gap_rendering.dart';

/// A widget that provides a customizable gap between UI elements.
/// The `Gap` widget allows you to insert space of a defined size in the main
/// axis of the layout, with an optional color and cross-axis extent.
///
/// It supports both flexible and inflexible gaps with the `Gap.expand` constructor.
class Gap extends StatelessWidget {
  /// Creates a `Gap` widget.
  ///
  /// The [mainAxisExtent] determines the size of the gap in the main axis direction
  /// (e.g., vertically in a column or horizontally in a row). The gap can optionally
  /// have a [color] and a [crossAxisExtent], which defines the extent in the
  /// cross-axis direction.
  ///
  /// The [mainAxisExtent] must be a non-negative number and smaller than infinity.
  const Gap(
    this.mainAxisExtent, {
    this.color,
    this.crossAxisExtent,
    super.key,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  /// A named constructor for creating an expandable `Gap` widget.
  ///
  /// The gap will occupy the full available space in the cross axis, as
  /// defined by [crossAxisExtent].
  const Gap.expand(double mainAxisExtent, {Color? color, Key? key})
      : this(
          mainAxisExtent,
          color: color,
          crossAxisExtent: double.infinity,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final ScrollableState? scrollableState = Scrollable.maybeOf(context);
    final AxisDirection? axisDirection = scrollableState?.axisDirection;
    final Axis? fallbackDirection =
        axisDirection == null ? null : axisDirectionToAxis(axisDirection);

    return _RawGap(
      mainAxisExtent,
      color: color,
      crossAxisExtent: crossAxisExtent,
      fallbackDirection: fallbackDirection,
    );
  }

  /// The background color of the gap.
  ///
  /// If null, no background color is applied.
  final Color? color;

  /// The extent of the gap in the cross-axis direction.
  ///
  /// This is optional and will default to the intrinsic size of the cross axis if null.
  final double? crossAxisExtent;

  /// The extent of the gap in the main-axis direction.
  ///
  /// Must be a non-negative number and smaller than infinity.
  final double mainAxisExtent;
}

/// A widget that provides a flexible gap between UI elements.
///
/// `MaxGap` works similarly to `Gap`, but it is designed to be flexible and adjust
/// its size based on the available space, while still maintaining the defined main axis
/// size. It uses `Flexible` to wrap the gap.
class MaxGap extends StatelessWidget {
  /// Creates a flexible `MaxGap` widget.
  ///
  /// The [mainAxisExtent] defines the size of the gap in the main axis direction.
  const MaxGap(
    this.mainAxisExtent, {
    this.color,
    this.crossAxisExtent,
    super.key,
  });

  /// A named constructor for creating an expandable `MaxGap` widget.
  ///
  /// The gap will occupy the full available space in the cross axis.
  const MaxGap.expand(double mainAxisExtent, {Color? color, Key? key})
      : this(
          mainAxisExtent,
          color: color,
          crossAxisExtent: double.infinity,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: _RawGap(
        mainAxisExtent,
        color: color,
        crossAxisExtent: crossAxisExtent,
      ),
    );
  }

  /// The background color of the gap.
  ///
  /// If null, no background color is applied.
  final Color? color;

  /// The extent of the gap in the cross-axis direction.
  ///
  /// This is optional and will default to the intrinsic size of the cross axis if null.
  final double? crossAxisExtent;

  /// The extent of the gap in the main-axis direction.
  ///
  /// Must be a non-negative number and smaller than infinity.
  final double mainAxisExtent;
}

/// The internal widget used by both [Gap] and [MaxGap] to render the gap.
///
/// This widget is responsible for the rendering logic and is not intended to be
/// used directly. It renders a gap of a specified size and color, along with
/// optional cross-axis extent and direction fallback.
class _RawGap extends LeafRenderObjectWidget {
  const _RawGap(
    this.mainAxisExtent, {
    this.color,
    this.crossAxisExtent,
    this.fallbackDirection,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  /// The background color of the gap.
  ///
  /// If null, no background color is applied.
  final Color? color;

  /// The extent of the gap in the cross-axis direction.
  ///
  /// This is optional and will default to the intrinsic size of the cross axis if null.
  final double? crossAxisExtent;

  /// The fallback direction to use if the context's scroll direction is not
  /// available.
  final Axis? fallbackDirection;

  /// The extent of the gap in the main-axis direction.
  ///
  /// Must be a non-negative number and smaller than infinity.
  final double mainAxisExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return GapRendering(
      mainAxisExtent: mainAxisExtent,
      color: color,
      crossAxisExtent: crossAxisExtent ?? 0,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent))
      ..add(
        DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: 0),
      )
      ..add(ColorProperty('color', color))
      ..add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }

  @override
  void updateRenderObject(BuildContext context, GapRendering renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }
}
