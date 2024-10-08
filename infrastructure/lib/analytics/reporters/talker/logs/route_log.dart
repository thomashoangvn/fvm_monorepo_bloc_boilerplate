// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';

/// A custom log class for handling and logging route changes using Talker.
///
/// The `RouteLog` class formats and logs details about route changes (push and pop events)
/// in a Flutter app's navigation stack. It logs the route name, status (whether the route
/// was pushed or popped), and any arguments passed to the route.
class RouteLog extends TalkerLog {
  RouteLog({required this.route, this.isPush = true}) : super('');

  /// Indicates whether the route was pushed or popped.
  ///
  /// If `true`, the route was pushed onto the navigation stack. If `false`, the route was popped off.
  final bool isPush;

  /// The route that was pushed or popped.
  final Route<dynamic> route;

  /// Generates the log message for the route event, including route name, status, and arguments.
  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage();
  }

  /// Specifies the color of the log output.
  ///
  /// The color is set to a light green (`xterm(153)`).
  @override
  AnsiPen get pen => AnsiPen()..xterm(153);

  /// Formats the current time as `HH:mm:ss.SSS` for inclusion in the log message.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates the log message with route details, including the name, status, and any arguments passed to the route.
  String _createMessage() {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« ROUTER on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${route.settings.name ?? 'null'}')
      ..writeln('• STATUS\t─►  ${isPush ? 'Pushed' : 'Popped'}');

    // If arguments were passed to the route, include them in the log.
    final Object? args = route.settings.arguments;
    if (args != null) {
      stringBuffer.write('• ARGS\t  ─►  $args');
    }

    return stringBuffer.toString();
  }
}
