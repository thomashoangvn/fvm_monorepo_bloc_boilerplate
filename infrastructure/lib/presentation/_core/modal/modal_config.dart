// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// Configuration class that holds settings for modal dialog presentation.
/// This class is used by the `ModalBuilder` to apply specific configurations
/// when building a modal route.
class ModalConfig {
  const ModalConfig({
    this.isScrollControlled = true,
    this.barrierLabel,
  });

  /// Optional label for the barrier, used for accessibility.
  final String? barrierLabel;

  /// Specifies whether this is a route for a bottom sheet that will utilize [DraggableScrollableSheet].
  final bool isScrollControlled;
}
