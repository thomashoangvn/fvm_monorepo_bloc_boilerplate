// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';

/// A custom log class for handling debug-level logs using Talker.
///
/// The `DebugLog` class formats and logs debug information, including optional messages and data.
/// It is used for logging runtime details that help developers trace the flow of the application
/// during development or debugging sessions.
class DebugLog extends TalkerLog {
  DebugLog(this.data, [this.msg]) : super('');

  /// Data to be logged, can be any type (e.g., a variable or complex object).
  final dynamic data;

  /// An optional message to provide additional context to the logged data.
  final String? msg;

  /// Generates a debug log message, including formatted data and optional message.
  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createDebugLog();
  }

  /// Specifies the log level for this log, which is set to `debug`.
  @override
  LogLevel get logLevel => LogLevel.debug;

  /// Specifies the pen (color) used for formatting the debug log in the terminal.
  /// The color is set to a light gray (`xterm(15)`).
  @override
  AnsiPen get pen => AnsiPen()..xterm(15);

  /// Formats the current time as `HH:mm:ss.SSS` for inclusion in the log message.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates the formatted debug log message with data and optional message.
  ///
  /// This method formats the log message by including the data type, the data itself,
  /// and an optional message. It also includes the timestamp to indicate when the log was generated.
  String _createDebugLog() {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« DEBUG on $_formatTime »');

    // If data is present, format and log the data and its type.
    if (data != null) {
      final String formattedData = _formatData(data);
      stringBuffer
        ..writeln('• TYPE\t  ─►  ${data.runtimeType}')
        ..writeln('• DATA\t  ─►  $formattedData');
    }

    // If a message is provided, include it in the log output.
    if (msg != null) {
      stringBuffer.writeln('• MESSAGE   ─►  $msg');
    }

    return stringBuffer.toString();
  }

  /// Formats the data into a readable string.
  ///
  /// If the data is an iterable (e.g., a list or set), it joins the elements
  /// with commas. Otherwise, it converts the data to a string.
  String _formatData(dynamic value) {
    return value is Iterable ? value.join(', ') : data.toString();
  }
}
