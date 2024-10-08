// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: boolean_prefix, avoid-dynamic

import 'package:flutter/material.dart';

/// A widget which is not in the layout and does nothing.
/// It is useful when you have to return a widget and can't return null.
/// Use this widget to represent a non-existent widget, especially in conditional rendering.
class CoreNil extends Widget {
  /// Creates a [CoreNil] widget.
  const CoreNil({super.key});

  @override
  Element createElement() => _CoreNilElement(this);
}

class _CoreNilElement extends Element {
  _CoreNilElement(CoreNil super.widget);

  @override
  bool get debugDoingBuild => false;

  /// Mounts the element to the widget tree.
  /// Asserts that it is not used under a MultiChildRenderObjectElement to prevent improper use.
  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    assert(parent is! MultiChildRenderObjectElement, """
        You are using CoreNil under a MultiChildRenderObjectElement.
        This suggests a possibility that the CoreNil is not needed or is being used improperly.
        Make sure it can't be replaced with an inline conditional or
        omission of the target widget from a list.
        """);
  }

  @override
  void performRebuild() {
    super.performRebuild();
  }
}
