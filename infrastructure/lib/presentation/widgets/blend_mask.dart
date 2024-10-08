// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget that applies a blend mode and opacity to its child.
///
/// The [BlendMask] allows you to blend the child widget with its background
/// using a specified [BlendMode] and an optional [opacity] to adjust the effect.
///
/// The blend mode defines how the child content is composited with the
/// content behind it, while the [opacity] controls the transparency.
class BlendMask extends SingleChildRenderObjectWidget {
  const BlendMask({
    required BlendMode blendMode,
    required Widget super.child,
    super.key,
    double opacity = 1.0,
  })  : _blendMode = blendMode,
        _opacity = opacity;

  /// The blend mode to apply to the child widget.
  final BlendMode _blendMode;

  /// The opacity to apply to the child widget.
  ///
  /// The opacity should be a value between 0.0 and 1.0, where 1.0 means fully opaque.
  final double _opacity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCoreBlendMask(_blendMode, _opacity);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCoreBlendMask renderObject) {
    renderObject
      ..blendMode = _blendMode
      ..opacity = _opacity;
  }
}

/// A [RenderProxyBox] that applies a blend mode and opacity to its child.
///
/// This render object is used by the [BlendMask] widget to manage the
/// blending of the child content with its background using a given [BlendMode]
/// and [opacity].
class RenderCoreBlendMask extends RenderProxyBox {
  RenderCoreBlendMask(BlendMode blendMode, double opacity)
      : _blendMode = blendMode,
        _opacity = opacity;

  /// The blend mode used to composite the child with the background.
  BlendMode _blendMode;

  /// The opacity of the child widget.
  double _opacity;

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = _blendMode
        ..color = Color.fromARGB((_opacity * 255).round(), 255, 255, 255),
    );

    super.paint(context, offset);

    context.canvas.restore();
  }

  /// Gets the current blend mode.
  BlendMode get blendMode => _blendMode;

  /// Gets the current opacity.
  double get opacity => _opacity;

  /// Sets a new blend mode and repaints if necessary.
  set blendMode(BlendMode value) {
    if (_blendMode == value) {
      return;
    }

    _blendMode = value;
    markNeedsPaint();
  }

  /// Sets a new opacity value and repaints if necessary.
  set opacity(double value) {
    if (_opacity == value) {
      return;
    }

    _opacity = value;
    markNeedsPaint();
  }
}
