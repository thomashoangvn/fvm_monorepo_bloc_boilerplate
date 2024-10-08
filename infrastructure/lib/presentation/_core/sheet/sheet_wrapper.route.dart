// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// A wrapper widget for displaying content inside a sheet.
/// The content is passed via the [builder] parameter and wrapped in a [SafeArea].
class SheetWrapperRoute extends StatelessWidget {
  const SheetWrapperRoute({required this.builder, super.key});

  /// Builds the content of the sheet using the provided [builder] function.
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: builder(context));
  }

  /// The function that builds the content of the sheet.
  final WidgetBuilder builder;
}
