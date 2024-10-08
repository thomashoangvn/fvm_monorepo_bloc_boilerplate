// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//
// https://github.com/letsar/gap

part of '../gap.dart';

/// [GapRendering] is a custom render object that is responsible for rendering a gap
/// with a specified size in a layout. It works in conjunction with [Gap] or other
/// similar widgets that introduce gaps in the main or cross axis of a layout.
///
/// This class determines how to layout the gap, computes intrinsic dimensions,
/// and paints the gap with an optional color.
class GapRendering extends RenderBox {
  /// Creates a [GapRendering] instance with the required [mainAxisExtent], which is the size
  /// along the main axis. Optionally, a [color], [crossAxisExtent], and [fallbackDirection]
  /// can be provided.
  ///
  /// The [mainAxisExtent] should be non-negative and smaller than infinity. If
  /// [crossAxisExtent] is provided, it specifies the size of the gap along the cross axis.
  GapRendering({
    required double mainAxisExtent,
    Color? color,
    double? crossAxisExtent,
    Axis? fallbackDirection,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection;

  /// The size of the gap along the main axis (e.g., height in a vertical flex, width in a horizontal flex).
  double _mainAxisExtent;

  /// The color of the gap, if any.
  Color? _color;

  /// The size of the gap along the cross axis, if any.
  double? _crossAxisExtent;

  /// Fallback direction of the axis in case the gap is not placed inside a [Flex] widget.
  Axis? _fallbackDirection;

  /// Determines the layout of the gap, constraining the size based on the available constraints
  /// and the provided dimensions (main and cross axis extents).
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _direction;

    if (direction == null) {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget '
        'or its fallbackDirection must not be null',
      );
    }

    return direction == Axis.horizontal
        ? constraints.constrain(Size(mainAxisExtent, crossAxisExtent!))
        : constraints.constrain(Size(crossAxisExtent!, mainAxisExtent));
  }

  // Intrinsic dimension calculation methods for height and width, determining
  // how the gap behaves when the widget is queried for its intrinsic size.
  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
        Axis.vertical, () => super.computeMaxIntrinsicHeight(width))!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
        Axis.horizontal, () => super.computeMaxIntrinsicWidth(height))!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
        Axis.vertical, () => super.computeMinIntrinsicHeight(width))!;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
        Axis.horizontal, () => super.computeMinIntrinsicWidth(height))!;
  }

  /// Paints the gap with the specified color, if any.
  @override
  void paint(PaintingContext context, Offset offset) {
    if (color == null) {
      return;
    }

    final Paint paint = Paint()..color = color!;
    context.canvas.drawRect(offset & size, paint);
  }

  /// Lays out the gap based on the constraints provided by its parent widget.
  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  /// Determines the layout direction (main or cross axis) based on its parent widget.
  /// If the parent is a [RenderFlex], it will return the parent's direction.
  Axis? get _direction {
    final RenderObject? parentNode = parent;

    return parentNode is RenderFlex ? parentNode.direction : fallbackDirection;
  }

  // Getter and setter methods for various properties.
  Color? get color => _color;
  double? get crossAxisExtent => _crossAxisExtent;
  Axis? get fallbackDirection => _fallbackDirection;
  double get mainAxisExtent => _mainAxisExtent;

  set color(Color? value) {
    if (_color == value) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  set crossAxisExtent(double? value) {
    if (_crossAxisExtent == value) {
      return;
    }
    _crossAxisExtent = value;
    markNeedsLayout();
  }

  set fallbackDirection(Axis? value) {
    if (_fallbackDirection == value) {
      return;
    }
    _fallbackDirection = value;
    markNeedsLayout();
  }

  set mainAxisExtent(double value) {
    if (_mainAxisExtent == value) {
      return;
    }
    _mainAxisExtent = value;
    markNeedsLayout();
  }

  /// Helper method to compute intrinsic extents for height or width.
  double? _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final Axis? direction = _direction;
    if (direction == axis) {
      return _mainAxisExtent;
    }

    return _crossAxisExtent!.isFinite ? _crossAxisExtent : compute();
  }
}
