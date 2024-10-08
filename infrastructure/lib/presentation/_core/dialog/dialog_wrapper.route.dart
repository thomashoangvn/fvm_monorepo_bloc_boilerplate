import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/_core/dialog/dialog_config.dart';

/// A stateless widget that wraps a dialog configuration and content.
/// This is the actual dialog route that is passed into the `DialogBuilder`
/// for display.
@RoutePage()
class DialogWrapperRoute extends StatelessWidget {
  const DialogWrapperRoute({
    required this.builder,
    super.key,
    this.dialogConfig = const DialogConfig(),
  });

  /// Builds the widget (dialog content) when this route is pushed.
  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  /// The builder that provides the dialog content.
  final WidgetBuilder builder;

  /// Configuration settings for the dialog (such as barrier color, dismissibility, etc.).
  final DialogConfig dialogConfig;
}
