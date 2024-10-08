// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//
// https://github.com/letsar/gap

part of '../sliver_gap.dart';

/// [SliverGapRendering] is a custom render object that renders a gap in a [CustomScrollView] or other
/// sliver-based widgets. It provides space in the scrollable area without displaying any content,
/// except when an optional color is provided to paint the gap.
///
/// This class handles the layout and painting of the gap in the scrollable area and calculates
/// geometry such as paint extent and cache extent.
class SliverGapRendering extends RenderSliver {
  /// Creates a [SliverGapRendering] instance with the required [mainAxisExtent], which determines the size
  /// of the gap along the main axis (e.g., height in a vertical scroll or width in a horizontal scroll).
  /// Optionally, a [color] can be provided to visually fill the gap with a color.
  SliverGapRendering({required double mainAxisExtent, Color? color})
      : _mainAxisExtent = mainAxisExtent,
        _color = color;

  /// The extent of the gap along the main axis (height for vertical scroll, width for horizontal scroll).
  double _mainAxisExtent;

  /// Optional color to paint the gap.
  Color? _color;

  /// Adds properties such as [mainAxisExtent] and [color] to the diagnostic tree for debugging purposes.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent))
      ..add(ColorProperty('color', color));
  }

  /// Paints the gap with the specified [color], if any. If no color is provided, the gap remains empty
  /// (transparent).
  @override
  void paint(PaintingContext context, Offset offset) {
    if (color == null) {
      return;
    }

    final Paint paint = Paint()..color = color!;
    final Size size = constraints
        .asBoxConstraints(
          minExtent: geometry!.paintExtent,
          maxExtent: geometry!.paintExtent,
        )
        .constrain(Size.zero);
    context.canvas.drawRect(offset & size, paint);
  }

  /// Performs layout calculations for the sliver gap. It determines the scrollable extent and how much
  /// space the gap takes in the sliver layout.
  ///
  /// It calculates [paintExtent] and [cacheExtent] based on the provided constraints, and sets the
  /// sliver geometry accordingly.
  @override
  void performLayout() {
    final double paintExtent = calculatePaintOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );
    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: 0,
      to: mainAxisExtent,
    );

    assert(paintExtent.isFinite);
    assert(paintExtent >= 0.0);

    geometry = SliverGeometry(
      scrollExtent: mainAxisExtent,
      paintExtent: paintExtent,
      maxPaintExtent: mainAxisExtent,
      hitTestExtent: paintExtent,
      hasVisualOverflow: mainAxisExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
      cacheExtent: cacheExtent,
    );
  }

  /// Getter and setter methods for the [color] and [mainAxisExtent] properties.

  /// The color used to paint the gap, if any.
  Color? get color => _color;

  /// The size of the gap along the main axis.
  double get mainAxisExtent => _mainAxisExtent;

  /// Updates the color of the gap and triggers a repaint if the color changes.
  set color(Color? value) {
    if (_color == value) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  /// Updates the size of the gap along the main axis and triggers a layout update if the size changes.
  set mainAxisExtent(double value) {
    if (_mainAxisExtent == value) {
      return;
    }
    _mainAxisExtent = value;
    markNeedsLayout();
  }
}
